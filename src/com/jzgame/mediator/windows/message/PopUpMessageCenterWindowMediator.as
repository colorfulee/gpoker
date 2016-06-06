package com.jzgame.mediator.windows.message
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.message.MessageProxy;
	import com.jzgame.common.model.message.MessageProxyEvent;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.common.vo.MessageCenterVO;
	import com.jzgame.view.windows.message.PopUpMessageCenterWindow;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class PopUpMessageCenterWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpMessageCenterWindowMediator
		 * data:    Nov 26, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpMessageCenterWindow;
		[Inject]
		public var messageProxy:MessageProxy;
		public function PopUpMessageCenterWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.tabBar.selectedIndex = 0;
			
			addContextListener(MessageProxyEvent.UPDATE_MESSAGE,updateMessageList);
			view.allCheck.addEventListener(Event.CHANGE, updateCheck);
			view.read.addEventListener(Event.TRIGGERED, readHandler);
			view.dele.addEventListener(Event.TRIGGERED, deleHandler);
			SignalCenter.onShowMailItemSelected.add(updateSelectHandler);
			if(view.motionEffect)
			{
				view.addEventListener(Event.COMPLETE, startNet);
			}else
			{
				startNet(null);
			}
		}
		
		override public function destroy():void
		{
			view.read.removeEventListener(Event.TRIGGERED, readHandler);
			view.dele.removeEventListener(Event.TRIGGERED, deleHandler);
			view.allCheck.removeEventListener(Event.CHANGE, updateCheck);
			removeContextListener(MessageProxyEvent.UPDATE_MESSAGE,updateMessageList);
			SignalCenter.onShowMailItemSelected.remove(updateSelectHandler);
		}
		private function startNet(e:Event):void
		{
			HttpSendProxy.sendGetMessageList();
		}
		/**
		 * 
		 * @param id
		 * @param b
		 * 
		 */		
		private function updateSelectHandler(id:uint,b:Boolean):void
		{
			if(b)
			{
				messageProxy.selectArr.push(id);
			}else
			{
				for(var i:String in messageProxy.selectArr)
				{
					if(messageProxy.selectArr[i] == id)
					{
						messageProxy.selectArr.splice(i,1);
						return;
					}
				}
			}
		}
		/**
		 * 全选
		 * @param e
		 * 
		 */		
		private function updateCheck(e:Event):void
		{
			if(view.allCheck.isSelected)
			{
				messageProxy.selectArr = [];
				var all:Array = messageProxy.getAllMessages();
				for each(var item:MessageCenterVO in all)
				{
					messageProxy.selectArr.push(item.id);
				}
			}else
			{
				messageProxy.selectArr = [];
			}
			SignalCenter.onShowMailItemInfoSelected.dispatch(view.allCheck.isSelected);
		}
		/**
		 * 读取 
		 * @param e
		 * 
		 */		
		private function readHandler(e:Event):void
		{
			var temp:Array = messageProxy.selectArr;
			if(temp.length>0)
			{
				HttpSendProxy.sendProcessMessage(temp);
				view.allCheck.isSelected = false;
			}
		}
		/**
		 * 删除 
		 * @param e
		 * 
		 */		
		private function deleHandler(e:Event):void
		{
//			var length:uint = view.messageList.dataProvider.length;
//			var arr:Array = var temp:Array = view.getSelectList();;
//			var bonus:Boolean = false;
//			for(var i:uint = 0; i<length;i++)
//			{
//				var data:MessageCenterVO = view.messageList.dataProvider[i];
//				var item:MessageListItem = view.messageList.getItemAt(i+1,1) as MessageListItem;
//				if(item.isSelect && data.status !=MessageCenterVO.REMOVE)
//				{
//					if(data.status == MessageCenterVO.NORMAL)
//					{
//						if(data.bonus && data.bonus != "")
//						{
//							bonus = true;
//						}
//						
//						if(data.type == MessageProxy.SEND_GIFT)
//						{
//							bonus = true;
//						}
//					}
//					arr.push(data.id);
//				}
//			}
			
			var temp:Array = messageProxy.selectArr;
			if(temp.length > 0)
			{
				sureDelete();
				view.allCheck.isSelected = false;
			}
//			if(bonus)
//			{
//				if(messageProxy.selectArr.length > 0)
//				{
//					var tips:String = LangManager.getText("300413");
//					feathers.controls.Alert.show(tips,"alert",new ListCollection([{label:"ok",triggered:sureDelete},{label:'cancel'}]));
//				}
//			}else
//			{
//				if(messageProxy.selectArr.length > 0)
//				{
//					sureDelete();
//				}
//			}
		}
		/**
		 * 
		 * 确认删除 
		 * 
		 */
		private function sureDelete():void
		{
			HttpSendProxy.sendDelMessage(messageProxy.selectArr);
			messageProxy.selectArr = [];
		}
		
		/**
		 * 更新消息列表
		 * @param e
		 * 
		 */		
		private function updateMessageList(e:MessageProxyEvent):void
		{
			view.setList(messageProxy.getAllMessages())
		}
	}
}