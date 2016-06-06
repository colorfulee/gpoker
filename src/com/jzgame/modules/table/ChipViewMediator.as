package com.jzgame.modules.table
{
	import com.greensock.TweenMax;
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.services.protobuff.CardTypeEnum;
	import com.jzgame.common.services.protobuff.SeatInfo;
	import com.jzgame.common.services.protobuff.TableInfo;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.enmu.ClipType;
	import com.jzgame.enmu.DebugInfoType;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.RoseTalkType;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.events.DebugInfoEvent;
	import com.jzgame.events.RoseTalkEvent;
	import com.jzgame.events.SoundEffectEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.TableModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.vo.ActionVO;
	import com.jzgame.vo.ClipVO;
	import com.jzgame.vo.ResultVO;
	import com.jzgame.vo.TableClipVO;
	import com.netease.protobuf.Int64;
	import com.spellife.util.RealGameTimer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	public class ChipViewMediator extends StarlingMediator
	{
		/***********
		 * name:    ChipViewMediator
		 * data:    Nov 19, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:ChipView;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var tableModel:TableModel;
		[Inject]
		public var userModel:UserModel;
		
		private var resultTimer:RealGameTimer;
		private var resetTimer:RealGameTimer;
		public function ChipViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(EventType.COLLECT_CLIP, onCollectClipHandler);
			addContextListener(EventType.ACTION, onActionHandler);
			addContextListener(EventType.SHOW_RESULT, onShowResultHandler);
			addContextListener(EventType.NET_FORCE_RESET_TABLE, forceRestHandler);
			addContextListener(EventType.NET_INIT_TABLE, receiveTableInfoHandler);
		}
		
		override public function destroy():void
		{
			removeContextListener(EventType.NET_INIT_TABLE, receiveTableInfoHandler);
			removeContextListener(EventType.NET_FORCE_RESET_TABLE, forceRestHandler);
			removeContextListener(EventType.SHOW_RESULT, onShowResultHandler);
			removeContextListener(EventType.COLLECT_CLIP, onCollectClipHandler);
			removeContextListener(EventType.ACTION, onActionHandler);
			
			if(resultTimer)
			{
				resultTimer.stop();
				resultTimer.removeEventListener(TimerEvent.TIMER,nextResultCheckHandler);
				resultTimer.dispose();
				resultTimer = null;
			}
			
			if(resetTimer)
			{
				resetTimer.stop();
				resetTimer.removeEventListener(TimerEvent.TIMER,resetCheckHandler);
				resetTimer.dispose();
				resetTimer = null;
			}
			
			TweenMax.killAll(true);
		}
		
		/**
		 * login 的时候同步桌子信息 
		 * @param e
		 * 
		 */		
		private function receiveTableInfoHandler(e:SimpleEvent):void
		{
			var tableInfo:TableInfo = TableInfo(e.carryData);
			Tracer.info("同步桌子"+tableInfo.pots.length);
			for(var i:String in tableInfo.seatinfo)
			{
				var seat:SeatInfo = tableInfo.seatinfo[i];
				//获取对应池子的筹码vo 初始化自己面前池子筹码
				var item:ChipTableItem = initMyBet(seat.bet.toNumber(),seat.seatid);
				var clipVO:TableClipVO = new TableClipVO(seat.clip,ClipType.MAIN);
				gameModel.tempClips.push(clipVO);
			}
			
			//初始化池子信息
			if(tableInfo.pots.length > 0)
			{
				gameModel.pots = new Vector.<Int64>;
				for(var j:String in tableInfo.pots)
				{
					gameModel.pots.push(tableInfo.pots[j]);
				}
				updatePosts();
			}
		}
		
		/**
		 * 初始化玩家身前筹码 
		 * @param chip
		 * 
		 */		
		private function initMyBet(chip:Number,seat:uint):ChipTableItem
		{
			//获取对应池子的筹码vo 初始化自己面前池子筹码
			var clipItem:ChipTableItem = new ChipTableItem;
			var clips:Array;
			var t:Point = Configure.tableConfig.getChipPoint(seat);
			clipItem.num = chip;
			clipItem.x = t.x;
			clipItem.y = t.y;
			view.name = getOwnClipName(seat);
			view.eachChipContainer.addChild(clipItem);
			return clipItem;
		}
		/**
		 * 操作 
		 * @param e
		 */		
		private function onActionHandler(e:SimpleEvent):void
		{
			var actionVo:ActionVO = ActionVO(e.carryData);
			//如果下注筹码为0
			if(actionVo.clip == 0 ) return;
			var clipVO:TableClipVO;
			trace("some one action: seat:",actionVo.seatID,"state:",actionVo.state,"clip:",actionVo.clip);
			//查找是否存在个人当前轮下注的池子
			for each(var item:TableClipVO in gameModel.tempClips)
			{
				if(item.seatID == actionVo.seatID)
				{
					clipVO = item;
					break;
				}
			}
			
			var clipItem:ChipTableItem;
			//是否要清除新下注的筹码
			var needClean:Boolean = false;
			if(!clipVO)
			{
				clipVO = new TableClipVO(actionVo.clip,ClipType.MAIN);
				clipItem = new ChipTableItem;
				clipItem.name = getOwnClipName(actionVo.seatID);
				gameModel.tempClips.push(clipVO);
				view.eachChipContainer.addChild(clipItem);
			}else
			{
				needClean = true;
				clipVO.clip += actionVo.clip;
				clipItem = view.eachChipContainer.getChildByName(getOwnClipName(clipVO.seatID)) as ChipTableItem;
			}
			
			clipVO.seatID = actionVo.seatID;
			var p:Point = Configure.tableConfig.getSeatPoint(actionVo.seatID);
			var t:Point = Configure.tableConfig.getChipPoint(actionVo.seatID);
			clipItem.x = t.x;
			clipItem.y = t.y;
			if(needClean)
			{
				clipItem.num = ( clipVO.clip );
			}else
			{
				clipItem.num = ( actionVo.clip );
			}
		}
		
		/**
		 * 收集筹码 
		 * @param e
		 * 
		 */		
		private function onCollectClipHandler(e:Event):void
		{
			//如果最后一轮有下注,需要播完动画延时执行
			if(gameModel.tempClips.length > 0)
			{
				TweenMax.delayedCall(.8,onCollect);
			}else
			{
				onCollect();
			}
		}
		
		/**
		 * 收集筹码 
		 * 
		 */		
		private function onCollect():void
		{
			trace("i am from on collect!");
			tableModel.round +=1;
			//筹码池的vo
			var tableVO:TableClipVO;
			//筹码池显示
			var clipItem:ChipTableItem;
			var point:Point = Configure.tableConfig.getCollectChipPoint(ClipType.MAIN);
			for each(var item:TableClipVO in gameModel.tempClips)
			{
				tableVO = gameModel.clips[item.belongs - 1];
				tableVO.clip+=item.clip;
				clipItem = view.getChildByName(getOwnClipName(tableVO.seatID)) as ChipTableItem;
				if(!clipItem)
				{
					clipItem = new ChipTableItem;
					clipItem.name = getOwnClipName(tableVO.seatID);
//					tableVO.clipItemView.setLocation(point.x,point.y);
					view.eachChipContainer.addChild(clipItem);
				}
				//单个筹码池子显示对象
				clipItem.num = (tableVO.clip);
				
				var duration:Number = gameModel.collectClipTime / 1000 / clipItem.num;
				clipItem.removeFromParent(true);
//				clipItem.parent.removeChild(clipItem);
				//玩家前面的池子对象
//				item.clipItemView.flying(point,duration);
			}
			//			/如果为新手引导,记录
			if(gameModel.guide)
			{
				if(gameModel.pots.length == 0)
				{
					gameModel.pots.push(new Int64());
				}
				//如果有人下注
				if(tableVO)
				{
					gameModel.pots[0]=new Int64(gameModel.pots[0].toNumber() + tableVO.clip)
				}
			}
			updatePosts();
			
			gameModel.tempClips.splice(0,gameModel.tempClips.length);
			
			gameModel.clipClear();
		}
		
		/**
		 * 同步所有共同的池子 
		 * 
		 */		
		private function updatePosts():void
		{
			//筹码池的vo
			var tableVO:TableClipVO;
			//筹码池显示
			var clipItem:DealerChipTableItem;
			var point:Point = Configure.tableConfig.getCollectChipPoint(ClipType.MAIN);
			for (var i:String in gameModel.pots)
			{
				if(gameModel.pots[i].toNumber() != 0)
				{
					//获取对应池子的筹码vo
					tableVO = gameModel.clips[i];
					var chip:DealerChipTableItem = view.tableChipContainer.getChildByName(getClipName(Number(i) + 1)) as DealerChipTableItem;
					//如果不存在边池,则创建一个
					if(chip)
					{
					}else
					{
						chip = new DealerChipTableItem;
						chip.name = getClipName(Number(i) + 1);
						//都要显示
						view.tableChipContainer.addChild(chip);
					}
					//设置到响应的池子位置
					var collectPoint:Point;
					collectPoint = Configure.tableConfig.getCollectChipPoint( 1 + Number(i) );
					chip.x = collectPoint.x;
					chip.y = collectPoint.y;
					chip.num = (gameModel.pots[i].toNumber());
//					tableVO.clipItemView.alpha = 0;
//					TweenMax.to(tableVO.clipItemView,.8,{alpha:1});
					Tracer.info("强制同步池子:"+i+":"+gameModel.pots[i].toNumber()+","+collectPoint.x+":"+collectPoint.y);
				}
			}
		}
		/**
		 * 结果分筹码 
		 * @param e
		 * 
		 */		
		private function onShowResultHandler(e:SimpleEvent):void
		{
			var result:ResultVO = e.carryData as ResultVO;
			
			tableModel.resultQuene.push(result);
			
			Tracer.info(("onShowResultHandler clip id:"+result.chipID,DebugInfoType.INFO));
			if(result.chipID == ClipType.MAIN)
			{
				//如果最后一轮有下注,需要播完动画延时执行
				if(gameModel.tempClips.length > 0)
				{
					var dealy:Number = 0;
					for each(var clipVO:TableClipVO in gameModel.tempClips)
					{
						var myDelay:Number = tableModel.splitClip(clipVO.clip).length * 0.1 + 0.3 + 0.8;
						if(myDelay>dealy)
						{
							dealy = myDelay;
						}
					}
					Tracer.info("onShowResultHandler ==>"+dealy);
					TweenMax.delayedCall(dealy,onShowResult);
				}else
				{
					Tracer.info("onShowResultHandler nullllllllllll");
					onShowResult();
				}
			}
		}
		/**
		 * 显示结果 
		 * 
		 */		
		private function onShowResult():void
		{
			dispatch(new DebugInfoEvent("onShowResult result length:"+tableModel.resultQuene.length,DebugInfoType.INFO));
			var result:ResultVO = tableModel.resultQuene.shift();
			if(result)
			{
				for each(var userId:uint in result.winnerID)
				{
					if(userId == userModel.myInfo.userId)
					{
						//如果是我赢得了这一池子
						dispatch(new SimpleEvent(EventType.SHOW_RESULT_FLIP,result.winnerType));
						break;
					}
				}
				dispatch(new SoundEffectEvent(AssetsCenter.getSoundPath("all_in")));
				showEachResultClip(result);
				resultTimer = new RealGameTimer(1500);
				resultTimer.addEventListener(TimerEvent.TIMER,nextResultCheckHandler);
				resultTimer.start();
			}else
			{
				resetTimer = new RealGameTimer(3500);
				resetTimer.addEventListener(TimerEvent.TIMER,resetCheckHandler);
				resetTimer.start();
				startReset();
			}
		}
		/**
		 * 开始重置 
		 * 
		 */		
		private function startReset():void{
			//如果是all in模式，倒计时开始
			if(gameModel.tableBaseInfoVO.maxRole == TableInfoUtil.VERY_SMALL_ROOM_NUMBER)
			{
				if(gameModel.autoBuy)
				{
					HttpSendProxy.iamready(userModel.myInfo.userId,gameModel.tableBaseInfoVO.id);
				}else
				{
					WindowFactory.addPopUpWindow(WindowFactory.ALL_IN_MODE_COUNTING_WINDOW);
					//显示ready按钮
					dispatch(new Event(EventType.SHOW_ALL_IN_READY_BTN));
				}
			}
		}
		/**
		 * 检测是否结束 
		 * 
		 */		
		private function nextResultCheckHandler(e:TimerEvent):void
		{
			resultTimer.stop();
			resultTimer.removeEventListener(TimerEvent.TIMER,nextResultCheckHandler);
			resultTimer.dispose();
			resultTimer = null;
			onShowResult();
		}
		
		private function resetCheckHandler(e:TimerEvent):void
		{
			resetTimer.stop();
			resetTimer.removeEventListener(TimerEvent.TIMER,resetCheckHandler);
			resetTimer.dispose();
			resetTimer = null;
			reset();
		}
		/**
		 * 发送重置消息 
		 * 
		 */		
		private function reset():void
		{
			view.reset();
			dispatch(new Event(EventType.RESET));
			Tracer.info("clip reset result end!");
		}
		/**
		 * 牌局已经开始 
		 * @param e
		 * 
		 */		
		private function forceRestHandler(e:Event):void
		{
			if(resultTimer)
			{
				resultTimer.stop();
				resultTimer.removeEventListener(TimerEvent.TIMER,nextResultCheckHandler);
				resultTimer.dispose();
				resultTimer = null;
			}
			
			if(resetTimer)
			{
				resetTimer.stop();
				resetTimer.removeEventListener(TimerEvent.TIMER,resetCheckHandler);
				resetTimer.dispose();
				resetTimer = null;
			}
			
			dispatch(new DebugInfoEvent("===================== 强制新开牌局 ======================!",DebugInfoType.INFO));
		}
		
		/**
		 * 
		 * @param clipIndex
		 * 
		 */		
		private function showEachResultClip(resultVO:ResultVO):void
		{
			var result:ResultVO = resultVO;
			//如果需要比牌
			dispatch(new DebugInfoEvent("是否需要比牌,赢牌的牌型列表:"+resultVO.winnerCardList.length,DebugInfoType.INFO));
			if(resultVO.winnerCardList.length > 0)
			{
				dispatch(new SimpleEvent(EventType.CARD_COMPARE,resultVO));
			}
			//结算log，避免不需要比牌无log
			dispatch(new SimpleEvent(EventType.RESULT_LOG,resultVO));
			//箭头指向更改
			dispatch(new SimpleEvent(EventType.WIN_TURN,userModel.getCopyUserByID(result.winnerID[0]).uSeatIndex));
			//获取当前池子
			var table:TableClipVO = gameModel.clips[result.chipID-1];
			
			var clipLength:uint = result.clip.length;
			var clip:Number = 0;
			var winnerSeatId:uint = 0;
			for(var index:uint = 0; index<clipLength; index++)
			{
				clip = result.clip[index];
				winnerSeatId = userModel.getCopyUserByID(result.winnerID[index]).uSeatIndex;
				dispatch(new DebugInfoEvent("查找筹码池子:筹码数量:"+clip+":赢家座位id:"+winnerSeatId+":池子id:"+result.chipID+"赢家玩家id:"+result.winnerID[index],DebugInfoType.INFO));
				findClipView(clip,winnerSeatId,result.chipID);
				dispatch(new SimpleEvent(EventType.EARN_CLIP,new ClipVO(winnerSeatId,clip,result.winnerType)));
			}
			if(result.winnerType>=CardTypeEnum.FLUSHCARD)
			{
				dispatch(new RoseTalkEvent(RoseTalkType.GOOD_CARD_TYPE,userModel.getCopyUserByID(result.winnerID[0]).uNickName,result.winnerType));
				if(result.winnerType >= CardTypeEnum.FOURCARD)
				{
					dispatch(new Event(EventType.BIG_CARD_HAPPEN));
				}
			}
		}
		/**
		 * 赢家获得筹码动画
		 * @param clip 筹码值
		 * @param winnerSeatId 胜者座位
		 * @param clipIndex 筹码池id
		 * 
		 */		
		private function findClipView(clip:Number,winnerSeatId:uint,clipIndex:uint):void
		{
			var mc:DealerChipTableItem;
			var clips:Array = tableModel.splitClip(clip);
			var p:Point = Configure.tableConfig.getCollectChipPoint( clipIndex );
			var target:Point = Configure.tableConfig.getSeatPoint( ( winnerSeatId ));
			
			var startX:Number = p.x;
			//如果两落
			if(clips.length > 5)
			{
				startX = p.x - 12;
			}
			
//			for(var i:uint = 0; i<clips.length;i++)
//			{
//				mc = new DealerChipTableItem(clips[i]);
//				if(i>5)
//				{
//					mc.x = p.x + 12;
//				}else
//				{
//					mc.x = startX;
//				}
//				
//				mc.y = p.y;
//				view.addChild(mc);
//				TweenMax.to(mc,0.5,{x:target.x+i*3,y:target.y+(i%5)*3,onComplete:complete,onCompleteParams:[mc],delay:0.1 * ((i+1))});
//			}
//			//当前的彩池隐藏
//			var clipItem:ChipTableItem = view.getChildByName(getClipName(clipIndex)) as ChipTableItem;
//			if(clipItem)
//			{
//				clipItem.hideClip();
//				clipItem.clearAllClips();
//				dispatch(new DebugInfoEvent("findClipView===> 找到这个池子:筹码数量:"+clip+":赢家座位id:"+winnerSeatId+":池子id:"+"clipContainer_"+clipIndex,DebugInfoType.INFO));
//			}else
//			{
//				dispatch(new DebugInfoEvent("findClipView 没有招到这个池子:筹码数量:"+clip+":赢家座位id:"+winnerSeatId+":池子id:"+"clipContainer_"+clipIndex,DebugInfoType.INFO));
//			}
		}
		
		/**
		 * 获取自己池子名字
		 * @param clipIndex
		 * @return 
		 * 
		 */		
		private function getOwnClipName(seatId:uint):String
		{
			var clipname:String = "clipOwnContainer_"+seatId;
			return clipname;
		}
		/**
		 * 池子名字
		 * @param clipIndex
		 * @return 
		 * 
		 */		
		private function getClipName(clipIndex:uint):String
		{
			var clipname:String = "clipContainer_"+clipIndex;
			return clipname;
		}
	}
}