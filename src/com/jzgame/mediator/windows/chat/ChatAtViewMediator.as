package com.jzgame.mediator.windows.chat
{
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.model.UserModel;
	import com.jzgame.view.windows.chat.ChatAtView;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class ChatAtViewMediator extends StarlingMediator
	{
		/***********
		 * name:    ChatAtViewMediator
		 * data:    Jan 13, 2016
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:ChatAtView;
		[Inject]
		public var userModel:UserModel;
		public function ChatAtViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			SignalCenter.onChatAtTriggered.add(atTriggered);
			SignalCenter.onChatShowInputTriggered.add(showInputView);
			view.send.addEventListener(Event.TRIGGERED, sendHandler);
			view.clear.addEventListener(Event.TRIGGERED, clearHandler);
			view.returnBack.addEventListener(Event.TRIGGERED, returnHandler);
			var list:Array = [];
			
			for(var i:String in userModel.userList)
			{
				if(userModel.userList[i].userId != userModel.myInfo.userId)
				{
					var data:Object = new Object;
					data.id = userModel.userList[i].userId;
					data.fbId = userModel.userList[i].uFB_ID;
					data.name = userModel.userList[i].uNickName;
					list.push(data);
				}
			}
			
			view.setList(list);
		}
		
		override public function destroy():void
		{
			SignalCenter.onChatShowInputTriggered.remove(showInputView);
			SignalCenter.onChatAtTriggered.remove(atTriggered);
			view.returnBack.removeEventListener(Event.TRIGGERED, returnHandler);
			view.send.removeEventListener(Event.TRIGGERED, sendHandler);
			view.clear.removeEventListener(Event.TRIGGERED, clearHandler);
		}
		
		private function atTriggered(name:String):void
		{
			view.input.text = '@' + name;
		}
		
		private function clearHandler(e:Event):void
		{
			view.input.text = '';
		}
		
		private function sendHandler(e:Event):void
		{
			NetSendProxy.talk(userModel.myInfo.userId,view.input.text);
			
			view.removeFromParent(true);
		}
		
		private function returnHandler(e:Event):void
		{
			view.removeFromParent(true);
		}
		
		private function showInputView(word:String):void
		{
			view.removeFromParent(true);
		}
	}
}