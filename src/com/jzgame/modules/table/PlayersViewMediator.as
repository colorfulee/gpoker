package com.jzgame.modules.table
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.services.protobuff.CardTypeEnum;
	import com.jzgame.common.services.protobuff.PlayerStatus;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.enmu.DebugInfoType;
	import com.jzgame.enmu.EventType;
	import com.jzgame.events.DebugInfoEvent;
	import com.jzgame.events.InterAnimEvent;
	import com.jzgame.events.SoundEffectEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.TableModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.model.UserProxy;
	import com.jzgame.util.CardInfoUtil;
	import com.jzgame.util.NumUtil;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.chat.ChatInterAnimSheet;
	import com.jzgame.vo.ActionVO;
	import com.jzgame.vo.ChatMessageVO;
	import com.jzgame.vo.SeatInfoVO;
	import com.jzgame.vo.UserBaseVO;
	import com.netease.protobuf.Int64;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	public class PlayersViewMediator extends StarlingMediator
	{
		/***********
		 * name:    PlayersViewMediator
		 * data:    Nov 17, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PlayersView;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var tableModel:TableModel;
		[Inject]
		public var gameModel:GameModel;
		public function PlayersViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(EventType.STAND_UP, standUpHandler);
			addContextListener(EventType.ACTION, actionHandler);
			addContextListener(EventType.TURN, turnHandler);
			addContextListener(EventType.I_AM_IN_SEAT,seatHandler);
			addContextListener(EventType.PLAYER_IN_SEAT,otherSeatHandler);
			addContextListener(EventType.RESET, resetHandler);
			addContextListener(EventType.NET_FORCE_RESET_TABLE, startHandler);
			addContextListener(EventType.UPDATE_MY_POKER_TYPE, updateCardTypeHandler);
			addContextListener(EventType.SHOW_RESULT, onShowResultHandler);
			addContextListener(InterAnimEvent.SEND, animHandler);
			addContextListener(EventType.CHAT,chatHandler);
		}
		
		override public function destroy():void
		{
			removeContextListener(InterAnimEvent.SEND, animHandler);
			removeContextListener(EventType.SHOW_RESULT, onShowResultHandler);
			removeContextListener(EventType.UPDATE_MY_POKER_TYPE, updateCardTypeHandler);
			removeContextListener(EventType.STAND_UP, standUpHandler);
			removeContextListener(EventType.ACTION, actionHandler);
			removeContextListener(EventType.TURN, turnHandler);
			removeContextListener(EventType.PLAYER_IN_SEAT,otherSeatHandler);
			removeContextListener(EventType.I_AM_IN_SEAT,seatHandler);
			removeContextListener(EventType.RESET, resetHandler);
			removeContextListener(EventType.NET_FORCE_RESET_TABLE, startHandler);
			removeContextListener(EventType.CHAT,chatHandler);
		}
		/**
		 * 开局同步筹码 跟状态
		 * @param e
		 * 
		 */		
		private function startHandler(e:Event):void
		{
			var seatInfo:SeatInfoVO;
			
			for each(var info:UserBaseVO in userModel.userList)
			{
				seatInfo = tableModel.getUserBySeat(info.uSeatIndex);
				if(seatInfo)
				{
					seatInfo.user.setChip(NumUtil.n2c(seatInfo.userInfo.uClip.toNumber()));
					seatInfo.user.setStatus( CardInfoUtil.getStateNameByState(info.uStatus) );
				}
			}
		}
		/**
		 * 重置 
		 * @param e
		 * 
		 */		
		private function resetHandler(e:Event):void
		{
			var seatInfo:SeatInfoVO;
			
			for each(var info:UserBaseVO in userModel.userList)
			{
				seatInfo = tableModel.getUserBySeat(info.uSeatIndex);
				if(seatInfo)
				{
					if(info.userId == userModel.myInfo.userId)
					{
						userModel.myInfo.uStatus = PlayerStatus.PLAYING_IDLE;
					}
					info.uStatus = PlayerStatus.PLAYING_IDLE;
					seatInfo.user.setChip(NumUtil.n2c(seatInfo.userInfo.uClip.toNumber()))
					seatInfo.user.setStatus( CardInfoUtil.getStateNameByState(PlayerStatus.PLAYING_IDLE) );
					seatInfo.user.reset();
				}
			}
			Tracer.info("player model reset!");
		}
		/**
		 * 从座位站起 
		 * @param e
		 * 
		 */		
		private function standUpHandler(e:SimpleEvent):void
		{
			var userBaseVO:UserBaseVO = UserBaseVO(e.carryData);
			removeSomeBoy(userBaseVO);
			//			model.removeUser( model.me.userInfo.uUserId);
		}
		/**
		 * 收到聊天
		 * @param e
		 * 
		 */		
		private function chatHandler(e:SimpleEvent):void
		{
			var chatVO:ChatMessageVO = e.carryData as ChatMessageVO;
			var uid:uint = chatVO.uid;
			var user:UserBaseVO = userModel.getUserByID(uid);
			if(user)
			{
				var seatInfo:SeatInfoVO =  tableModel.getUserBySeat(user.uSeatIndex);
				//是否是表情
				if(chatVO.anim!=0)
				{
					seatInfo.user.anim(new ChatInterAnimSheet(String(chatVO.anim)));
				}else
				{
					for(var index:String in userModel.mutePlayerList)
					{
						//是否禁言
						if(userModel.mutePlayerList[index] == chatVO.uid)
						{
							return;
						}
					}
					seatInfo.user.talk(chatVO.content,view.chatContainer);
				}
			}else
			{
				WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText('500264'));
			}
		}
		/**
		 * 互动表情
		 * @param e
		 * 
		 */		
		private function animHandler(e:InterAnimEvent):void
		{
			var seatInfo:SeatInfoVO = tableModel.getUserBySeat(e.fromSeat);
			
			var chat:ChatInterAnimSheet = new ChatInterAnimSheet(e.animId.toString());
			chat.x = seatInfo.user.x;
			chat.y = seatInfo.user.y;
			chat.play();
			//目标位置,默认为荷官
			var target:Point = new Point(500,130);
			
			if(e.seat !=0)
			{
				var targetSeatInfo:SeatInfoVO = tableModel.getUserBySeat(e.seat);
				if(targetSeatInfo)
				{
					target.x = targetSeatInfo.user.x + 26;
					target.y = targetSeatInfo.user.y + 28;
				}
			}
			TweenMax.to(chat,1,{x:target.x,y:target.y,onComplete:animFinish,onCompleteParams:[chat],ease:Linear.easeNone});
			view.chatContainer.addChild(chat);
		}
		/**
		 * 动画移动结束 
		 * @param target
		 * 
		 */		
		private function animFinish(target:ChatInterAnimSheet):void
		{
			target.play(false);
		}
		/**
		 * 玩家操作 
		 * @param e
		 * 
		 */		
		private function actionHandler(e:SimpleEvent):void
		{
			var vo:ActionVO = e.carryData as ActionVO;
			
			var seat:uint = vo.seatID;
			var seatInfo:SeatInfoVO = tableModel.getUserBySeat(seat);
			seatInfo.user.hideCounting();
			seatInfo.user.setStatus(CardInfoUtil.getStateNameByState(vo.state));
			seatInfo.userInfo.uStatus = vo.state;
			if(vo.state == PlayerStatus.PLAYING_FOLD)
			{
			}else
			{
				if(seatInfo.userInfo.uClip.toNumber() >= vo.clip)
				{
					seatInfo.userInfo.uClip = new Int64(seatInfo.userInfo.uClip.toNumber() - vo.clip);
				}else
				{
					seatInfo.userInfo.uClip = new Int64();
				}
				seatInfo.user.setChip(NumUtil.n2c(seatInfo.userInfo.uClip.toNumber()))
			}
		}
		/**
		 * 自己坐下 
		 * @param e
		 * 
		 */		
		private function seatHandler(e:Event):void
		{
			var face:PlayerItemView = new PlayerItemView;
			var my:Point = Configure.tableConfig.getSeatPoint(userModel.myInfo.uSeatIndex);
			face.x = my.x - 25;
			face.y = my.y - 35;
			face.seat = userModel.myInfo.uSeatIndex;
			face.isMine(true);
			view.playerContainer.addChild(face);
//			face.bindFaceFrame(new Bitmap(ResManager.getBitmapDataByName(AssetsName.ASSET_20000_SMALL_FACE_FRAME)));
			face.setFace(( AssetsCenter.getFBFace(userModel.myInfo.uFB_ID,AssetsCenter.FB_FACE_SMALL) ));
//			face.bindGift(userModel.myInfo.uEquipId);
			var seatInfo:SeatInfoVO = tableModel.getUserBySeat(userModel.myInfo.uSeatIndex);
			if(!seatInfo)
			{
				seatInfo = new SeatInfoVO(userModel.myInfo.uSeatIndex);
				tableModel.addSeatUser(seatInfo);
			}
			face.userId = userModel.myInfo.userId;
			seatInfo.user = face;
			seatInfo.userInfo = userModel.myInfo;
			
//			face.title.text = "LV "+userModel.myInfo.uLevel + " "+Configure.playerLevel.getTitleByLevel(userModel.myInfo.uLevel);;
//			face.nick.text = seatInfo.userInfo.uNickName;
			face.setChip(NumUtil.n2c(seatInfo.userInfo.uClip.toNumber()))
			seatInfo.user.setStatus(CardInfoUtil.getStateNameByState(PlayerStatus.PLAYING_IDLE));
//			seatEffect();
//			if(!gameModel.guide)
//			{
//				//打点
//				HttpSendProxy.timestamp(LogType.SIT,userModel.myInfo.uSeatIndex.toString());
//			}
			//只有进入房间坐下有效
			//			userModel.myInfo.uVipLevel = 4;
//			if(userModel.myInfo.uVipLevel > 0)
//			{
//				face.vipBtn = new ImageButton(ResManager.getBitmapDataByName("20000_vip"+userModel.myInfo.uVipLevel)
//					,ResManager.getBitmapDataByName("20000_vip"+userModel.myInfo.uVipLevel),
//					ResManager.getBitmapDataByName("20000_vip"+userModel.myInfo.uVipLevel));
//				face.vipBtn.mouseChildren=false;;
//				face.vipBtn.mouseEnabled=false;
//				face.vipBtn.setLocation(-58,-26);
//				face.addChild(face.vipBtn);
//			}
			
			dispatch(new SoundEffectEvent(AssetsCenter.getSoundPath("sit")));
//			eventMap.mapListener(face.face,MouseEvent.ROLL_OVER,showSimpleInfo);
		}
		/**
		 * 其他人坐下
		 * @param e
		 * 
		 */		
		private function otherSeatHandler(e:SimpleEvent):void
		{
			var playerInfo:UserBaseVO = UserBaseVO(e.carryData);
			var seatInfo:SeatInfoVO = tableModel.getUserBySeat(playerInfo.uSeatIndex);
			if(!seatInfo)
			{
				seatInfo = new SeatInfoVO(playerInfo.uSeatIndex);
				tableModel.addSeatUser(seatInfo);
			}
			
			seatInfo.userInfo = playerInfo;
			
			var seat:uint = playerInfo.uSeatIndex;
			var face:PlayerItemView = new PlayerItemView;
			face.seat = seat;
			//不是本人,牌型隐藏
			face.isMine(false);
			var my:Point = Configure.tableConfig.getSeatPoint(seat);
			face.x = my.x - 25;
			face.y = my.y - 35;
			view.playerContainer.addChild(face);
			face.userId = playerInfo.userId;
			//如果是机器人
			if(playerInfo.userId < UserProxy.ROBOT_ID_RANGE)
			{
				face.setFace(AssetsCenter.getFBFace(""));
			}else
			{
				face.setFace(AssetsCenter.getFBFace(playerInfo.uFB_ID,AssetsCenter.FB_FACE_SMALL));
			}
//			face.bindGift(playerInfo.uEquipId);
//			face.nick.text = playerInfo.uNickName;
//			face.title.text = "LV "+playerInfo.uLevel + " "+Configure.playerLevel.getTitleByLevel(playerInfo.uLevel);
			
			face.setChip(NumUtil.n2c(playerInfo.uClip.toNumber()))
			face.setStatus(CardInfoUtil.getStateNameByState(PlayerStatus.PLAYING_IDLE));
			seatInfo.user = face;
			
//			if(playerInfo.uVipLevel>0)
//			{
//				face.vipBtn = new ImageButton(ResManager.getBitmapDataByName("20000_vip"+playerInfo.uVipLevel)
//					,ResManager.getBitmapDataByName("20000_vip"+playerInfo.uVipLevel)
//					,ResManager.getBitmapDataByName("20000_vip"+playerInfo.uVipLevel));
//				face.vipBtn.mouseChildren=false;;
//				face.vipBtn.mouseEnabled=false;
//				face.vipBtn.setLocation(-58,-26);
//				face.addChild(face.vipBtn);
//			}
//			seatInfo.user.showCounting(gameModel.playerCD);
		}
		/**
		 * 更新我的牌型 
		 * @param e
		 * 
		 */		
		private function updateCardTypeHandler(e:SimpleEvent):void
		{
			var type:uint = uint(e.carryData);
			var seatInfo:SeatInfoVO = tableModel.getUserBySeat(userModel.myInfo.uSeatIndex);
			
			if(!seatInfo || !seatInfo.user) return;
			
			seatInfo.user.cardType.reset();
			if(type!=0)
			{
				seatInfo.user.cardType.setText( LangManager.getText(String(301500 + type)));
				seatInfo.user.cardType.setProgress( Math.floor(100 * type / CardTypeEnum.ROYALFLUSH ) );
			}
		}
		/**
		 * 显示回合 
		 * @param e
		 * 
		 */		
		private function turnHandler(e:SimpleEvent):void
		{
			var seat:uint = uint(e.carryData);
			Tracer.info(seat+"号座位上的玩家显示倒计时:"+gameModel.playerCD);
			var seatInfo:SeatInfoVO = tableModel.getUserBySeat(seat);
			seatInfo.user.showCounting(gameModel.playerCD);
		}
		/**
		 * 移除某人
		 * @param userBaseVO
		 * 
		 */
		private function removeSomeBoy(userBaseVO:UserBaseVO):void
		{
			var seatInfo:SeatInfoVO = tableModel.getUserBySeat(userBaseVO.uSeatIndex);
			tableModel.removeSeatUser(userBaseVO.uSeatIndex);
			view.removeChild( seatInfo.user );
			seatInfo.user.dispose();
			dispatch(new SoundEffectEvent(AssetsCenter.getSoundPath("lobby")));
			Tracer.info(userBaseVO.uNickName+"离开桌子");
		}
		
		/**
		 * 结果结算,关闭所有倒计时
		 * @param e
		 * 
		 */
		private function onShowResultHandler(e:Event):void
		{
			var seatInfo:SeatInfoVO;
			
			for each(var info:UserBaseVO in userModel.userList)
			{
				seatInfo = tableModel.getUserBySeat(info.uSeatIndex);
				if(seatInfo)
				{
					dispatch(new DebugInfoEvent("播放结算动画 player " + seatInfo.id + " 结算倒计时重置!",DebugInfoType.INFO));
					seatInfo.user.result();
				}
			}
		}
	}
}