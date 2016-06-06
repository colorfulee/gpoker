package com.jzgame.common.model.message
{
	import com.jzgame.common.vo.MessageCenterVO;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * 保存消息
	 * @author Rakuten
	 * 
	 */
	public class MessageProxy
	{
		public static var ADD_FRIEND:uint = 901;
		public static var SEND_GIFT:uint = 902;
		public static var ASK_GIFT:uint = 903;
		public static var GLOBAL_MESSAGE:uint = 904;
		public static var CASH_BUY:uint = 905;
		public static var MTT_SIGN_IN:uint = 906;
		public static var MTT_RESULT:uint = 907;
		public static var UPDATE_GIFT:uint = 908;
		public static var PRIZE_TODO:uint = 909;
		public static var INVITE_ROUND:uint = 910;
		public static var MTT_START:uint = 911;
		public static var JACK_POT_PRIZE:uint = 913;
		public static var SPE_MTT_START:uint = 914;
		public static var SPE_MTT_SIGN_IN:uint = 916;
		public static var SPE_MTT_RESULT:uint = 915;
		//选中id列表
		public var selectArr:Array = [];
		private var messageArr:Array = [];
		private var buddy:Array = [];
		private var global:Array = [];
		private var payment:Array = [];
		
		private var _current:Array = [];
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		public function MessageProxy()
		{
		}
		
		public var message:int=1;
		public var messagePage:int=1;
		
		/**
		 * 设置当前列表 
		 * @param value
		 * 
		 */		
		public function set current(value:Array):void
		{
			_current = value;
		}
		
		public function get current():Array
		{
			return _current.concat();
		}
		
		/**
		 * 添加消息 
		 * @param arr
		 * 
		 */	
		public function addMessages(arr:Array):void
		{
			messageArr = messageArr.concat(arr);
			//根据时间倒序排序
//			messageArr.sortOn("happenTime",Array.DESCENDING);
//			buddy.sortOn("happenTime",Array.DESCENDING);
//			global.sortOn("happenTime",Array.DESCENDING);
//			payment.sortOn("happenTime",Array.DESCENDING);
			//如果本人没有消息也要更新
			updateNotify();
		}
		/**
		 * 添加好友消息 
		 * @param message
		 * 
		 */	
		public function addBuddy(message:MessageCenterVO):void
		{
			buddy.push(message);
		}
		/**
		 * 获取好友消息 
		 * @return 
		 * 
		 */	
		public function getBuddy():Array
		{
			return buddy.concat();
		}
		/**
		 * 添加系统消息 
		 * @param message
		 * 
		 */	
		public function addGlobal(message:MessageCenterVO):void
		{
			global.push(message);
		}
		/**
		 * 获取系统消息 
		 * @return 
		 * 
		 */	
		public function getGlobal():Array
		{
			return global.concat();
		}
		/**
		 * 添加支付消息 
		 * @param message
		 * 
		 */	
		public function addPay(message:MessageCenterVO):void
		{
			payment.push(message);
		}
		/**支付系统消息 
		 * @return 
		 * 
		 */	
		public function getPay():Array
		{
			return payment.concat();
		}
		
		private function messageFilterHandler(element:*, index:int, arr:Array):Boolean
		{
			return (MessageCenterVO(element).id != filterTargetId)
		}
		
		private var filterTargetId:String = "";
		/**
		 * 删除消息 
		 * @param msgId
		 * 
		 */	
		public function removeMessage(msgId:String):void
		{
			filterTargetId = msgId;
			messageArr = messageArr.filter(messageFilterHandler);
		}
		/**
		 * 清空消息 
		 * 
		 */	
		public function removeAll():void
		{
			messageArr.splice(0);
			buddy.splice(0);
			global.splice(0);
			payment.splice(0);
			current = [];
		}
		/**
		 * 获取所有消息 
		 * @return 
		 * 
		 */	
		public function getAllMessages():Array
		{
			return messageArr.concat();
		}
		/**
		 * 根据id获取消息 
		 * @param msgId
		 * @return 
		 * 
		 */		
		public function getMessageById(msgId:String):MessageCenterVO
		{
			for(var index:String in messageArr)
			{
				if(MessageCenterVO(messageArr[index]).id == msgId)
				{
					return MessageCenterVO(messageArr[index]);
				}
			}
			return null;
		}
		
		/**
		 * 因UI组件不能单条更新，所以只能使用统一通知方式 
		 */	
		public function updateNotify():void
		{
			var all:uint = 0;
			var buddy:uint = 0;
			var globalNum:uint = 0;
			var payNum:uint = 0;
			for each(var vo:MessageCenterVO in messageArr)
			{
				switch(vo.type)
				{
					//901 好友请求
					case MessageProxy.ADD_FRIEND:
					case MessageProxy.ASK_GIFT:
					case MessageProxy.SEND_GIFT:
						if(vo.status == MessageCenterVO.NORMAL)
						{
							buddy++;
						}
						break;
					case MessageProxy.GLOBAL_MESSAGE:
					case MessageProxy.MTT_SIGN_IN:
					case MessageProxy.MTT_RESULT:
					case MessageProxy.UPDATE_GIFT:
					case MessageProxy.PRIZE_TODO:
					case MessageProxy.MTT_START:
					case MessageProxy.SPE_MTT_START:
					case MessageProxy.JACK_POT_PRIZE:
						if(vo.status == MessageCenterVO.NORMAL)
						{
							globalNum++;
						}
						break;
					case MessageProxy.CASH_BUY:
						if(vo.status == MessageCenterVO.NORMAL)
						{
							payNum++;
						}
						break;
				}
			}
			
			all = buddy + globalNum + payNum;
			eventDispatcher.dispatchEvent(new MessageProxyEvent(MessageProxyEvent.UPDATE_MESSAGE,[all,buddy,globalNum,payNum]));
		}
	}
}
