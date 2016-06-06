package com.jzgame.modules.friends
{
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindowManager;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class FriendsInfoViewMediator extends StarlingMediator
	{
		/***********
		 * name:    FriendsInfoViewMediator
		 * data:    Nov 16, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:FriendsInfoView;
		public function FriendsInfoViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.invite.addEventListener(Event.TRIGGERED, inviteFriend);
		}
		
		override public function destroy():void
		{
			view.invite.removeEventListener(Event.TRIGGERED, inviteFriend);
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function inviteFriend(e:Event):void
		{
			PopUpWindowManager.centerPopUpWindow(WindowFactory.addPopUpWindow(WindowFactory.ACHIEVE_WINDOW) as DisplayObject);
		}
	}
}