package com.jzgame.mediator.windows.chat
{
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.model.UserModel;
	import com.jzgame.view.windows.chat.ChatAnimView;
	import com.jzgame.vo.ChatMessageVO;
	
	import feathers.data.ListCollection;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class ChatAnimViewMediator extends StarlingMediator
	{
		/***********
		 * name:    ChatAnimViewMediator
		 * data:    Jan 12, 2016
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:ChatAnimView;
		[Inject]
		public var userModel:UserModel;
		public function ChatAnimViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.tabBar.addEventListener(Event.CHANGE, tabBarHandler);
			SignalCenter.onChatAnimItemTriggered.add(anim);
			view.tabBar.selectedIndex = 0;
		}
		
		override public function destroy():void
		{
			SignalCenter.onChatAnimItemTriggered.remove(anim);
			view.tabBar.removeEventListener(Event.CHANGE, tabBarHandler);
		}
		
		private function tabBarHandler(e:Event):void
		{
			switch(view.tabBar.selectedIndex)
			{
				case 0:
					view.animList.dataProvider = new ListCollection([1,2,3,4,5,6,7,8,9,10,11,12]);
//					view.animList.dataProvider = new ListCollection([1,1,1,1,1,1,1,1,1,1,1,1]);
					break;
				case 1:
					break;
			}
		}
		/**
		 * 表情 
		 * @param index
		 * 
		 */		
		private function anim(index:String):void
		{
			NetSendProxy.talk(userModel.myInfo.userId,ChatMessageVO.CHAT_ANIM+index);
		}
	}
}