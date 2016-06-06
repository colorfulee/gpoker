package com.jzgame.vo
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 12, 2013 12:25:18 PM 
	 * @description:
	 */ 
	import com.jzgame.common.services.protobuff.PlayerInfo;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.logging.Tracer;
	import com.netease.protobuf.Int64;
	import com.spellife.interfaces.vo.IValueObject;
	import com.spellife.vo.ValueObject;
	
	import flash.events.Event;
	
	public class UserBaseVO extends ValueObject
	{
		// 当前等级经验
		public var uPendingExp:uint;
		// 当前等级总经验
		public var uLevelExp:uint;
		//个人游戏中状态
		private var _uStatus:uint;
		//排名
		public var uRank:uint;
		//金币
		public var uGold:Number;
		
		public var userId:uint;// 用户ID
		public var uLevel:uint;// 用户等级
		public var uSex:uint;// 用户性别
//		public var uVip:uint;// vip
		public var uSeatIndex:uint;//所进入的位置 
		public var uNickName:String;//用户名字
		public var uWinningRate:uint;//胜率
		public var uGamePlayed:Number;//玩的场次
		public var uWinning:Number;//赢的场次
		public var uMaxWin:Number;//最多赢得筹码
		public var uLocation:String="";//位置
		public var uTitle:String = "";//称号
		public var uVipLevel:uint = 0;//vip 等级
		private var _uEquipId:uint = 0;//装备id
		public var uEquipEndTime:uint = 0;//装备id过期时间
		public var uMaxCards:String = "";//最大的手牌
		public var isset_box_pwd:uint = 0;//是否设置了保险箱
		public var chip_box:Number = 0;//保险箱存款
		//荷官头像id
		public var uDealer:uint = 0;
		//桌子主题背景
		private var _uTableBack:uint = 0;
		//比赛积分
		public var uScore:Number = 0;
		//曾经最多获得积分
		public var uEverMaxScore:Number = 0;
		//拥有的金钱
		public var uMoney:Int64 = new Int64();
		//用户携带筹码
		public var uClip:Int64 = new Int64();
		//新手引导是否领取过奖励0--默认   1--完成  2--领取完奖励
		public var guideStatus:uint;
		//是否点赞
		public var isLike:Boolean;
		//今天的登录奖励是否领取,方便自动弹窗
		public var todayLoginBonus:uint = 0;
		public var userRealName:String;
		public var userPhone:String;
		public var userEmail:String;
		public var isAI:Boolean = false;
		public var uFB_ID:String;//FB id
		//玩家手牌
		private var _cards:Array = [];
		public static var DEFAULT_TABLE_BACK:uint = 1009;
		
		public function UserBaseVO(player:PlayerInfo = null)
		{
			if(player)
			{
				uLevel = player.level;
				uClip = player.chips;
				uFB_ID = player.faceid;
				uSeatIndex = player.seatid;
				userId = player.uid;
				uStatus = player.status;
				uVipLevel = player.viplevel;
				uNickName = player.username;
				uWinningRate = player.winning;
				uMoney = player.capital;
				uPendingExp = player.exp;
				uLevelExp = player.exp;
				uEquipId = player.giftid;
				uLocation = player.location;
				
				cards = player.card;
			}
		}

		public function get cards():Array
		{
			return _cards.concat();
		}

		public function set cards(value:Array):void
		{
//			Tracer.info("cards:"+userId + ":" + value+":"+new Error().getStackTrace());
			_cards = value;
		}

		public function get uEquipId():uint
		{
			return _uEquipId;
		}

		public static const EQUIP_CHANGE:String = "EQUIP_CHANGE";
		public function set uEquipId(value:uint):void
		{
			_uEquipId = value;
			AssetsCenter.eventDispatcher.dispatchEvent(new Event(EQUIP_CHANGE));
		}

		/**
		 * 获取个人游戏状态 
		 * @return 
		 * 
		 */		
		public function get uStatus():uint
		{
			return _uStatus;
		}
		/**
		 * 设置游戏状态 
		 * @param value
		 * 
		 */
		public function set uStatus(value:uint):void
		{
			Tracer.info("uStatus:"+userId + ":" + value+":"+new Error().getStackTrace());
			_uStatus = value;
//			Tracer.info("status:"+userId + ":" + value+":"+new Error().getStackTrace());
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function set uTableBack(value:uint):void
		{
			_uTableBack = value;
		}

		public function get uTableBack():uint
		{
			if(_uTableBack == 0)_uTableBack = DEFAULT_TABLE_BACK;
			return _uTableBack;
		}
		
		override public function toString():String
		{
			return "uid:"+userId + ":FB_id:"+uFB_ID;
		}
		
		override public function clone():IValueObject
		{
			var user:UserBaseVO = new UserBaseVO;
			
			user.uPendingExp = uPendingExp;
			user.uLevelExp = uLevelExp;
			user.uStatus= _uStatus;
			user.uRank = uRank;
			user.userId = userId;
			user.uLevel = uLevel;
			user.uSex = uSex;
			user.uSeatIndex = uSeatIndex;
			user.uNickName = uNickName;
			user.uWinningRate = uWinningRate;
			user.uGamePlayed = uGamePlayed;
			user.uWinning = uWinning;
			user.uMaxWin = uMaxWin;
			user.uLocation = uLocation;
			user.uTitle = uTitle;
			user.uVipLevel = uVipLevel;
			user.uScore = uScore;
			user.uFB_ID = uFB_ID;
			user.isLike = isLike;
			user.guideStatus = guideStatus;
			user.uScore = uScore;
			user.uClip = uClip;
			user.uMoney = uMoney;
			user.uTableBack = _uTableBack;
			user.uDealer = uDealer;
			user.uMaxCards = uMaxCards;
			user.uEverMaxScore = uEverMaxScore;
			user.uEquipEndTime = uEquipEndTime;
			user.uEquipId = _uEquipId;
			return user;
		}
	}
}