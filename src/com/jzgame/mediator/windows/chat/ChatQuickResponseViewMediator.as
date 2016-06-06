package com.jzgame.mediator.windows.chat
{
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.model.UserModel;
	import com.jzgame.view.windows.chat.ChatQuickResponseView;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	public class ChatQuickResponseViewMediator extends StarlingMediator
	{
		/***********
		 * name:    ChatQuickResponseViewMediator
		 * data:    Jan 12, 2016
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:ChatQuickResponseView;
		[Inject]
		public var userModel:UserModel;
		public function ChatQuickResponseViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			SignalCenter.onChatQuickWordTriggered.add(sendQuick);
			var list:Array = [];
			for(var index:uint = 0;index < 9;index++)
			{
				list.push( LangManager.getText(String(401801 + index)) );
			}
			
			view.setList(list);
		}
		
		override public function destroy():void
		{
			SignalCenter.onChatQuickWordTriggered.remove(sendQuick);
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function sendQuick(word:String):void
		{
			NetSendProxy.talk(userModel.myInfo.userId,String(word));
		}
	}
}