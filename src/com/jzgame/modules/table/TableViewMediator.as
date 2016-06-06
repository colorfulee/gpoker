package com.jzgame.modules.table
{
	import com.greensock.TweenMax;
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.common.model.SocketSendProxy;
	import com.jzgame.common.services.protobuff.DealCardPlayerResponse;
	import com.jzgame.common.services.protobuff.RewardInfo;
	import com.jzgame.common.services.protobuff.TableInfo;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.events.SoundEffectEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.TableModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.model.UserProxy;
	import com.jzgame.util.CardInfoUtil;
	import com.jzgame.util.ItemStringUtil;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.vo.CardInfoVO;
	import com.jzgame.vo.FlopCardInfoVO;
	import com.jzgame.vo.PreRoundPlayerInfoVO;
	import com.jzgame.vo.SeatInfoVO;
	import com.jzgame.vo.TableClipVO;
	import com.jzgame.vo.UserBaseVO;
	import com.netease.protobuf.Int64;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	public class TableViewMediator extends StarlingMediator
	{
		/***********
		 * name:    TableViewMediator
		 * data:    Nov 17, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:TableView;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var tableModel:TableModel;
		public function TableViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.start();
			
			addContextListener(EventType.HAND_POKER, handPokerHandler);
			addContextListener(EventType.FLOP_CARD, onFlopHandler);
			
			addContextListener(EventType.NET_INIT_TABLE, receiveTableInfoHandler);
			addContextListener(EventType.NET_HAND_POKER, receiveHandPokerHandler);
			addContextListener(EventType.RESET, resetTableHandler);
			addContextListener(EventType.NET_FORCE_RESET_TABLE, forceReset);
			addContextListener(EventType.STAND_UP, standUpHandler);
			addContextListener(EventType.I_AM_IN_SEAT, seatedHandler);
			addContextListener(EventType.PLAYER_IN_SEAT, playerSeatHandler);
			addContextListener(EventType.SHOW_BUTTON, showButtonHandler);
			addContextListener(EventType.OPEN_COUNT_DOWN_BOX, getCountDownBoxViewHandler);
			SignalCenter.onSitDownArrowTriggered.add(seatSelect);
		}
		
		override public function destroy():void
		{
			removeContextListener(EventType.SHOW_BUTTON, showButtonHandler);
			removeContextListener(EventType.NET_INIT_TABLE, receiveTableInfoHandler);
			removeContextListener(EventType.NET_HAND_POKER, receiveHandPokerHandler);
			removeContextListener(EventType.FLOP_CARD, onFlopHandler);
			removeContextListener(EventType.HAND_POKER, handPokerHandler);
			removeContextListener(EventType.RESET, resetTableHandler);
			removeContextListener(EventType.NET_FORCE_RESET_TABLE, forceReset);
			removeContextListener(EventType.STAND_UP, standUpHandler);
			removeContextListener(EventType.I_AM_IN_SEAT, seatedHandler);
			removeContextListener(EventType.PLAYER_IN_SEAT, playerSeatHandler);
			removeContextListener(EventType.OPEN_COUNT_DOWN_BOX, getCountDownBoxViewHandler);
			
			SignalCenter.onSitDownArrowTriggered.remove(seatSelect);
			
			view.dispose();
			clearTable();
			tableModel.reset();
			gameModel.clear();
			TweenMax.killAll(true);
		}
		/**
		 *初始化桌子信息  
		 * 
		 */	
		private function receiveTableInfoHandler(e:SimpleEvent):void
		{
			//初始化椅子
			initIdleChair();
			
			var tableInfo:TableInfo = TableInfo(e.carryData);
			//初始化桌子牌
			for each(var card:uint in tableInfo.card)
			{
				var coverCard:CardInfoVO  = CardInfoUtil.praseCardInfo(card);
				var flop:FlopCardInfoVO = new FlopCardInfoVO(gameModel.tableCardList.length + 1,coverCard);
				dispatch(new SimpleEvent(EventType.FLOP_CARD,flop));
				gameModel.tableCardList.push(card);
			}
			//显示当前局的庄家
			if(tableInfo.dealerpos !=0)
			{
				gameModel.dealSeatId = tableInfo.dealerpos;
				eventDispatcher.dispatchEvent(new Event(EventType.SHOW_BUTTON));
			}
		}
		/**
		 * 初始化空闲的椅子 
		 * 
		 */		
		private function initIdleChair():void
		{
			//清空邀请按钮
			removeSingleInviteChair();
			//初始桌子上的玩家
			var point:Point;
			var seat:uint = 1;
			var i:uint = 1;
			var my:Point;
			if(gameModel.tableBaseInfoVO.maxRole == TableInfoUtil.BIG_ROOM_NUMBER)
			{
				for(i=1; i<=gameModel.tableBaseInfoVO.maxRole;i++)
				{
					if(tableModel.getUserBySeat(i))continue;
					
					seat = i;
					
					initSingleIdleChair(seat);
				}
			}else if(gameModel.tableBaseInfoVO.maxRole == TableInfoUtil.VERY_SMALL_ROOM_NUMBER)
			{
				for(i=1; i<=TableInfoUtil.BIG_ROOM_NUMBER;i++)
				{
					seat = i;
					if(tableModel.getUserBySeat(seat))continue;
					initSingleIdleChair(seat);
				}
			}else
			{
				for(i=1; i<=gameModel.tableBaseInfoVO.maxRole;i++)
				{
					seat = 1 + (i - 1) * 2;
					if(tableModel.getUserBySeat(seat))continue;
					
					initSingleIdleChair(seat);
				}
			}
		}
		/**
		 * 
		 * 移除邀请按钮 
		 * 
		 */
		private function removeSingleInviteChair():void
		{
			var length:uint = view.inviteContainer.numChildren;
			while(view.inviteContainer.numChildren > 0)
			{
				var invite:TableInviteButton = view.inviteContainer.getChildAt(0) as TableInviteButton;
				if(invite)
				{
					invite.removeFromParent(true);
				}
			}
		}
		/**
		* 初始化一个椅子
		* @param seat
		* 
		*/		
		private function initSingleIdleChair(seat:uint):void
		{
			var icon:SitDownButton;
			var point:Point;
			var my:Point;
			//如果存在
			if(view.arrowContainer.getChildByName("seat_"+(seat))) return;
			
			//如果不是一般游戏模式,则不显示,新手引导也要显示
			if(gameModel.tableBaseInfoVO.type == TableInfoUtil.NEW_BI || gameModel.tableBaseInfoVO.type == TableInfoUtil.NORMAL_RING_GAME)
			{
				icon = new SitDownButton();
				my = Configure.tableConfig.getSeatPoint(seat);
				icon.x = my.x;
				icon.y = my.y;
				icon.name = "seat_"+(seat);
				trace("idle seat in small room:",seat);
				view.arrowContainer.addChild(icon);
//				eventMap.mapListener(icon,MouseEvent.CLICK,seatSelect);
			}
		}
		/**
		 * 初始化邀请
		 */		
		private function initInviteChair():void
		{
			var seat:uint;
			var i:uint = 1;
			for(i=1; i<=gameModel.tableBaseInfoVO.maxRole;i++)
			{
				seat = 1 + (i - 1) * 2;
				if(tableModel.getUserBySeat(seat))continue;
				
				initSingleIdleInviteChair(seat);
			}
		}
		/**
		 * 初始化单个邀请 
		 * @param seat
		 * 
		 */		
		private function initSingleIdleInviteChair(seat:uint):void
		{
			var icon:TableInviteButton;
			var point:Point;
			var my:Point;
			//如果存在
			if(view.inviteContainer.getChildByName("invite_seat_"+(seat))) return;
			
			//如果不是一般游戏模式,则不显示,新手引导也要显示
			if(gameModel.tableBaseInfoVO.type == TableInfoUtil.NEW_BI || gameModel.tableBaseInfoVO.type == TableInfoUtil.NORMAL_RING_GAME)
			{
				icon = new TableInviteButton();
				my = Configure.tableConfig.getSeatPoint(seat);
				icon.x = my.x;
				icon.y = my.y;
				icon.name = "invite_seat_"+(seat);
				view.inviteContainer.addChild(icon);
			}
		}
		/**
		 * 玩家入座成功 
		 * @param e
		 */		
		private function playerSeatHandler(e:SimpleEvent):void
		{
			var playerInfo:UserBaseVO = UserBaseVO(e.carryData);
			var seatInfo:SeatInfoVO = tableModel.getUserBySeat(playerInfo.uSeatIndex);
			
			var icon:SitDownButton = view.arrowContainer.getChildByName("seat_"+playerInfo.uSeatIndex) as SitDownButton;
			if(icon)
			{
				icon.removeFromParent(true);
			}
			
			var invite:TableInviteButton = view.inviteContainer.getChildByName("invite_seat_"+playerInfo.uSeatIndex) as TableInviteButton;
			if(invite)
			{
				invite.removeFromParent(true);
			}
		}
		/**
		 * 选择座位 
		 * @param e
		 */
		private function seatSelect(seatName:String):void
		{
			var indexC:String = seatName;
			var index:uint = uint(indexC.replace("seat_",""));
			//如果自己额筹码不足最低买入
			if(userModel.myInfo.uMoney.toNumber() < gameModel.tableBaseInfoVO.minBuy)
			{
				UserProxy.checkValid(gameModel.tableBaseInfoVO.minBuy,UserProxy.CHIP);
				return;
			}
			
			if(!UserProxy.checkChip(gameModel.tableBaseInfoVO.limit)) return ;
			
			//检查是否足够最小筹码
			if(!UserProxy.checkValid(gameModel.tableBaseInfoVO.minBuy,UserProxy.CHIP)) return ;
			
			var binds:Number = gameModel.tableBaseInfoVO.blinds * 200;
			var chips:Number = Math.min(binds,userModel.myInfo.uMoney.toNumber());
			SocketSendProxy.sitDown(index,new Int64(chips),true);
		}
		/**
		 * 入座成功 
		 * @param e
		 */		
		private function seatedHandler(e:Event):void
		{
			var icon:SitDownButton;
			var point:Point;
			
			while(view.arrowContainer.numChildren > 0)
			{
				icon = view.arrowContainer.getChildAt(0) as SitDownButton;
				icon.removeFromParent(true);
			}
			
			initInviteChair();
		}
		/**
		 * 某人站起 
		 * @param e
		 * 
		 */		
		private function standUpHandler(e:SimpleEvent):void
		{
			var userBaseVO:UserBaseVO = UserBaseVO(e.carryData);
			var poker:PokerItemView;
			//如果站起来的是本人
			if(userBaseVO.userId == userModel.myInfo.userId)
			{
				initIdleChair();
				if(!gameModel.cardCompareLock)
				{
					//移除两张手牌
					poker = view.handCardContainer.getChildByName(tableModel.getHandPokerName(userBaseVO.uSeatIndex,1)) as PokerItemView;
					if(poker)
					{
						poker.removeFromParent(true);
					}
					poker = view.handCardContainer.getChildByName(tableModel.getHandPokerName(userBaseVO.uSeatIndex,2)) as PokerItemView;
					if(poker)
					{
						poker.removeFromParent(true);
					}
				}
				
				gameModel.clipClear();
			}else
			{//如果站起来的是别人
				var pokerBack:TablePokerBackView;
				if(!gameModel.cardCompareLock)
				{
					//移除两张手牌
					pokerBack = view.handCardContainer.getChildByName(tableModel.getOtherPokerBackName(userBaseVO.uSeatIndex,1)) as TablePokerBackView;
					if(pokerBack)
					{
						pokerBack.removeFromParent(true);
					}
					pokerBack = view.handCardContainer.getChildByName(tableModel.getOtherPokerBackName(userBaseVO.uSeatIndex,2)) as TablePokerBackView;
					if(pokerBack)
					{
						pokerBack.removeFromParent(true);
					}
				}
				//如果我是站起的状态
				if(userModel.myInfo.uSeatIndex == 0)
				{
					trace(userBaseVO.uSeatIndex+"位的人站起来了,我是站着的状态,需要显示空位");
					initSingleIdleChair(userBaseVO.uSeatIndex);
				}
				initInviteChair();
			}
		}
		/**
		 * 选庄成功 
		 * @param e
		 * 
		 */		
		private function showButtonHandler(e:Event):void
		{
			view.roleButton.x = tableModel.hePosition.x;
			view.roleButton.y = tableModel.hePosition.y;	
			
			tableModel.dealerSeat = gameModel.dealSeatId;
			var dealer:Point = Configure.tableConfig.getDealerPoint(tableModel.dealerSeat);
			TweenMax.to(view.roleButton,1,{x:dealer.x,y:dealer.y});
		}
		/**
		 * 后端发来收到手牌 
		 * @param e
		 * 
		 */
		private function receiveHandPokerHandler(e:SimpleEvent):void
		{
			/**
			 * 在发手牌的时候，检测下下一局压注 
			 * @param e
			 * 
			 */		
			if(gameModel.jack_betLevel>1)
			{
				NetSendProxy.sendJackPotBet(gameModel.jack_betLevel);
			}
			
			var uid:uint = uint(e.carryData);
			var vo:UserBaseVO = userModel.getUserByID(uid);
			var cards:Array = vo.cards;
			var tableInfo:DealCardPlayerResponse;
			if(cards && cards.length > 0)
			{
				var coverCard:CardInfoVO = CardInfoUtil.praseCardInfo(cards[0]);
				var coverCard2:CardInfoVO = CardInfoUtil.praseCardInfo(cards[1]);
				
				//缓存
				if(gameModel.tempRoundInfo)
				{
					for each(var playerInfo:PreRoundPlayerInfoVO in gameModel.tempRoundInfo.playerList)
					{
						if(playerInfo.userId == userModel.myInfo.userId)
						{
							playerInfo.card = playerInfo.card.concat(cards);
							break;
						}
					}
				}
			}
			//如果玩家只是在座位上等待,而没有参与牌局。怎么办
			//播放其他玩家收到手牌动画
			var userBaseVO:UserBaseVO;
			//排序
			var temp:Vector.<UserBaseVO> = userModel.userList.sort(compare);
			var cardList:Array = [];
			var i:String;
			for(i in temp)
			{
				userBaseVO = temp[i] as UserBaseVO;
				tableInfo = new DealCardPlayerResponse;
				tableInfo.userid = userBaseVO.userId;
				if(userBaseVO.userId == userModel.myInfo.userId)
				{
					tableInfo.card = [coverCard];
				}
				cardList.push(tableInfo);
			}
			for(i in temp)
			{
				userBaseVO = temp[i] as UserBaseVO;
				tableInfo = new DealCardPlayerResponse;
				tableInfo.userid = userBaseVO.userId;
				if(userBaseVO.userId == userModel.myInfo.userId)
				{
					tableInfo.card = [coverCard2];
				}
				cardList.push(tableInfo);
			}
			
			for(var m:int = 0; m<cardList.length;m++)
			{
				setTimeout(playHandPoker,m * 200,cardList[m]);
			}
		}
		/**
		 * 发送手牌 
		 * @param tableInfo
		 * 
		 */		
		private function playHandPoker(tableInfo:DealCardPlayerResponse):void
		{
			dispatch(new SimpleEvent(EventType.HAND_POKER,tableInfo));
		}
		/**
		 * 排序vector 递增
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */		
		private function compare(x:UserBaseVO, y:UserBaseVO):Number
		{
			if(x.uSeatIndex > y.uSeatIndex)
			{
				return 1;
			}else
			{
				return -1;
			}
		}
		/**
		 * 收到手牌
		 * @param e
		 * 
		 */
		private function handPokerHandler(e:SimpleEvent):void
		{
			var tableInfo:DealCardPlayerResponse = e.carryData as DealCardPlayerResponse;
			var user:UserBaseVO = userModel.getUserByID( tableInfo.userid );
			//如果没有坐下,则不显示手牌，异步
			if(!user) return;
			
			var seat:uint = user.uSeatIndex;
			//我自己的手牌
			if(tableInfo.userid == userModel.myInfo.userId && tableInfo.card.length>0)
			{
				var handPokerPoint:Point = Configure.tableConfig.getHandPokerPoint(seat);
				for(var i:uint = 0; i<tableInfo.card.length;i++)
				{
					var myPoker:PokerItemView = new PokerItemView;
					myPoker.name = tableModel.getHandPokerName(seat,tableModel.handPoker.length+1);
					myPoker.setData(tableInfo.card[i]);
					myPoker.x = handPokerPoint.x+ tableModel.handPoker.length * 22;
					myPoker.y = handPokerPoint.y;
					view.handCardContainer.addChild(myPoker);
					
					tableModel.handPoker.push(tableInfo.card[i]);
				}
				dispatch(new SoundEffectEvent(AssetsCenter.getSoundPath("fapai")));
			}else
			{
				for(var other:uint = 0; other<1;other++)
				{
					var poker:TablePokerBackView = new TablePokerBackView;
					poker.x = tableModel.hePosition.x;
					poker.y = tableModel.hePosition.y;
					poker.scaleX = poker.scaleY = 0.4;
					view.handCardContainer.addChild(poker);
					var pokerPoint:Point = new Point;
					pokerPoint.x = Configure.tableConfig.getPokerBackPoint(seat).x;
					pokerPoint.y = Configure.tableConfig.getPokerBackPoint(seat).y;
					
					var p:Point = new Point(516,312);
					var speed:Number = 1000;
					var distance:Number = Point.distance(pokerPoint,p);
					var time:Number = distance/speed;
					
					TweenMax.to(poker,Math.abs(time),{x:pokerPoint.x,y:pokerPoint.y});
					if(view.handCardContainer.getChildByName(tableModel.getOtherPokerBackName(seat,1)))
					{
						poker.name = tableModel.getOtherPokerBackName(seat,2);
						poker.rotation = Math.PI * 30 / 180;
					}else
					{
						poker.name = tableModel.getOtherPokerBackName(seat,1);
					}
				}
				dispatch(new SoundEffectEvent(AssetsCenter.getSoundPath("fapai")));
			}
			trace("发手牌：",seat);
		}
		/**
		 * 翻桌牌 
		 * @param e
		 */		
		private function onFlopHandler(e:SimpleEvent):void
		{
			var card:FlopCardInfoVO = FlopCardInfoVO(e.carryData);
			//如果普通游戏记录
			if(gameModel.tableBaseInfoVO.type == TableInfoUtil.NORMAL_RING_GAME)
			{
				//记录log
				if(gameModel.tempRoundInfo)
				{
					if(card.index <= 3)
					{
						gameModel.tempRoundInfo.flopCards.push(card.card.number);
					}else if(card.index == 4)
					{
						gameModel.tempRoundInfo.turnCard = card.card.number;
					}else if(card.index == 5)
					{
						gameModel.tempRoundInfo.riverCard = card.card.number;
					}
				}
			}
			dispatch(new SoundEffectEvent(AssetsCenter.getSoundPath("fapai")));
			var interval:Number = 300 * card.index;
			interval = 0;
			setTimeout(showFlop,interval,card);
		}
		/**
		 * 倒计时奖励 
		 * @param e
		 * 
		 */		
		private function getCountDownBoxViewHandler(e:SimpleEvent=null):void
		{
			if(e.carryData)
			{
				var reinfoArr:Array=e.carryData["rewardinfo"];
				if(reinfoArr && reinfoArr.length>0)
				{
					var rewardInfo:RewardInfo=reinfoArr[0] as RewardInfo;
					if(rewardInfo)
					{
						if(String(rewardInfo.itemid)==ItemStringUtil.CHIP)
						{
							var tolNum:Number=this.userModel.myInfo.uMoney.toNumber();
							tolNum+=rewardInfo.count.toNumber();
							this.userModel.updateInfo({chip:tolNum},"");
							
						}
						var des:String = "";
						for(var i:String in reinfoArr)
						{
							rewardInfo = reinfoArr[i];
							var itemWordStr1:String=(ItemStringUtil.getItemDesName(String(rewardInfo.itemid)));
							var itemWordStr2:String=("x"+String(rewardInfo.count));
							des += itemWordStr1+itemWordStr2+"\n";
						}
						
						WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,des);
					}
				}				
			}
		}
		
		/**
		 * 翻牌逻辑 
		 * @param card
		 * 
		 */		
		private function showFlop(card:FlopCardInfoVO):void
		{
			var poker:PokerItemView = new PokerItemView;
//			poker.updateStyle(ConfigSO.getInstance().pokerIndex-1);
			//			poker.bindView(ResManager.getMCByName("20001_poker"));
//			poker.bindPokerBack(ResManager.getMCByName("20001_pokerBack"));
			poker.setData(card.card);
			poker.x = tableModel.flopStartPoint.x + (card.index - 1) * 54;
			poker.y = tableModel.flopStartPoint.y;
			view.cardContainer.addChild(poker);
			trace('showFlopshowFlopshowFlop');
//			poker.start(0,0.1);
		}
		/**
		 * 清空桌子，准备下一轮
		 * @param e
		 * 
		 */		
		private function resetTableHandler(e:Event):void
		{
			clearTable();
			
			if(gameModel.tableBaseInfoVO.maxRole == TableInfoUtil.VERY_SMALL_ROOM_NUMBER)
			{
			}else
			{
				HttpSendProxy.iamready(userModel.myInfo.userId,gameModel.tableBaseInfoVO.id);
			}
		}
		/**
		 * 强制清牌 
		 * @param e
		 * 
		 */		
		private function forceReset(e:Event):void
		{
			clearTable();
		}
		/**
		 * 清空牌桌 
		 * 
		 */		
		private function clearTable():void
		{
			//清空桌牌显示
			while(view.cardContainer.numChildren > 0)
			{
				view.cardContainer.removeChildAt( 0 );
			}
			//需要将item销毁
			var target:*;
			while(view.handCardContainer.numChildren > 0)
			{
				target = view.handCardContainer.getChildAt(0);
				target.dispose();
				view.handCardContainer.removeChildAt( 0 );
			}
			//清空手牌数据
			tableModel.handPoker.splice(0,tableModel.handPoker.length);
			//清空
			gameModel.reset();
			gameModel.cardCompareLock = false;
			//重置为第一回合,否则小盲下注会出问题
			tableModel.round = 1;
			
			for each(var item:TableClipVO in gameModel.clips)
			{
				item.clear();
			}
		}
	}
}