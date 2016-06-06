package com.jzgame.mediator.windows.friends
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.gameFriends.GameFriendsProxy;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.GameModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.friends.PopUpFriendsWindow;
	
	import flash.events.Event;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class PopUpFriendsWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpFriendsWindowMediator
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpFriendsWindow;
		[Inject]
		public var gameFriendsProxy:GameFriendsProxy;
		[Inject]
		public var gameModel:GameModel;
		public function PopUpFriendsWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			SignalCenter.onShowFriendInfoTriggered.add(showInfo);
			addContextListener(EventType.UPDATE_ONLINE_FRIEND,updateOnLine);
			
			if(view.motionEffect)
			{
				view.addEventListener(starling.events.Event.COMPLETE, startNet);
			}else
			{
				startNet(null);
			}
		}
		
		override public function destroy():void
		{
			SignalCenter.onShowFriendInfoTriggered.remove(showInfo);
			removeContextListener(EventType.UPDATE_ONLINE_FRIEND,updateOnLine);
		}
		
		private function startNet(e:starling.events.Event):void
		{
			//更新在线状态
			HttpSendProxy.sendONlineList();
		}
		
		private function updateOnLine(e:flash.events.Event):void
		{
			var list:Array = gameFriendsProxy.getAllFriendsInvite();
			
			view.setList(list);
		}
		
		private function showInfo(id:String):void
		{
			gameModel.tipUserId = uint(id);
			WindowFactory.addPopUpWindow(WindowFactory.PLAYER_INFO_WINDOW);
		}
	}
}