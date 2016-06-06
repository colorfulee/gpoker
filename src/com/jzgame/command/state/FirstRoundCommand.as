package com.jzgame.command.state
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.services.protobuff.DealCardPlayerResponse;
	import com.jzgame.common.services.protobuff.PlayerStatus;
	import com.jzgame.enmu.Card;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.TableModel;
	import com.jzgame.vo.ActionVO;
	import com.jzgame.vo.CardInfoVO;
	import com.netease.protobuf.Int64;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class FirstRoundCommand extends Command
	{
		[Inject]
		public var table:TableModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var eventDis:IEventDispatcher;
		
		[Inject]
		public var event:SimpleEvent;
		
		public function FirstRoundCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var type:uint = uint(event.data);
			switch(type)
			{
				case 1:
					gameModel.dealSeatId = 7;
					table.dealerSeat = 7;
					//初始化设置
					table.currentSeat = table.findPreSeat(table.dealerSeat);
					//初始化缓存池子,
					gameModel.pots = new Vector.<Int64>;
					eventDis.dispatchEvent(new Event(EventType.NET_FORCE_RESET_TABLE));
					eventDis.dispatchEvent(new Event(EventType.SHOW_BUTTON));
					break;
				case 2:
					handPoker();
					break;
				case 3:
					turnHandle();
					break;
				case 4:
					actionHandler();
					break;
				//小盲注
				case 5:
					smallBlindActionHandler();
					break;
				//大盲注
				case 6:
					bigBlindActionHandler();
					break;
				case 8:
					bigBlindCheckAticon();
					break;
				case 7:
					handFold();
					break;
			}
		}
		/**
		 * 放弃手牌 
		 * 
		 */		
		private function handFold():void
		{
			var next:uint = table.next();
			var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_FOLD,0);
			eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
			table.currentSeat = next;
		}
		/**
		 * 发手牌 
		 * 
		 */		
		private function handPoker():void
		{
			var seat:uint = table.next();
			table.currentSeat = seat;
			var tableInfo:DealCardPlayerResponse = new DealCardPlayerResponse;
			
			tableInfo.userid=table.getUserBySeat(seat).userInfo.userId;
			if(seat == table.mySeat)
			{
				if(table.cardRound >= table.userCount)
				{
					tableInfo.card = [new CardInfoVO(Card.SUIT_DIAMONDS,Card.INFO_8)];
				}else
				{
					tableInfo.card = [new CardInfoVO(Card.SUIT_DIAMONDS,Card.INFO_J)];
				}
			}
			
			eventDis.dispatchEvent(new SimpleEvent(EventType.HAND_POKER,tableInfo));
			table.cardRound+=1;
			trace("table.cardRound:",table.cardRound,table.userCount);
			if(table.cardRound >= 2 * table.userCount)
			{
				table.currentSeat = table.dealerSeat;
				trace("发牌结束",table.userCount,table.currentSeat);
				eventDis.dispatchEvent(new Event(EventType.HAND_POKER_END));
			}else
			{
				
			}
		}
		/**
		 * 小盲压注 
		 * 
		 */		
		private function smallBlindActionHandler():void
		{
			var next:uint = table.next();
			var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_BLIND_LITTLE,100);
			eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
			table.currentSeat = next;
		}
		/**
		 * 大盲压注 
		 * 
		 */		
		private function bigBlindActionHandler():void
		{
			var next:uint = table.next();
			var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_BLIND_BIGGER,200);
			eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
			table.currentSeat = next;
		}
		/**
		 * 大盲check 
		 * 
		 */		
		private function bigBlindCheckAticon():void
		{
			var next:uint = table.next();
			var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_CHECK);
			eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
			table.currentSeat = next;
		}
		
		/**
		 * 第一轮行为 
		 * 
		 */		
		private function actionHandler():void
		{
			var next:uint = table.next();
			//如果轮到我操作
			if(next == table.mySeat)
			{
			}else
			{
				var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_CALL,200);
				eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
				table.currentSeat = next;
					trace("first turn action.",next);
				if(table.currentSeat == table.dealerSeat)
				{
					trace("first turn end.");
					eventDis.dispatchEvent(new Event(EventType.TURN_END));
				}else
				{
//					eventDis.dispatchEvent(new Event(EventType.NEXT_TURN));
				}
			}
		}
		
		/**
		 * 回合 
		 * 
		 */		
		private function turnHandle():void
		{
			var next:uint = table.next();
			eventDis.dispatchEvent(new SimpleEvent(EventType.TURN,next));
			
			trace("turn:next:",next,"current:"+table.currentSeat);
		}
	}
}