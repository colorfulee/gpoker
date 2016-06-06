package com.jzgame.command.communication
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 10, 2013 11:00:07 AM 
	 * @description:消息处理分派中心
	 */ 
	
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.achiement.AchiementProxy;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.protobuff.AchivementTaskResponse;
	import com.jzgame.common.services.protobuff.BestCardsTypeResponse;
	import com.jzgame.common.services.protobuff.CombinedResponse;
	import com.jzgame.common.services.protobuff.CountDownBoxResponse;
	import com.jzgame.common.services.protobuff.DealCardPlayerResponse;
	import com.jzgame.common.services.protobuff.DealCardTableResponse;
	import com.jzgame.common.services.protobuff.GetCouponResponse;
	import com.jzgame.common.services.protobuff.GetPuzzleResponse;
	import com.jzgame.common.services.protobuff.GiveMoneyResponse;
	import com.jzgame.common.services.protobuff.GlobalMessageResponse;
	import com.jzgame.common.services.protobuff.GlobalMessageType;
	import com.jzgame.common.services.protobuff.InteractiveEvent;
	import com.jzgame.common.services.protobuff.ItemRemainingResponse;
	import com.jzgame.common.services.protobuff.JackPotResponse;
	import com.jzgame.common.services.protobuff.LoginResponse;
	import com.jzgame.common.services.protobuff.OpenCountDownBoxResponse;
	import com.jzgame.common.services.protobuff.PlayerActionResponse;
	import com.jzgame.common.services.protobuff.PlayerExitResponse;
	import com.jzgame.common.services.protobuff.PlayerGameRankResponse;
	import com.jzgame.common.services.protobuff.PlayerSettlementResponse;
	import com.jzgame.common.services.protobuff.ProtocalMessage;
	import com.jzgame.common.services.protobuff.RealTimeRankResponse;
	import com.jzgame.common.services.protobuff.ShowHoleCardsResponse;
	import com.jzgame.common.services.protobuff.ShowObserversResponse;
	import com.jzgame.common.services.protobuff.SitDownResponse;
	import com.jzgame.common.services.protobuff.SlotMachineResponse;
	import com.jzgame.common.services.protobuff.TalkingResponse;
	import com.jzgame.common.services.protobuff.TournamentCanceledResponse;
	import com.jzgame.common.services.protobuff.TournamentFinishedResponse;
	import com.jzgame.common.services.protobuff.UseInteractiveItemResponse;
	import com.jzgame.common.services.protobuff.WaitingForCombinationResponse;
	import com.jzgame.common.services.protobuff.WinnerPrize;
	import com.jzgame.common.services.protobuff.WinnerPrizeResponse;
	import com.jzgame.common.services.socket.SocketDataEvent;
	import com.jzgame.common.services.socket.SocketServiceEvent;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.enmu.ClipType;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.LogType;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.events.InterAnimEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.MTTAttendModel;
	import com.jzgame.model.PackageModel;
	import com.jzgame.model.PreRoundInfoModel;
	import com.jzgame.model.SpeMTTAttendModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.CardInfoUtil;
	import com.jzgame.util.ExternalCenter;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.vo.ActionVO;
	import com.jzgame.vo.CardInfoVO;
	import com.jzgame.vo.ChatMessageVO;
	import com.jzgame.vo.FlopCardInfoVO;
	import com.jzgame.vo.JackpotWinAlertVO;
	import com.jzgame.vo.PreRoundPlayerInfoVO;
	import com.jzgame.vo.ResultVO;
	import com.jzgame.vo.SlotAlertVO;
	import com.jzgame.vo.UserBaseVO;
	import com.jzgame.vo.WinnerCardInfo;
	import com.netease.protobuf.Int64;
	import com.spellife.util.TimerManager;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.setTimeout;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class NetReceivedCommand extends Command
	{
		[Inject]
		public var event:SocketServiceEvent;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var packModel:PackageModel;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var preModel:PreRoundInfoModel;
		[Inject]
		public var attendModel:MTTAttendModel;
		[Inject]
		public var speAttendModel:SpeMTTAttendModel;
		
		[Inject]
		public var achiementProxy:AchiementProxy;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var boo:Boolean = false;
		
		private function resultShow(result:WinnerPrizeResponse):void
		{
			var index:uint = 0;
			var prizeItem:WinnerPrize;
			var prizeLength:uint = result.prizes.length;
			for (index = prizeLength; index>0;index--)
			{
				var resultVO:ResultVO = new ResultVO;
				prizeItem = result.prizes[index-1];
				resultVO.chipID = index;
				resultVO.clip = prizeItem.winnerchips;
				resultVO.winnerID = prizeItem.userid;
				resultVO.winnerType = prizeItem.winnertype;
				var cardIndex:uint = 0;
				var winnerCardInfo:WinnerCardInfo;
				//保存所有的玩家的赢得牌,如果有5个人赢，则列表有5 * 5 张牌
				for each(var cardItem:uint in prizeItem.cardinfo)
				{
					cardIndex++;
					if(cardIndex == 1)
					{
						winnerCardInfo = new WinnerCardInfo;
						resultVO.winnerCardList.push(winnerCardInfo);
					}else if(cardIndex == 5)
					{
						cardIndex = 0;
					}
					
					winnerCardInfo.cardInfoList.push(CardInfoUtil.praseCardInfo(cardItem))
					//							resultVO.cardInfoList.push(CardInfoUtil.praseCardInfo(cardItem));
				}
				
				if(gameModel.tempRoundInfo)
				{
					for each(var playerInfo:PreRoundPlayerInfoVO in gameModel.tempRoundInfo.playerList)
					{
						for(var i:String in resultVO.winnerID)
						{
							if(playerInfo.userId == resultVO.winnerID[i])
							{
								if(resultVO.chipID == ClipType.MAIN)
								{
									playerInfo.isWin = true;
								}
								playerInfo.winChip +=resultVO.clip[i];
								playerInfo.winCardType = resultVO.winnerType;
							}
						}
					}
				}
				Tracer.debug("池子id:"+index+",赢家个数:"+prizeItem.userid.length);
				eventDispatcher.dispatchEvent(new SimpleEvent(EventType.SHOW_RESULT,resultVO));
			}
			
			if(gameModel.tempRoundInfo)
			{
				gameModel.tempRoundInfo.date = TimerManager.getCurrentSysTime();
				preModel.push(gameModel.tempRoundInfo);
				//保存
				preModel.flush();
			}
		}
		
		override public function execute():void
		{
			var model:ProtocalMessage = ProtocalMessage(event.data);
			Tracer.debug("收到网络消息:"+model.id+"错误码:"+model.errorcode)
			//如果有错误 10301
			if(model.errorcode > 0)
			{
				if(model.errorcode == 10301)
				{
					Alert.show(LangManager.getText("402203"),LangManager.getText("500003"),new ListCollection([{label:"ok",trigged:function ():void{ExternalCenter.refresh()}}]));
					eventDispatcher.dispatchEvent(new Event(EventType.STOP_GAME));
				}else
				{
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.ERROR_CODE_WINDOW,model.errorcode));
				}
				return;
			}
			var debug:String = "";
			switch(model.id)
			{
				//登陆
				case MessageType.RECEIVE_LOGIN_TABLE:
					Tracer.debug("收到网络消息无错误:登陆桌子");
					var login:LoginResponse = new LoginResponse;
					login.mergeFrom(model.content);
					if(login.tableinfo)
					{
						gameModel.tableBaseInfoVO.id  = login.tableinfo.id;
						gameModel.tableBaseInfoVO.blinds = login.tableinfo.blindchips.low / 2;
						gameModel.playerCD = login.tableinfo.actiontimeout;
					}

					userModel.login(login);
					//同步当前回合信息
					if(login.tableinfo.currentseatid > 0)
					{
						eventDispatcher.dispatchEvent(new SimpleEvent(EventType.TURN,login.tableinfo.currentseatid));
					}
					//log
					Tracer.debug(userModel.myInfo.uNickName+"本人进来了桌子id:"+login.tableinfo.id);
					break;
				case MessageType.RECEIVE_SIT_DOWN:
					Tracer.debug("收到网络消息无错误:坐下");
					var seat:SitDownResponse = new SitDownResponse;
					seat.mergeFrom(model.content);
					//log
					Tracer.debug(seat.playerinfo.username+"坐下了:");
					userModel.addUser(new UserBaseVO(seat.playerinfo));
					break;
				//收到手牌啊
				case MessageType.RECEIVE_HAND_POKER:
					Tracer.debug("收到网络消息无错误:收到手牌");
					
					var handPokerInfo:DealCardPlayerResponse = new DealCardPlayerResponse;
					handPokerInfo.mergeFrom(model.content);
					//更新玩家筹码等级等状态
					userModel.updateUserListInfo(handPokerInfo.playerinfo);
					if(userModel.getUserByID(handPokerInfo.userid))
					{
						//如果存在
						userModel.myInfo.cards = handPokerInfo.card;
						userModel.getUserByID(handPokerInfo.userid).cards = handPokerInfo.card;
					}else
					{
						
					}
					//强制清桌子，避免在播动画导致显示出错,并且同步玩家状态
					eventDispatcher.dispatchEvent(new Event(EventType.NET_FORCE_RESET_TABLE));
					
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.ROUND_START,handPokerInfo));
					
//					//下一回合
//					if(handPokerInfo.currentseatid != 0)
//					{
//						eventDispatcher.dispatchEvent(new SimpleEvent(EventType.TURN,handPokerInfo.currentseatid));
//					}
					break;
				case MessageType.RECEIVE_STAND_UP:
					Tracer.debug("收到网络消息无错误:站起来");
					var playerExit:PlayerExitResponse = new PlayerExitResponse;
					playerExit.mergeFrom(model.content);
					userModel.removeUser(playerExit.userid);
					break;
				case MessageType.RECEIVE_ACTION:
					Tracer.debug("收到网络消息无错误:操作行为");
					var actionInfo:PlayerActionResponse = new PlayerActionResponse;
					actionInfo.mergeFrom(model.content);
					var action:ActionVO = new ActionVO(actionInfo.lastseatid,actionInfo.lastuserstatus,Number(actionInfo.lastchips.toString(10)),actionInfo.lastuserid);
					//行为
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.ACTION,action));
					//log
					Tracer.debug("action:"+action.toString());
					//下一回合,如果有可以行动的
					if(actionInfo.currentseatid != 0)
					{
						eventDispatcher.dispatchEvent(new SimpleEvent(EventType.TURN,actionInfo.currentseatid));
					}
					break;
				//显示桌面 牌
				case MessageType.RECEIVE_TABLE_CARD:
					Tracer.debug("收到网络消息无错误:显示桌面牌");
					var tableCard:DealCardTableResponse = new DealCardTableResponse;
					tableCard.mergeFrom(model.content);
					
					var coverCard:CardInfoVO;
					for each(var item:Number in tableCard.card)
					{
						coverCard = CardInfoUtil.praseCardInfo(item);
						var flop:FlopCardInfoVO = new FlopCardInfoVO(gameModel.tableCardList.length + 1,coverCard);
						eventDispatcher.dispatchEvent(new SimpleEvent(EventType.FLOP_CARD,flop));
						gameModel.tableCardList.push(item);
						
						//log
						Tracer.debug("桌面牌:"+flop.toString());
					}
					
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.OPERATE_LOG_CARD,tableCard.card));
					
					gameModel.pots = Vector.<Int64>(tableCard.pots);
					eventDispatcher.dispatchEvent(new Event(EventType.COLLECT_CLIP));
					
					//下一回合,如果有可以行动的
					if(tableCard.currentseatid != 0)
					{
						eventDispatcher.dispatchEvent(new SimpleEvent(EventType.TURN,tableCard.currentseatid));
					}
					break;
				case MessageType.RECEIVE_RESULT:
					Tracer.debug("收到网络消息无错误:显示结果");
					var result:WinnerPrizeResponse = new WinnerPrizeResponse;
					result.mergeFrom(model.content);
					gameModel.pots = Vector.<Int64>(result.pots);
					eventDispatcher.dispatchEvent(new Event(EventType.COLLECT_CLIP));
					//克隆玩家状态,避免玩家此时退出，导致无个人信息
					userModel.copyUserList();
					
					HttpSendProxy.timestamp(LogType.GAME_ROUND);
					//比牌阶段
					if(result.handcard.length > 0)
					{
						eventDispatcher.dispatchEvent(new SimpleEvent(EventType.SHOW_OTHER_HAND_POKER,result.handcard));
					}
					//如果有桌牌未发完的情况，则先显示桌牌
					if(result.tablecard.length > 0)
					{
						for each(var resultItem:Number in result.tablecard)
						{
							var resultcoverCard:CardInfoVO = CardInfoUtil.praseCardInfo(resultItem);
							var flopVO:FlopCardInfoVO = new FlopCardInfoVO(gameModel.tableCardList.length + 1,resultcoverCard);
							eventDispatcher.dispatchEvent(new SimpleEvent(EventType.FLOP_CARD,flopVO));
							gameModel.tableCardList.push(resultItem);
							
							Tracer.debug("我也不知道这是什么鬼:"+flopVO.toString());
						}
						setTimeout(resultShow,300 * result.tablecard.length,result);
					}else
					{
						resultShow(result);
					}
					break;
				case MessageType.RECEIVE_MESSAGE:
					Tracer.debug("收到网络消息无错误:聊天显示");
					var chat:TalkingResponse = new TalkingResponse;
					chat.mergeFrom(model.content);
					Tracer.debug(chat.username + "发言了");
					
					var chatVO:ChatMessageVO = new ChatMessageVO;
					chatVO.content = chat.content;
					chatVO.uid = chat.userid;
					chatVO.name = chat.username;
					chatVO.type = chat.type;
					chatVO.anim = 0;
					if(chatVO.content.indexOf(ChatMessageVO.CHAT_ANIM)!=-1)
					{
						chatVO.anim = chat.content.split(ChatMessageVO.CHAT_ANIM)[1];
					}
					
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.CHAT,chatVO));
					break;
				
				case MessageType.RECEIVE_ACHIEMENT:
					debug = "收到网络消息无错误:收到成就";
					var achiement:AchivementTaskResponse = new AchivementTaskResponse;
					achiement.mergeFrom(model.content);
					var arr:Array = [];
					for(var mmm:String in achiement.aTid)
					{
						if(Math.floor(achiement.aTid[mmm] / 100000) == 7)
						{
							debug+=",成就id:"+achiement.aTid[mmm];
							arr.push(achiement.aTid[mmm]);
						}
					}
					
					achiementProxy.setData(arr);
					
					Tracer.debug(debug);
					break;
				case MessageType.USE_INTERACTIVE_ITEM_RESPONSE:
					var useInterItem:UseInteractiveItemResponse = new UseInteractiveItemResponse;
					useInterItem.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new InterAnimEvent(useInterItem.itemid,useInterItem.targetseatid,useInterItem.sourceseatid));
					break;
				case MessageType.BLINDS_CHANGE_RESPONSE:
					debug = "收到网络消息无错误:收到更改盲注";
					Tracer.debug(debug);
//					var blinds:BlindChangeResponse = new BlindChangeResponse;
//					blinds.mergeFrom(model.content);
//					gameModel.SNGBlinds = blinds.blind;
//					var view:SNGFadeOutBlindChangeTip = new SNGFadeOutBlindChangeTip;
//					view.setText(blinds.blind.toNumber() / 2 +"/"+blinds.blind.toNumber());
//					WindowModel.popUpContainer.addChild(view);
//					view.x = Math.floor((ReleaseUtil.STAGE_WIDTH - view.width) * 0.5);
//					view.y = Math.floor((ReleaseUtil.STAGE_HEIGHT - view.height) * 0.35);
//					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.BLIND_CHANGE,blinds.blind));
					break;
				case MessageType.RECEIVE_START_SLOT:
					var slotResponse:SlotMachineResponse = new SlotMachineResponse();
					slotResponse.mergeFrom(model.content);
					slotResponse.cards
					eventDispatcher.dispatchEvent(new SocketDataEvent(SocketDataEvent.SLOT_MACHINE_RESPONSE, slotResponse));
					break;
				case MessageType.TOUR_GAME_COUNT_RESPONSE:
					debug = "收到网络消息无错误:收到MTT结算排名";
					var count:PlayerGameRankResponse = new PlayerGameRankResponse;
					count.mergeFrom(model.content);
					Tracer.debug(debug + " 你的排名:"+count.rank);
					switch(count.gamemode)
					{
						case 1:
							WindowFactory.addPopUpWindow(WindowFactory.SNG_GAME_COUNT_WINDOW,null,count.rank,count.reward);
							break;
						case 2:
						//mtt
							//如果超过最后一桌
							if(count.rank>9)
							{
								WindowFactory.addPopUpWindow(WindowFactory.MTT_GAME_COUNT_WINDOW,null,count.rank);
							}
							//如果结算，则变成观察者
							attendModel.obser = true;
							
							if(attendModel.MTTMatchId)
							HttpSendProxy.sendMTTRankRequest(attendModel.MTTMatchId);
							break;
						case 3:
						//special mtt
							//如果超过最后一桌
							if(count.rank>9)
							{
								WindowFactory.addPopUpWindow(WindowFactory.MTT_GAME_COUNT_WINDOW,null,count.rank);
							}
							//如果结算，则变成观察者
							attendModel.obser = true;
							
							if(attendModel.MTTMatchId)
							HttpSendProxy.sendMTTRankRequest(attendModel.MTTMatchId);
							break;
					}
					break;
				case MessageType.MTT_REAL_RANK_RESPONSE:
					debug = "收到网络消息无错误:即时MTT排名";
					Tracer.debug(debug);
					var mttRank:RealTimeRankResponse = new RealTimeRankResponse;
					mttRank.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.MTT_MY_REAL_RANK,mttRank));
					break;
				case MessageType.MTT_WAITING_RESPONSE:
					debug = "收到网络消息无错误:MTT等待拼桌";
					Tracer.debug(debug);
					var mttWaiting:WaitingForCombinationResponse = new WaitingForCombinationResponse;
					mttWaiting.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new Event(EventType.MTT_SHOW_WAITING_PINZHUO));
					break;
				case MessageType.MTT_WAITING_END_RESPONSE:
					debug = "收到网络消息无错误:MTT拼桌完成";
					Tracer.debug(debug);
					var mttCombined:CombinedResponse = new CombinedResponse;
					mttCombined.mergeFrom(model.content);
					userModel.combine(mttCombined);
//					var window:PopUpWindow = PopUpWindowManager.getWindow(WindowFactory.MTT_WAITING_WINDOW) as PopUpWindow;
//					if(window)
//					{
//						PopUpWindowManager.removePopUpWindow(PopUpWindowManager.getWindow(WindowFactory.MTT_WAITING_WINDOW));
//					}
					break;
				case MessageType.MTT_FINISH_RESPONSE:
					var mttRankFinish:TournamentFinishedResponse = new TournamentFinishedResponse;
					mttRankFinish.mergeFrom(model.content);
					debug = "收到网络消息无错误:MTT比赛结束:id:"+mttRankFinish.id + ","+mttRankFinish.result;
					Tracer.debug(debug);
					var json:Object = JSON.parse(mttRankFinish.result);
					switch(gameModel.tableBaseInfoVO.type)
					{
						case TableInfoUtil.MTT:
							attendModel.mttRankList = json;
							WindowFactory.addPopUpWindow(WindowFactory.MTT_RESULT_RANK_LIST_WINDOW);
							eventDispatcher.dispatchEvent(new Event(EventType.MTT_FINISH));
							break;
						case TableInfoUtil.SPE_MTT:
							speAttendModel.mttRankList = json;
							WindowFactory.addPopUpWindow(WindowFactory.SPE_MTT_RESULT_RANK_LIST_WINDOW,null,json,userModel.myInfo.userId);
							eventDispatcher.dispatchEvent(new Event(EventType.MTT_FINISH));
							break;
					}
					break;
				case MessageType.PLAYER_SETTLEMENT_RESPONSE:
					debug = "收到网络消息无错误:比赛结束,玩家信息同步";
					Tracer.debug(debug);
					var playerFinish:PlayerSettlementResponse = new PlayerSettlementResponse;
					playerFinish.mergeFrom(model.content);
					userModel.ringGamePlayerInfoUpdate(playerFinish);
					break;
				case MessageType.PLAYER_BEST_CARD_TYPE_RESPONSE:
					debug = "收到网络消息无错误:玩家牌型同步";
					Tracer.debug(debug);
					var playerBest:BestCardsTypeResponse = new BestCardsTypeResponse;
					playerBest.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.UPDATE_MY_POKER_TYPE,playerBest.cardtype));
					break;
				case MessageType.GIVE_MONEY_RESPONSE:
					debug = "收到网络消息无错误:给荷官筹码";
					Tracer.debug(debug);
					var dealerMoney:GiveMoneyResponse = new GiveMoneyResponse;
					dealerMoney.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.UPDATE_GIVEN_MONEY,dealerMoney));
					break;
				case MessageType.MTT_START_RESPONSE:
					debug = "收到网络消息无错误:MTT 开始比赛";
					Tracer.debug(debug);
					eventDispatcher.dispatchEvent(new Event(EventType.MTT_START));
					break;
				case MessageType.INTER_EVENT_RESPONSE:
					debug = "收到网络消息无错误:互动事件";
					Tracer.debug(debug);
					var interEvent:InteractiveEvent = new InteractiveEvent;
					interEvent.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.INTER_EVENT,interEvent));
					break;
				case MessageType.ITEM_UPDATE_RESPONSE:
					debug = "收到网络消息无错误:道具数量更新事件";
					Tracer.debug(debug);
					var itemUpdateEvent:ItemRemainingResponse = new ItemRemainingResponse;
					itemUpdateEvent.mergeFrom(model.content);
					packModel.updateItem(itemUpdateEvent.item,itemUpdateEvent.count,itemUpdateEvent.countachi);
					break;
				case MessageType.TOUR_CANCEL:
					debug = "收到网络消息无错误:比赛取消";
					Tracer.debug(debug);
					var cancel:TournamentCanceledResponse = new TournamentCanceledResponse;
					cancel.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new Event(EventType.MTT_CANCEL));
					break;
				case MessageType.GLOBAL_MESSAGE_RESPONSE:
					debug = "收到网络消息无错误:全局小喇叭";
					Tracer.debug(debug);
					var louder:GlobalMessageResponse = new GlobalMessageResponse;
					louder.mergeFrom(model.content);
					
					if(louder.type == GlobalMessageType.LOUDER)
					{
						var messagejson:Object = JSON.parse(louder.message);
						var message:String = messagejson.say;
//						gameModel.messageList.push(new MessageAlertVO(LangManager.getText("202018"),JSON.parse(louder.message),Alert.OK));
						WindowFactory.addPopUpWindow(WindowFactory.MESSAGE_ALERT_WINDOW)
					}
					else if(louder.type == GlobalMessageType.JACK_POT_WINNER)
					{
						var jackpotWinVo:JackpotWinAlertVO = new JackpotWinAlertVO(JSON.parse(louder.message));
						WindowFactory.addPopUpWindow(WindowFactory.JACKPOT_LOTTERY_WINDOW,null,jackpotWinVo);
					}
					else
					{
						var slot:SlotAlertVO = new SlotAlertVO(JSON.parse(louder.message));
						WindowFactory.addPopUpWindow(WindowFactory.SLOT_ALERT,null,slot);
					}
					break;
				case MessageType.SHOW_HOLE_CARDS_RESPONSE:
					debug = "展示底牌";
					Tracer.debug(debug);
					var cards:ShowHoleCardsResponse = new ShowHoleCardsResponse;
					cards.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.SHOW_HOLE_CARDS,cards));
					break;
				case MessageType.COUNT_DOWN_BOX_RESPONSE:
					debug = "同步倒计时宝箱剩余时间";
					Tracer.debug(debug);
					var timeObj:CountDownBoxResponse=new CountDownBoxResponse();
					timeObj.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.COUNT_DOWN_BOX,timeObj));
					break;
				case MessageType.OBSERVER_PLAYERS:
					debug = "获得围观群众";
					Tracer.debug(debug);
					var obserPlayers:ShowObserversResponse = new ShowObserversResponse;
					obserPlayers.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.GET_OBSERVE_PLAYERS,obserPlayers.players));
					break;
				case MessageType.OPEN_COUNT_DOWN_BOX_RESPONSE:
					debug = "倒计时宝箱领奖";
					Tracer.debug(debug);
					var awardObj:OpenCountDownBoxResponse=new OpenCountDownBoxResponse();
					awardObj.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.OPEN_COUNT_DOWN_BOX,awardObj));
					break;
				case MessageType.JACK_POT_RESPONSE:
					debug = "大乐透奖池更新";
					Tracer.debug(debug);
					var jackpotChip:JackPotResponse=new JackPotResponse();
					jackpotChip.mergeFrom(model.content);
					gameModel.jack_pot=(jackpotChip.chips.toNumber());
					eventDispatcher.dispatchEvent(new Event(EventType.UPDATE_JACK_POT_BOUNS_POOL));
					break;
				case MessageType.GET_COUPON_RESPONSE:
					debug = "获得奖券";
					Tracer.debug(debug);
					var getcoupon:GetCouponResponse=new GetCouponResponse();
					getcoupon.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.GET_COUPON,getcoupon.count));
					break;
				case MessageType.GET_PUZZLE_RESPONSE:
					debug = "获得碎片";
					Tracer.debug(debug);
					var getpuzzle:GetPuzzleResponse=new GetPuzzleResponse();
					getpuzzle.mergeFrom(model.content);
					eventDispatcher.dispatchEvent(new SimpleEvent(EventType.GET_PUZZLE,getpuzzle.puzzle));
					break;
			}
			
		}
	}
}