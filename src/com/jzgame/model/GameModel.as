package com.jzgame.model
{
	import com.jzgame.enmu.ClipType;
	import com.jzgame.vo.ActionVO;
	import com.jzgame.vo.PreRoundInfoVO;
	import com.jzgame.vo.TableClipVO;
	import com.jzgame.vo.UserBaseVO;
	import com.jzgame.vo.game.MessageAlertVO;
	import com.jzgame.vo.room.RoomBaseInfoVO;
	import com.netease.protobuf.Int64;
	
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	public class GameModel
	{
		/*auther     :jim
		* file       :GameModel.as
		* date       :Sep 2, 2014
		* description:
		*/
		
		//是否为新手引导
		public var guide:Boolean = false;
		
		//是否在桌子中
		private var _inTable:Boolean = false;
		//是否自动坐下,如果外部play now
		public var autoSit:Boolean = false;
		//此轮call的值
		public var callClip:Number = 0;
		//最小下注
		private var _raiseMinClip:Number = 0;
		//当前下注
		public var raiseClip:Number = 0;
		//最大下注
		private var _raiseMaxClip:Number = 0;
		//此轮我下的筹码数
		public var myRoundClip:Number = 0;
		//庄id
		public var dealSeatId:uint = 1;
		//进入的桌子VO
		public var tableBaseInfoVO:RoomBaseInfoVO = new RoomBaseInfoVO;
		//sng 临时存储改变小盲
		public var SNGBlinds:Int64 = new Int64();
		private var handPoker:Dictionary = new Dictionary;
		private var _guideStep:uint = 0;
		private var _facePosition:Vector.<Point> = new Vector.<Point>;
		private var _tipsRect:Vector.<Rectangle> = new Vector.<Rectangle>;
		private var _tipsHoleRect:Vector.<Rectangle> = new Vector.<Rectangle>;
		//桌牌
		public var tableCardList:Vector.<uint> = new Vector.<uint>;
		//引导的大步骤
		private var _guideShowStep:uint = 1;
		//同步当前轮筹码
		public var pots:Vector.<Int64> = new Vector.<Int64>;
		//玩家上一次行为记录
		public var playerActionHoney:Dictionary = new Dictionary;
		//收集筹码动画时间
		public var collectClipTime:Number = 800;
		//个人操作时间
		public var playerCD:Number = 10;
		//错误弹窗列表
		public var errorCodeList:Vector.<String> = new Vector.<String>;
		
		private var _tipUserId:uint = 0;
		//是否自动补足筹码,不管是什么游戏模式
		public var autoBuy:Boolean = false;
		//筹码池
		public var clips:Vector.<TableClipVO> = new Vector.<TableClipVO>;
		public var tempClips:Vector.<TableClipVO> = new Vector.<TableClipVO>;
		//消息弹窗列表
		public var messageList:Vector.<MessageAlertVO> = new Vector.<MessageAlertVO>;
		//
		public var so:Object;
		//新手引导vo
		public var guideRoomVO:RoomBaseInfoVO;
		//比牌锁，避免比牌的时候手牌站起来手牌没有
		public var cardCompareLock:Boolean = false;
		//缓存玩家行为，只缓存正常玩牌信息，断线重连不记录
		public var tempRoundInfo:PreRoundInfoVO;
		//当前是否为断线重连
		public var offLine:Boolean;
		[Inject]
		public var userModel:UserModel;
		
		[Inject]
		public var eventDis:IEventDispatcher;
		
		public var screenShot:BitmapData;
		
		//大乐透总奖励
		public var jack_pot:Number=0;
		//大乐透压注
		public var jack_betLevel:uint = 0;
		
		
		public function GameModel()
		{
			init();
		}
		
		public function get guideShowStep():uint
		{
			return _guideShowStep;
		}

		public function set guideShowStep(value:uint):void
		{
			trace(value,new Error().getStackTrace());
			_guideShowStep = value;
		}

		public function get inTable():Boolean
		{
			return _inTable;
		}

		public function set inTable(value:Boolean):void
		{
			trace("inTable",value,new Error().getStackTrace());
			_inTable = value;
		}

		public function get tipUserId():uint
		{
			if(_tipUserId == 0) _tipUserId = userModel.myInfo.userId;
			return _tipUserId;
		}

		public function set tipUserId(value:uint):void
		{
			_tipUserId = value;
		}

		public function get raiseMaxClip():Number
		{
			return _raiseMaxClip;
		}
		/**
		 * 设置最大下注 
		 * @param value
		 * 
		 */
		public function set raiseMaxClip(value:Number):void
		{
			_raiseMaxClip = Math.min( value , userModel.myInfo.uClip.toNumber());
		}

		public function get raiseMinClip():Number
		{
			return _raiseMinClip;
		}
		/**
		 * 设置最小下注 
		 * @param value
		 * 
		 */
		public function set raiseMinClip(value:Number):void
		{
			_raiseMinClip = Math.min( value , userModel.myInfo.uClip.toNumber());
		}

		private function init():void
		{
			_facePosition.push(new Point(658,176 - 80));
			_facePosition.push(new Point(846,248 - 90));
			_facePosition.push(new Point(867,451 - 60));
			_facePosition.push(new Point(690,537 - 90));
			_facePosition.push(new Point(470,537 - 60));
			_facePosition.push(new Point(281,537 - 90));
			_facePosition.push(new Point(105,451 - 60));
			_facePosition.push(new Point(127,248 - 90));
			_facePosition.push(new Point(317,176 - 80));
			
			clips.push(new TableClipVO(0,ClipType.MAIN));
			clips.push(new TableClipVO(0,ClipType.SIDE_1));
			clips.push(new TableClipVO(0,ClipType.SIDE_2));
			clips.push(new TableClipVO(0,ClipType.SIDE_3));
			clips.push(new TableClipVO(0,ClipType.SIDE_4));
			clips.push(new TableClipVO(0,ClipType.SIDE_5));
			clips.push(new TableClipVO(0,ClipType.SIDE_6));
			clips.push(new TableClipVO(0,ClipType.SIDE_7));
			
			guideRoomVO = new RoomBaseInfoVO;
			guideRoomVO.blinds = 100;
			guideRoomVO.maxBuy = 200;
			guideRoomVO.minBuy = 100;
			guideRoomVO.maxRole = 5;
			guideRoomVO.online = 5;
			guideRoomVO.id = 1000001;
		}

		public function get guideStep():uint
		{
			return _guideStep;
		}

		public function set guideStep(value:uint):void
		{
			_guideStep = value;
			trace("guideStep:",_guideStep);
		}
		/**
		 * 缓存某人手牌
		 * @param seat
		 * @param hand
		 * 
		 */		
//		public function addHandPoker(userId:uint,hand:Array):void
//		{
//			handPoker[userId] = hand;
//		}
		/**
		 * 获取某人的手牌
		 * @param seat
		 * @return 
		 * 
		 */		
//		public function getHandPokerBySeat(userId:uint):Array
//		{
//			return handPoker[userId];
//		}
		/**
		 * 记录行为 
		 * @param action
		 * 
		 */		
		public function recordAction(action:ActionVO):void
		{
			var lastAction:ActionVO = playerActionHoney[action.seatID];
			
			if(lastAction)
			{
				playerActionHoney[action.seatID] = mergeAction(lastAction,action);
			}else
			{
				playerActionHoney[action.seatID] = action;
			}
		}
		/**
		 * 
		 * @param recordAction
		 * @param newAction
		 * 
		 */		
		private function mergeAction(recordAction:ActionVO,newAction:ActionVO):ActionVO
		{
//			switch(recordAction.state)
//			{
//				case PlayerStatus.OBSERVING:
//					break;
//				case PlayerStatus.PLAYING_CALL:
//				case PlayerStatus.PLAYING_RAISE:
//					if(newAction.state == PlayerStatus.PLAYING_CALL || newAction.state == PlayerStatus.PLAYING_RAISE || newAction.state == PlayerStatus.PLAYING_ALLIN)
//					{
//						
//					}
//					break;
//			}
			
			if(newAction.clip!=0)
			{
				recordAction.clip += newAction.clip;
			}
//			if(recordAction.state == newAction.state)
//			{
//				recordAction.clip += newAction.clip;
//			}else
//			{
//				
//			}
			
			return recordAction;
		}
		/**
		 * 获取牌桌中下注最多的 
		 * @return 
		 * 
		 */		
		public function getMoreAction():ActionVO
		{
			var itemAction:ActionVO;
			var clip:Number = 0;
			
			for each(var item:ActionVO in playerActionHoney)
			{
				if(item.clip >= clip)
				{
					itemAction = item;
					clip = item.clip;
				}
			}
			
			return itemAction;
		}
		
		/**
		 * 查找最多筹码的人，除了自己 
		 * 判断这轮最大能下注多少，不算此轮已经下注的
		 * @return 
		 * 
		 */		
		public function findWithoutMeMaxChip():Number
		{
			var chip:Number = 0;
			var playerChip:Number = 0;
			var action:ActionVO;
			var myChip:Number = userModel.myInfo.uClip.toNumber();
			for each(var item:UserBaseVO in userModel.userList)
			{
				action = getLastAction(item.uSeatIndex);
				if(item.userId == userModel.myInfo.userId)
				{
					if(action)
					{
						myChip+=action.clip;
					}
				}else
				{
					if(action)
					{
						playerChip = action.clip + item.uClip.toNumber();
					}else
					{
						playerChip = item.uClip.toNumber();
					}
					chip = Math.max(playerChip,chip);
				}
			}
			action = getLastAction(userModel.myInfo.uSeatIndex);
			playerChip = action ? action.clip : 0;
			if(myChip > chip)
			{
				return chip - playerChip;
			}else
			{
				return userModel.myInfo.uClip.toNumber();
			}
			return Math.min( chip , myChip);
		}
		/**
		 * 
		 * 获取全部下注筹码
		 */		
		public function getAllClip():Number
		{
			var temp:Number = 0;
			
			for (var i:String in pots)
			{
				if(pots[i].toNumber() != 0)
				{
					temp += Int64(pots[i]).toNumber();
				}
			}
			return temp;
			
		}
		/**
		 * 
		 * @param seatID
		 * @return 
		 * 
		 */		
		public function getLastAction(seatID:uint):ActionVO
		{
			return playerActionHoney[seatID];
		}
		
		/**
		 * 获取引导的位置
		 * @param step
		 * @return 
		 * 
		 */		
//		public function getTipsPositionByStep(step:uint):Rectangle
//		{
//			var rect:Rectangle = _tipsRect[step - 1];
//			return rect;
//		}
		/**
		 * 获取头像的位置
		 * @param seatId
		 * @return 
		 * 
		 */		
		public function getFacePosition(seatId:uint):Point
		{
			var p:Point = _facePosition[seatId - 1];
			
			return p;
		}
		/**
		 * 清空筹码缓存值 
		 * 
		 */
		public function clipClear():void
		{
			myRoundClip = 0;
			callClip    = 0;
			raiseClip   = 0;
			for(var i:String in playerActionHoney)
			{
				delete playerActionHoney[i];
			}
		}
		/**
		 * 清空 
		 * 
		 */		
		public function reset():void
		{
			tableCardList.splice(0,tableCardList.length);
			pots.splice(0,pots.length);
			clipClear();
		}
		/**
		 * 销毁房间的时候操作 
		 * 
		 */		
		public function clear():void
		{
			reset();
			jack_betLevel = 0;
		}
	}
}