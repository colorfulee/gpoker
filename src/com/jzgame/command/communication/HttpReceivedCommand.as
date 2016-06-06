package com.jzgame.command.communication
{
	import com.jzgame.common.model.achiement.AchiementProxy;
	import com.jzgame.common.model.gameFriends.GameFriendsProxy;
	import com.jzgame.common.services.http.HttpResponse;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.BuffModel;
	import com.jzgame.model.MTTAttendModel;
	import com.jzgame.model.PackageModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HttpReceivedCommand extends Command
	{
		/*auther     :jim
		* file       :HttpReceivedCommand.as
		* date       :Jan 14, 2015
		* description:接受到消息统一处理
		*/
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var eventDisp:IEventDispatcher;
		[Inject]
		public var pack:PackageModel;
		[Inject]
		public var user_info:UserModel;
		[Inject]
		public var buff:BuffModel;
		[Inject]
		public var mtt_attend:MTTAttendModel;
//		[Inject]
//		public var spec_mtt_attend:SpeMTTAttendModel;
		[Inject]
		public var achievement:AchiementProxy;
		[Inject]
		public var game_friends:GameFriendsProxy;
		private var errCodeList:Array = ["15155124","4043083"];
		public function HttpReceivedCommand()
		{
			super();
		}
		
		private function containsCode(err:String):Boolean
		{
			for(var i:String in errCodeList)
			{
				if(errCodeList[i] == err)
				{
					return true;
				}
			}
			
			return false;
		}
		
		
		override public function execute():void
		{
			WindowFactory.hideCommuWindow();
			
			var responseData:HttpResponse = event.data as HttpResponse;
			//如果有error信息
			if(uint(responseData.e) > 0)
			{
				if(containsCode(responseData.e))
				{
					Tracer.info("=====http refresh error=====:"+responseData.e);
					
					Alert.show(LangManager.getText(String(responseData.e)),"error!",new ListCollection([{label:"ok"}]));
//					WindowFactory.showAlert(,Alert.,function ():void{ExternalCenter.refresh()});
					
					Tracer.info("=====http x error=====:"+responseData.e);
					
					eventDisp.dispatchEvent(new Event(EventType.STOP_GAME));
					Tracer.info("=====http xx error=====:"+responseData.e);
				}else
				{
					//如果语言包里没有配置
					var text:String = LangManager.getText(String(responseData.e));
					if(text.indexOf(String(responseData.e))==-1)
					{
						Alert.show(text,"error!",new ListCollection([{label:"ok"}]))
					}else
					{
						//如果直接返回error信息
						if(responseData.hasOwnProperty("m"))
						{
							Tracer.info("=====http message error=====:"+responseData.m);
							Alert.show((String(responseData.m)),"error!",new ListCollection([{label:"ok"}]))
						}else
						{
							Alert.show(LangManager.getText((responseData.e)),"error!",new ListCollection([{label:"ok"}]))
						}
					}
				}
				
			}else
			{
				//如果直接返回error信息
				if(responseData.hasOwnProperty("m"))
				{
					Tracer.info("=====http error=====:"+responseData.m);
					Alert.show(LangManager.getText((responseData.e)),"error!",new ListCollection([{label:"ok"}]))
				}else
				{
					//需要同步的值
					if(responseData.hasOwnProperty("s"))
					{
						var obj:Object = responseData["s"];
						for(var index:String in obj)
						{
							if(this.hasOwnProperty(index))
							{
								//如果有两个参数,第二个是接口名字
								if(this[index].updateInfo.length == 2)
								{
									(this[index].updateInfo).apply(null,[obj[index],event.request.name])
								}else
								{
									this[index].updateInfo(obj[index]);
								}
							}
						}
					}
				}
			}
		}
	}
}