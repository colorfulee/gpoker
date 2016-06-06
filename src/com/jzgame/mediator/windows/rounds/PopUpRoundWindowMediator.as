package com.jzgame.mediator.windows.rounds
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.model.PreRoundInfoModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.view.windows.rounds.PopUpRoundWindow;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class PopUpRoundWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpRoundWindowMediator
		 * data:    Dec 14, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpRoundWindow;
		[Inject]
		public var round:PreRoundInfoModel;
		[Inject]
		public var userModel:UserModel;
		public function PopUpRoundWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.tabBar.addEventListener(Event.CHANGE, updateList);
			addContextListener(MessageType.MESSAGE_GET_PLAY_RECORD,updateHandler,HttpResponseEvent);
			//获取列表
			HttpSendProxy.getPlayRecord();
		}
		
		override public function destroy():void
		{
			view.tabBar.removeEventListener(Event.CHANGE, updateList);
			removeContextListener(MessageType.MESSAGE_GET_PLAY_RECORD,updateHandler,HttpResponseEvent);
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function updateList(e:Event):void
		{
			switch(view.tabBar.selectedIndex)
			{
				case 0:
					view.setList(round.getTimeList());
					break;
				case 1:
					view.setList(round.getBonusList());
					break;
			}
		}
		/**
		 * 更新数据 
		 * @param e
		 * 
		 */		
		private function updateHandler(e:HttpResponseEvent):void
		{
			if(e.result)
			{
				round.prase(e.result,userModel.myInfo.userId);
				view.tabBar.selectedIndex = 0;
			}
		}
	}
}