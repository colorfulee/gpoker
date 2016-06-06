package com.jzgame.mediator.windows.chat
{
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.model.UserModel;
	import com.jzgame.view.windows.chat.ChatAnimView;
	import com.jzgame.view.windows.chat.ChatDetailView;
	import com.jzgame.view.windows.chat.ChatQuickResponseView;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class ChatDetailViewMediator extends StarlingMediator
	{
		/***********
		 * name:    ChatDetailViewMediator
		 * data:    Jan 11, 2016
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:ChatDetailView;
		[Inject]
		public var userModel:UserModel;
		public function ChatDetailViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			SignalCenter.onChatShowInputTriggered.add(showInputView);
			view.tabBar.addEventListener(Event.CHANGE, tabBarChangeHandler);
			view.send.addEventListener(Event.TRIGGERED, sendHandler);
			SignalCenter.onChatQuickWordTriggered.add(sendQuick);
			
			view.tabBar.selectedIndex = 0;
		}
		
		override public function destroy():void
		{
			SignalCenter.onChatShowInputTriggered.remove(showInputView);
			view.send.removeEventListener(Event.TRIGGERED, sendHandler);
			view.tabBar.removeEventListener(Event.CHANGE, tabBarChangeHandler);
			SignalCenter.onChatQuickWordTriggered.remove(sendQuick);
		}
		
		private function tabBarChangeHandler(e:Event):void
		{
			if(view.container.numChildren > 0)
			{
				view.container.getChildAt(0).removeFromParent(true);
			}
			switch(view.tabBar.selectedIndex)
			{
				case 0:
					view.container.addChild(new ChatAnimView());
					break;
				case 1:
					view.container.addChild(new ChatQuickResponseView());
					break;
				case 2:
//					view.addChild();
					break;
			}
		}
		/**
		 * 快速回复 
		 * @param words
		 * 
		 */		
		private function sendQuick(words:String):void
		{
			view.closeWindow();
		}
		
		private function sendHandler(e:Event):void
		{
			NetSendProxy.talk(userModel.myInfo.userId,view.input.text);
			
			view.closeWindow();
		}
		
		private function showInputView(words:String):void
		{
			view.closeWindow();
		}
	}
}