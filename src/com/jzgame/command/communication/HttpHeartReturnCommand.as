package com.jzgame.command.communication
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.message.MessageProxy;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.vo.MessageCenterVO;
	import com.jzgame.enmu.EventType;
	import com.jzgame.events.HandleJoinTableEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import starling.events.Event;
	
	public class HttpHeartReturnCommand extends Command
	{
		/*auther     :jim
		* file       :HttpHeartReturnCommand.as
		* date       :Dec 2, 2014
		* description:
		*/
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var message:MessageProxy;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var userModel:UserModel;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		public function HttpHeartReturnCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var result:Object = event.data["s"]
			if(result)
			{
				var userInfo:Object = result["user_info"];
				if(userInfo)
				{
					userModel.updateInfo(userInfo,"");
				}
				
				var notify:Object = result["champion_info"];
				if(notify)
				{
					var b:Boolean = notify.is_notify;
					if(b)
					{
						if(gameModel.inTable)
						{
//							var alertmessage:MessageAlertVO = new MessageAlertVO(LangManager.getText("202018"),null,Alert.OK);
//							alertmessage.say = LangManager.getText("402217",notify.name);
//							alertmessage.fb_id = notify.fb_id;
//							gameModel.messageList.push(alertmessage);
//							WindowFactory.addPopUpWindow(WindowFactory.MESSAGE_ALERT_WINDOW);
						}else
						{
							WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("402217",notify.name));
						}
					}
				}
				
				
				var message:Object = result["message"];
				var unread:uint = 0;
				if(message)
				{
					var json:Object = new Object;
					var vo:MessageCenterVO;
					for(var uuid:String in message)
					{
						json = message[uuid];
						vo = new MessageCenterVO;
						vo.type = json.type;
						vo.fromUid = json.source_uid;
						vo.uid = json.uid;
						vo.myName = userModel.myInfo.uNickName;
						vo.id = uuid;
						vo.happenTime = json.time;
						vo.status = json.status;
						//如果已经删除的不显示
						if(vo.status == MessageCenterVO.REMOVE )continue;
						switch(vo.type)
						{
							case MessageProxy.INVITE_ROUND:
								//						"fb_id":"xxx",          # 请求人的fb_id
								//						"fb_first_name":"xxx",        # 请求人的fb_name
								//						"fb_last_name":"xxx",        # 请求人的fb_name
								//						"table_id":"10101",     # table ID
								//						"table_name":"Shanghai" # table name
								
								vo.fb_id = json.data.fb_id;
//								vo.name = json.data.fb_first_name + " "+json.data.fb_last_name;
								vo.name = json.data.fb_name;
								vo.tableId = json.data.table_id;
								vo.tableName = json.data.table_name;
								HttpSendProxy.sendDelMessage([vo.id]);
								var des:String = LangManager.getText("202305",vo.name,vo.tableName);
								if(gameModel.inTable)
								{
//									WindowFactory.addPopUpWindow(WindowFactory.INVITE_FRIEND_TABLE,null,vo.tableId,des);
								}else
								{
									var alert:Alert = Alert.show(des,LangManager.getText('500260'),new ListCollection([{label:'ok',tableId:vo.tableId},{label:'cancel'}]));
									alert.addEventListener( starling.events.Event.CLOSE, alert_closeHandler );
//									WindowFactory.showAlert(des,Alert.OK + Alert.CANCEL,sureJoin,vo.tableId);
								}
								break;
							default:
								if(vo.status == MessageCenterVO.NORMAL )
								{
									unread++;
								}
								break;
						}
						
					}
					
					if(unread > 0)
					{
						eventDispatcher.dispatchEvent(new flash.events.Event(EventType.SHOW_MESSAGE_RED_ICON));
					}else
					{
						eventDispatcher.dispatchEvent(new flash.events.Event(EventType.HIDE_MESSAGE_RED_ICON));
					}
				}

				if(result["task"] && int(result["task"])==1)
				{
					eventDispatcher.dispatchEvent(new flash.events.Event(EventType.SHOW_TASK_RED_ICON));
				}
				else
				{
					eventDispatcher.dispatchEvent(new flash.events.Event(EventType.HIDE_TASK_RED_ICON));
				}
			}
		}
		/**
		 * 点击确定
		 * @param event
		 * @param data
		 * 
		 */		
		private function alert_closeHandler(event:starling.events.Event, data:Object):void
		{
			event.target.removeEventListener(starling.events.Event.CLOSE, alert_closeHandler);
			if(data.label == "ok")
			{
				AssetsCenter.eventDispatcher.dispatchEvent(new HandleJoinTableEvent(data.tableId));
			}
		}
	}
}