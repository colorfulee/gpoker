package com.jzgame.mediator.windows.chat
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.services.protobuff.TalkerType;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.chat.ChatView;
	import com.jzgame.vo.ChatMessageVO;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class ChatViewMediator extends StarlingMediator
	{
		/***********
		 * name:    ChatViewMediator
		 * data:    Jan 11, 2016
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:ChatView;
		[Inject]
		public var userModel:UserModel;
		public function ChatViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.chatBtn.addEventListener(Event.TRIGGERED, openDetailHandler);
			addContextListener(EventType.CHAT,chatHandler);
			addContextListener(EventType.SEND_PRIVATE_CHAT,sendPrivateChatHandler);
		}
		
		override public function destroy():void
		{
			view.chatBtn.removeEventListener(Event.TRIGGERED, openDetailHandler);
			removeContextListener(EventType.CHAT,chatHandler);
			removeContextListener(EventType.SEND_PRIVATE_CHAT,sendPrivateChatHandler);
		}
		/**
		 * 收到聊天消息
		 * @param e
		 * 
		 */		
		private function chatHandler(e:SimpleEvent):void
		{
			var chatVO:ChatMessageVO = e.carryData as ChatMessageVO;
			if(chatVO.anim == 0)
			{
				for(var index:String in userModel.mutePlayerList)
				{
					//是否禁言
					if(userModel.mutePlayerList[index] == chatVO.uid)
					{
						return;
					}
				}
				if(chatVO.type == TalkerType.SYSTEM)
				{
					var data:Array = [chatVO.uid.toString()];
					data=data.concat(chatVO.content.split(","));
					
					view.receiveMessage(chatVO.name,LangManager.getText.apply(this,data));
				}else
				{
					view.receiveMessage(chatVO.name,chatVO.content);
				}
			}
		}
		/**
		 * 发起私聊
		 * @param e
		 * 
		 */
		private function sendPrivateChatHandler(e:SimpleEvent):void
		{
//			var nameObj:Object=e.data;
//			if(nameObj && nameObj.name)
//			{
//				var sendStr:String="["+nameObj.name+"]:";
//				if(view.inputEditManager)
//				{
//					view.inputEditManager.selectAll();
//					view.inputEditManager.deleteText();
//					view.inputEditManager.selectRange(0,0);
//					view.inputEditManager.insertText(sendStr);
//					view.stage.focus=view.inputTextContainer;
//				}
//			}
		}
		/**
		 * 打开详细界面 
		 * @param e
		 */		
		private function openDetailHandler(e:Event):void
		{
			WindowFactory.addPopUpWindow(WindowFactory.CHAT_DETAIL_WINDOW);
		}
	}
}