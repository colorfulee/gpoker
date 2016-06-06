package com.jzgame.common.model
{
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.protobuff.LoginRequest;
	import com.jzgame.common.services.protobuff.OpenCountDownBoxRequest;
	import com.jzgame.common.services.protobuff.SitDownRequest;
	import com.jzgame.common.services.protobuff.UseInteractiveItemRequest;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.events.communication.NetSendEvent;
	import com.netease.protobuf.Int64;
	
	import flash.utils.ByteArray;

	public class SocketSendProxy
	{
		/*auther     :jim
		* file       :SocketSendProxy.as
		* date       :Feb 9, 2015
		* description:socket 通讯代理
		*/
		public function SocketSendProxy()
		{
		}
		/**
		 * 发送socket心跳 
		 * 
		 */		
		public static function sendHeart():void
		{
			var sitByte:ByteArray = new ByteArray;
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(0,sitByte));
		}
		/**
		 * 领取在线奖励 
		 * 
		 */		
		public static function sendOnlineReward():void
		{
			var boxs:OpenCountDownBoxRequest = new OpenCountDownBoxRequest;
			var bytest:ByteArray = new ByteArray;
			boxs.writeTo(bytest);
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.OPEN_COUNT_DOWN_BOX_REQUEST,bytest));
		}
		/**
		 * 表情互动 
		 * @param item
		 * @param toSeatId
		 * 
		 */		
		public static function sendAnimation(item:uint,toSeatId:uint):void
		{
			var sitByte:ByteArray = new ByteArray;
			var sit:UseInteractiveItemRequest  = new UseInteractiveItemRequest;
			sit.itemid = item;
			sit.targetseatid = toSeatId;
			sit.writeTo(sitByte);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.USE_INTERACTIVE_ITEM_REQUEST,sitByte));
		}
		/**
		 * 登录桌子 
		 * @param tableid
		 * @param userId
		 * 
		 */		
		public static function joinTable(tableid:int,userId:int):void
		{
			var loginByte:ByteArray = new ByteArray;
			var login:LoginRequest = new LoginRequest;
			login.tableid = tableid;
			login.uid = userId;
			//			if(ExternalVars.gateway)
			//			{
			//				login.token = userModel.toking;
			//			}else
			{
				login.token = "1";
			}
			login.writeTo(loginByte);
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_LOGIN_TABLE,loginByte));
		}
		/**
		 * 坐下打牌 
		 * @param seat
		 * @param chips
		 * 
		 */		
		public static function sitDown(seat:uint,chips:Int64,autoBuy:Boolean):void
		{
			var sitByte:ByteArray = new ByteArray;
			var sit:SitDownRequest = new SitDownRequest;
			sit.seatid = seat;
			sit.chips = (chips);
			sit.autobuy = autoBuy;
			sit.writeTo(sitByte);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_SIT_DOWN,sitByte));
		}
//		
//		public static function joinTable():void
//		{
//			
//		}
	}
}