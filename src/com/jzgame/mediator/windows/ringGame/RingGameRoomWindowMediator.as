package com.jzgame.mediator.windows.ringGame
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.enmu.EventType;
	import com.jzgame.events.HandleJoinTableEvent;
	import com.jzgame.model.RoomModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.signals.SignalJoinTable;
	import com.jzgame.util.NumUtil;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.ringGame.RingGameRoomWindow;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.events.Event;
	import flash.text.TextFormatAlign;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class RingGameRoomWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    RingGameRoomWindowMediator
		 * data:    Dec 11, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:RingGameRoomWindow;
		[Inject]
		public var roomModel:RoomModel;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var signalJoinTable:SignalJoinTable;
		public function RingGameRoomWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(EventType.UPDATE_ROOM_LIST,updateRoom);
			addContextListener(EventType.CHANGE_RING_GAME_TYPE,updateRoomType);
			view.tabBar.addEventListener(starling.events.Event.CHANGE, updateRoomList);
			view.packBtn.addEventListener(starling.events.Event.TRIGGERED, openPackHandler);
			
			SignalCenter.onJoinTableTriggered.add(joinTableTriggered);
			
			HttpSendProxy.getRoomList();
			
			view.myChips.text = HtmlTransCenter.getHtmlStr(
				HtmlTransCenter.getFontStr(LangManager.getText("500217")+':','b3a7db',22)
				+NumUtil.n2c(userModel.myInfo.uMoney.toNumber()),'dadada',22,"",TextFormatAlign.RIGHT);
		}
		
		override public function destroy():void
		{
			SignalCenter.onJoinTableTriggered.remove(joinTableTriggered);
			view.packBtn.removeEventListener(starling.events.Event.TRIGGERED, openPackHandler);
			view.tabBar.removeEventListener(starling.events.Event.CHANGE, updateRoomList);
			removeContextListener(EventType.UPDATE_ROOM_LIST,updateRoom);
			removeContextListener(EventType.CHANGE_RING_GAME_TYPE,updateRoomType);
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function openPackHandler(e:starling.events.Event):void
		{
			PopUpWindowManager.centerPopUpWindow(WindowFactory.addPopUpWindow(WindowFactory.PACK_WINDOW) as DisplayObject);
		}
		/**
		 * 改变索引 
		 * @param e
		 * 
		 */		
		private function updateRoomList(e:starling.events.Event):void
		{
			roomModel.current = roomModel.getMobileList(view.tabBar.selectedIndex);
			view.setList(roomModel.current);
		}
		
		private function joinTableTriggered(roomId:uint):void
		{
			view.closeWindow();
			
			AssetsCenter.eventDispatcher.dispatchEvent(new HandleJoinTableEvent(roomId.toString()));
//			signalJoinTable.dispatch(roomId);
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function updateRoomType(e:SimpleEvent):void
		{
			var type:String = String(e.carryData);
			var index:Number = Number(type);
			
			if(index > 0 && index < 3)
			{
				view.tabBar.selectedIndex = index - 1;
			}
		}
		
		/**
		 * 更新房间列表
		 * @param e
		 * 
		 */		
		private function updateRoom(e:flash.events.Event):void
		{
			if(view.tabBar.selectedIndex == -1)
			{
				var money:Number = userModel.myInfo.uMoney.toNumber();
				if(money >= roomModel.masterLimit)
				{
					view.tabBar.selectedIndex = 2;
				}else if(money>=roomModel.sharkLimit)
				{
					view.tabBar.selectedIndex = 1;
				}else
				{
					view.tabBar.selectedIndex = 0;
				}
			}else
			{
				updateRoomList(null);
			}
		}
	}
}