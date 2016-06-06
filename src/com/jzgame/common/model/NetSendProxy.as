package com.jzgame.common.model
{
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.protobuff.BetJackPotRequest;
	import com.jzgame.common.services.protobuff.GiveMoneyRequest;
	import com.jzgame.common.services.protobuff.GlobalMessageRequest;
	import com.jzgame.common.services.protobuff.InteractiveEvent;
	import com.jzgame.common.services.protobuff.InviteFriendRequest;
	import com.jzgame.common.services.protobuff.JoinTournamentRequest;
	import com.jzgame.common.services.protobuff.LoginRequest;
	import com.jzgame.common.services.protobuff.PlayerExitRequest;
	import com.jzgame.common.services.protobuff.ShowHoleCardsRequest;
	import com.jzgame.common.services.protobuff.ShowObserversRequest;
	import com.jzgame.common.services.protobuff.TalkingRequest;
	import com.jzgame.common.services.protobuff.TournamentType;
	import com.jzgame.common.services.protobuff.UseInteractiveItemRequest;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.events.communication.NetSendEvent;
	
	import flash.utils.ByteArray;

	public class NetSendProxy
	{
		/*auther     :jim
		* file       :NetSendProxy.as
		* date       :Apr 2, 2015
		* description:socket 通讯代理
		*/
		public function NetSendProxy()
		{
		}
		/**
		 * SPEMTT 进入
		 * 
		 * @param userId
		 * @param obv
		 * @param target
		 * 
		 */		
		public static function joinSPEMTT(userId:uint,obv:Boolean=false,target:uint = 0):void
		{
			var mtt:JoinTournamentRequest = new JoinTournamentRequest;
			mtt.token = ExternalVars.token;
			mtt.uid = userId;
			mtt.targetid = target;
			mtt.type = TournamentType.SPEC_MULTI_TABLE;
			mtt.isobserver = obv;
			var mttByte:ByteArray = new ByteArray;
			mtt.writeTo(mttByte);
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_JOIN_MTT,mttByte));
		}
		/**
		 * MTT 进入
		 * 
		 * @param userId
		 * @param obv
		 * @param target
		 * 
		 */		
		public static function joinMTT(userId:uint,obv:Boolean=false,target:uint = 0):void
		{
			var mtt:JoinTournamentRequest = new JoinTournamentRequest;
			mtt.token = ExternalVars.token;
			mtt.uid = userId;
			mtt.targetid = target;
			mtt.type = TournamentType.MULTI_TABLE;
			mtt.isobserver = obv;
			var mttByte:ByteArray = new ByteArray;
			mtt.writeTo(mttByte);
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_JOIN_MTT,mttByte));
		}
		/**
		 * 站起来 
		 * @param e
		 * 
		 */	
		public static function standUp(userId:uint):void
		{
			var sitByte:ByteArray = new ByteArray;
			var stand:PlayerExitRequest = new PlayerExitRequest;
			stand.userid = userId;
			stand.isStandUp = 1;
			stand.writeTo(sitByte);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_STAND_UP,sitByte));
		}
		/**
		 * 回大厅 
		 * @param e
		 * 
		 */	
		public static function leaveTable(userId:uint):void
		{
			var sitByte:ByteArray = new ByteArray;
			var stand:PlayerExitRequest = new PlayerExitRequest;
			stand.userid = userId;
			stand.isStandUp = 0;
			stand.writeTo(sitByte);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_STAND_UP,sitByte));
			
//			AssetsCenter.eventDispatcher(new Event(EventType.RETURN_LOBBY));
		}
		/**
		 * 加入桌子 
		 * @param tableId
		 * @param userId
		 * 
		 */		
		public static function joinTable(tableId:int,userId:int):void
		{
			var loginByte:ByteArray = new ByteArray;
			var login:LoginRequest = new LoginRequest;
			login.tableid = tableId;
			login.uid = userId;
			login.token = ExternalVars.token;
			login.writeTo(loginByte);
			
			Tracer.info(userId+":登陆桌子:");
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_LOGIN_TABLE,loginByte));
		}
		/**
		 * 聊天 
		 * @param uid
		 * @param content
		 * 
		 */		
		public static function talk(uid:int,content:String):void
		{
			var talkE:TalkingRequest = new TalkingRequest;
			talkE.content = content;
			talkE.type = 0;
			talkE.userid = uid;
			var bytest:ByteArray = new ByteArray;
			talkE.writeTo(bytest);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_CHAT,bytest));
		}
		/**
		 * 交互行为
		 * @param eid
		 * @param myseatId
		 * @param targetSeat 目标人物座位,0为荷官
		 * 
		 */			
		public static function interEvent(eid:int,myseatId:int,targetSeat:uint = 0):void
		{
			var talkE:InteractiveEvent = new InteractiveEvent;
			talkE.eventid = eid;
			talkE.targetseatid = targetSeat;
			talkE.srcseatid = myseatId;
			var bytest:ByteArray = new ByteArray;
			talkE.writeTo(bytest);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_INTER_EVENT,bytest));
		}
		/**
		 * 交互表情 
		 * @param uid
		 * @param content
		 * @param targetSeat 目标人物座位,0为荷官
		 * 
		 */			
		public static function anim(content:String,targetSeat:uint = 0):void
		{
			var talkE:UseInteractiveItemRequest = new UseInteractiveItemRequest;
			talkE.itemid = Number(content);
			talkE.targetseatid = targetSeat;
			var bytest:ByteArray = new ByteArray;
			talkE.writeTo(bytest);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.USE_INTERACTIVE_ITEM_REQUEST,bytest));
		}
		/**
		 * 邀请好友 
		 * @param uid
		 * 
		 */		
		public static function inviteFriendGame(uid:int):void
		{
			var invite:InviteFriendRequest = new InviteFriendRequest;
			invite.targetuid = uid;
			
			var bytest:ByteArray = new ByteArray;
			invite.writeTo(bytest);
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_INVITE_FRIEND_JOIN_GAME,bytest));
		}
		
		/**
		 * 给荷官小费 当为0时，表示给荷官送筹码
		 * @param uid
		 * 
		 */		
		public static function giveDealerMoney(uid:int,money:Number):void
		{
			var give:GiveMoneyRequest = new GiveMoneyRequest;
			give.targetuid = uid;
			give.money = money;
			
			var bytest:ByteArray = new ByteArray;
			give.writeTo(bytest);
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_GIVE_MONEY,bytest));
		}
		/**
		 * 全局喇叭 
		 * @param msg
		 * 
		 */		
		public static function sendLoader(msg:String):void
		{
			var louder:GlobalMessageRequest = new GlobalMessageRequest;
			louder.message = msg;
			var bytest:ByteArray = new ByteArray;
			louder.writeTo(bytest);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_GLOBAL_MESSAGE,bytest));
		}
		/**
		 * 获取围观群众
		 * @param msg
		 * 
		 */		
		public static function sendObservePlayers():void
		{
			var louder:ShowObserversRequest = new ShowObserversRequest;
			var bytest:ByteArray = new ByteArray;
			louder.writeTo(bytest);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_OBSERVE_PLAYERS,bytest));
		}
		/**
		 * 大乐透下注
		 * @param msg
		 * 
		 */		
		public static function sendJackPotBet(level:uint):void
		{
			var bet:BetJackPotRequest = new BetJackPotRequest;
			bet.level = level;
			var bytest:ByteArray = new ByteArray;
			bet.writeTo(bytest);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.BET_JACK_POT,bytest));
		}
		
		/**
		 * 展示底牌 
		 * @param msg
		 * 
		 */		
		public static function ShowHoleCardsSend():void
		{
			var cards:ShowHoleCardsRequest = new ShowHoleCardsRequest;
			var bytest:ByteArray = new ByteArray;
			cards.writeTo(bytest);
			
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SHOW_HOLE_CARDS_REQUEST,bytest));
		}
		
	}
}