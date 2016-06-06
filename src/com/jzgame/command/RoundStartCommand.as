package com.jzgame.command
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.services.protobuff.DealCardPlayerResponse;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.LogType;
	import com.jzgame.enmu.RoseTalkType;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.events.RoseTalkEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.CardInfoUtil;
	import com.jzgame.vo.CardInfoVO;
	import com.jzgame.vo.PreRoundInfoVO;
	import com.jzgame.vo.PreRoundPlayerInfoVO;
	import com.jzgame.vo.UserBaseVO;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class RoundStartCommand extends Command
	{
		/*auther     :jim
		* file       :RoundStartCommand.as
		* date       :Feb 27, 2015
		* description:牌局开始集中处理
		*/
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		[Inject]
		public var event:SimpleEvent;
		public function RoundStartCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//记录牌局信息,每局开始都重置
			if(gameModel.tableBaseInfoVO.type == TableInfoUtil.NORMAL_RING_GAME)
			{
				gameModel.tempRoundInfo = new PreRoundInfoVO;
				gameModel.tempRoundInfo.blinds = gameModel.tableBaseInfoVO.blinds;
				for(var i:String in userModel.userList)
				{
					var vo:PreRoundPlayerInfoVO = new PreRoundPlayerInfoVO;
					vo.playerName = userModel.userList[i].uNickName;
					vo.userId = userModel.userList[i].userId;
					vo.seat = userModel.userList[i].uSeatIndex;
					vo.fbId = userModel.userList[i].uFB_ID;
					vo.startChip = userModel.userList[i].uClip.toNumber();
					gameModel.tempRoundInfo.playerList.push(vo);
				}
			}else
			{
				if(gameModel.tempRoundInfo)
				{
					gameModel.tempRoundInfo.dispose();
				}
				gameModel.tempRoundInfo = null;
			}
			update(null);
			
			HttpSendProxy.timestamp(LogType.HAND);
			
			eventDispatcher.dispatchEvent(new RoseTalkEvent(RoseTalkType.ROUND_START));
		}
		
		private function update(e:Event):void
		{
			var handPokerInfo:DealCardPlayerResponse = DealCardPlayerResponse(event.carryData);
			gameModel.dealSeatId = handPokerInfo.dealerseatid;
			eventDispatcher.dispatchEvent(new Event(EventType.SHOW_BUTTON));
			var vo:UserBaseVO = userModel.getUserByID(handPokerInfo.userid);
			if(handPokerInfo.card && handPokerInfo.card.length > 0)
			{
				var coverCard:CardInfoVO = CardInfoUtil.praseCardInfo(handPokerInfo.card[0]);
				var coverCard2:CardInfoVO = CardInfoUtil.praseCardInfo(handPokerInfo.card[1]);
//				gameModel.addHandPoker(handPokerInfo.userid,handPokerInfo.card);
				Tracer.debug("手牌:"+coverCard.toString() +coverCard2.toString());
				eventDispatcher.dispatchEvent(new SimpleEvent(EventType.NET_HAND_POKER,handPokerInfo.userid));
			}else
			{//围观玩家收到其他玩家发手牌，播动画
				Tracer.debug("围观玩家收到手牌:手牌长度:"+handPokerInfo.card.length+",庄座位是:"+handPokerInfo.dealerseatid);
//				gameModel.addHandPoker(handPokerInfo.userid,handPokerInfo.card);
				if(handPokerInfo.userid!=0)
				{
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.NET_HAND_POKER,handPokerInfo.userid));
				}
			}
		}
	}
}