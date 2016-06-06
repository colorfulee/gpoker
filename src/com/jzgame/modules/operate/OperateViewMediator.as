package com.jzgame.modules.operate
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.SocketSendProxy;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.protobuff.PlayerActiontRequest;
	import com.jzgame.common.services.protobuff.PlayerStatus;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.PreOperateType;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.events.communication.NetSendEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.TableModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.model.UserProxy;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.vo.ActionVO;
	import com.jzgame.vo.SeatInfoVO;
	import com.jzgame.vo.UserBaseVO;
	import com.netease.protobuf.Int64;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import feathers.controls.Button;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	
	public class OperateViewMediator extends StarlingMediator
	{
		/***********
		 * name:    OperateViewMediator
		 * data:    Nov 18, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:OperateView;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var tableModel:TableModel;
		public function OperateViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(EventType.I_AM_IN_SEAT, iSeatHandler);
			addContextListener(EventType.NET_LOGIN_TABLE, loginHandler);
			addContextListener(EventType.SHOW_ALL_IN_READY_BTN, showReadyHandler);
			addContextListener(EventType.STAND_UP, standUpHandler);
			addContextListener(EventType.RESET, resetHandler);
			addContextListener(EventType.NET_FORCE_RESET_TABLE, resetHandler);
			addContextListener(EventType.COLLECT_CLIP, resetConsoleHandler);
			addContextListener(EventType.GUIDE_MY_TURN_TO_MAIN, turnCheckHandler);
			addContextListener(EventType.NET_LOGIN_TABLE, receiveLoginTableHandler);
			view.trigged.add(operate);
			
			view.opeList1.addEventListener(starling.events.Event.CHANGE, unSelectHandler);
			view.opeList2.addEventListener(starling.events.Event.CHANGE, unSelectHandler);
			view.opeList3.addEventListener(starling.events.Event.CHANGE, unSelectHandler);
		}
		
		override public function destroy():void
		{
			view.trigged.remove(operate);
			view.opeList1.removeEventListener(starling.events.Event.CHANGE, unSelectHandler);
			view.opeList2.removeEventListener(starling.events.Event.CHANGE, unSelectHandler);
			view.opeList3.removeEventListener(starling.events.Event.CHANGE, unSelectHandler);
			removeContextListener(EventType.I_AM_IN_SEAT, iSeatHandler);
			removeContextListener(EventType.NET_LOGIN_TABLE, loginHandler);
			removeContextListener(EventType.NET_LOGIN_TABLE, receiveLoginTableHandler);
			removeContextListener(EventType.SHOW_ALL_IN_READY_BTN, showReadyHandler);
			removeContextListener(EventType.RESET, resetHandler);
			removeContextListener(EventType.NET_FORCE_RESET_TABLE, resetHandler);
			removeContextListener(EventType.COLLECT_CLIP, resetConsoleHandler);
			removeContextListener(EventType.ACTION, actionHandler);
			removeContextListener(EventType.STAND_UP, standUpHandler);
			removeContextListener(EventType.GUIDE_MY_TURN_TO_MAIN, turnCheckHandler);
			removeContextListener(EventType.TURN, turnHandler);
		}
		/**
		 * 登录成功 
		 * @param e
		 * 
		 */		
		private function loginHandler(e:flash.events.Event):void
		{
			var length:uint = userModel.userList.length;
			trace(gameModel.tableBaseInfoVO.type);
			switch(gameModel.tableBaseInfoVO.type)
			{
				case TableInfoUtil.SIT_AND_GO:
					break;
				case TableInfoUtil.MTT:
				case TableInfoUtil.SPE_MTT:
					break;
				default:
					if(length >= gameModel.tableBaseInfoVO.maxRole)
					{
					}
					break;
			}
		}
		/**
		 *初始化桌子信息  
		 * 
		 */	
		private function receiveLoginTableHandler(e:flash.events.Event):void
		{
			if(gameModel.autoSit)
			{
				gameModel.autoSit = false;
				playNowHandler(null);
			}
		}
		/**
		 * 显示ready按钮 
		 * @param e
		 */		
		private function showReadyHandler(e:flash.events.Event):void
		{
//			view.ready();
		}
		/**
		 * 收到发牌 
		 * @param e
		 * 
		 */		
		private function resetConsoleHandler(e:flash.events.Event):void
		{
			gameModel.clipClear();
			
			updateState();
			
			//			clearPreSelect();
		}
		/**
		 *  取消预选
		 * @param e
		 * 
		 */		
		private function unSelectHandler(e:starling.events.Event):void
		{
			var target:PreOpeButton = e.currentTarget as PreOpeButton;
			var type:uint = uint(target.name);
			if(target.isSelected())
			{
				if(tableModel.preOperate != 0)
				{
					var un:PreOpeButton = view['opeList'+tableModel.preOperate];
					if(un)
						un.nonSelect();
				}
				tableModel.preOperate = type;
			}else
			{
				tableModel.preOperate = 0;
			}
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function turnCheckHandler(e:flash.events.Event):void
		{
//			view.showCheck(gameModel.tempClips.length == 0 ? true : false);
		}
		/**
		 * 重置
		 * @param e
		 * 
		 */		
		public function resetHandler(e:flash.events.Event):void
		{
			tableModel.preOperate = 0;
			view.unselectAll();
//			
//			view.call.isSelected = false;
//			view.checkFold.isSelected = false;
//			view.autoCall.isSelected = false;
//			view.autoCheck.isSelected = false;
//			view.autoFold.isSelected = false;
//			
//			updateConsoleState();
		}
		/**
		 * 立即开始牌局，坐下 
		 * @param e
		 * 
		 */		
		private function playNowHandler(e:MouseEvent):void
		{
			if(!UserProxy.checkChip(gameModel.tableBaseInfoVO.limit)) return ;
			//检查是否足够最小筹码
			if(!UserProxy.checkValid(gameModel.tableBaseInfoVO.minBuy,UserProxy.CHIP)) return ;
			
			var binds:Number = gameModel.tableBaseInfoVO.blinds * 200;
			var chips:Number = Math.min(binds,userModel.myInfo.uMoney.toNumber());
			var seat:uint = 1;
			var i:uint = 0;
			//如果是满员就围观
			if(gameModel.tableBaseInfoVO.maxRole == TableInfoUtil.BIG_ROOM_NUMBER)
			{
				for(i=1; i<=gameModel.tableBaseInfoVO.maxRole;i++)
				{
					if(tableModel.getUserBySeat(i))continue;
					
					seat = i;
					SocketSendProxy.sitDown(seat,new Int64(chips),false);
					return;
				}
			}else
			{
				for(i=1; i<=gameModel.tableBaseInfoVO.maxRole;i++)
				{
					seat = 1 + (i - 1) * 2;
					if(tableModel.getUserBySeat(seat))continue;
					SocketSendProxy.sitDown(seat,new Int64(chips),false);
					return;
				}
			}
		}
		
		private function operate(btn:Button):void
		{
			switch(btn)
			{
				case view.blind3Button:
					blind3Handler();
					break;
				case view.blind4Button:
					blind4Handler();
					break;
				case view.blind1Button:
					blind1Handler();
					break;
				case view.foldButton:
					foldHandler();
					break;
				case view.followButton:
					followHandler();
					break;
				case view.raiseButton:
					raiseHandler();
					break;
			}
		}
		/**
		 * 三倍大盲注下注 
		 * @param e
		 * 
		 */		
		private function blind3Handler():void
		{
			trace("三倍大盲注下注");
			var request:PlayerActiontRequest = new PlayerActiontRequest;
			request.userid = userModel.myInfo.userId;
			request.seatid = userModel.myInfo.uSeatIndex;
			if(gameModel.callClip == userModel.myInfo.uClip.toNumber())
			{
				request.userstatus = PlayerStatus.PLAYING_ALLIN;
			}else
			{
				request.userstatus = PlayerStatus.PLAYING_CALL;
			}
			var call:Number = Math.min(userModel.myInfo.uClip.toNumber(),gameModel.tableBaseInfoVO.blinds * 3 * 2);
			request.chips = new Int64(call,0);
			var bytest:ByteArray = new ByteArray;
			request.writeTo(bytest);
			
			eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_ACTION,bytest));
		}
		/**
		 * 4倍大盲 
		 * @param e
		 * 
		 */		
		private function blind4Handler():void
		{
			trace("4倍大盲注下注");
			var request:PlayerActiontRequest = new PlayerActiontRequest;
			request.userid = userModel.myInfo.userId;
			request.seatid = userModel.myInfo.uSeatIndex;
			if(gameModel.callClip == userModel.myInfo.uClip.toNumber())
			{
				request.userstatus = PlayerStatus.PLAYING_ALLIN;
			}else
			{
				request.userstatus = PlayerStatus.PLAYING_CALL;
			}
			var call:Number = Math.min(userModel.myInfo.uClip.toNumber(),gameModel.tableBaseInfoVO.blinds * 4 * 2);
			request.chips = new Int64(call,0);
			var bytest:ByteArray = new ByteArray;
			request.writeTo(bytest);
			
			eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_ACTION,bytest));
		}
		/**
		 * 一倍小盲
		 * @param e
		 * 
		 */		
		private function blind1Handler():void
		{
			trace("1倍大盲注下注");
			var request:PlayerActiontRequest = new PlayerActiontRequest;
			request.userid = userModel.myInfo.userId;
			request.seatid = userModel.myInfo.uSeatIndex;
			if(gameModel.callClip == userModel.myInfo.uClip.toNumber())
			{
				request.userstatus = PlayerStatus.PLAYING_ALLIN;
			}else
			{
				request.userstatus = PlayerStatus.PLAYING_CALL;
			}
			var call:Number = Math.min(userModel.myInfo.uClip.toNumber(),gameModel.tableBaseInfoVO.blinds * 2);
			request.chips = new Int64(call,0);
			var bytest:ByteArray = new ByteArray;
			request.writeTo(bytest);
			
			eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_ACTION,bytest));
		}
		/**
		 * 弃牌 
		 * @param e
		 * 
		 */		
		private function foldHandler():void
		{
			var request:PlayerActiontRequest = new PlayerActiontRequest;
			request.userid = userModel.myInfo.userId;
			request.seatid = userModel.myInfo.uSeatIndex;
			request.userstatus = PlayerStatus.PLAYING_FOLD;
			request.chips = new Int64(0,0);
			var bytest:ByteArray = new ByteArray;
			request.writeTo(bytest);
			
			dispatch(new NetSendEvent(MessageType.SEND_ACTION,bytest));
		}
		/**
		 * 跟牌 
		 * @param e
		 */		
		private function followHandler():void
		{
			var request:PlayerActiontRequest = new PlayerActiontRequest;
			request.userid = userModel.myInfo.userId;
			request.seatid = userModel.myInfo.uSeatIndex;
			if(gameModel.callClip == 0)
			{
				request.userstatus = PlayerStatus.PLAYING_CHECK;
			}else
			{
				if(gameModel.callClip == userModel.myInfo.uClip.toNumber())
				{
					request.userstatus = PlayerStatus.PLAYING_ALLIN;
				}else
				{
					request.userstatus = PlayerStatus.PLAYING_CALL;
				}
			}
			request.chips = new Int64(gameModel.callClip,0);
			var bytest:ByteArray = new ByteArray;
			request.writeTo(bytest);
			
			eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_ACTION,bytest));
		}
		/**
		 * 加注 
		 * @param e
		 * 
		 */		
		private function raiseHandler():void
		{
			if(view.raiseSlider.visible == false)
			{
				view.raiseSlider.visible = true;
			}else
			{
				view.raiseSlider.visible = false;
				myRaiseHandler(view.raiseSlider.num);
			}
		}
		/**
		 * 自己点击加注
		 * @param e
		 * 
		 */
		private function myRaiseHandler(chip:Number):void
		{
			if(gameModel.guide)
			{
//				var actionVo:ActionVO = new ActionVO(userModel.myInfo.uSeatIndex,PlayerStatus.PLAYING_CALL,200);
//				dispatch(new SimpleEvent(EventType.ACTION,actionVo));
//				tableModel.currentSeat = userModel.myInfo.uSeatIndex;
//				dispatch(new Event(EventType.NEXT_TURN));
//				dispatch(new Event(EventType.GUIDE_MY_CALL));
			}else
			{
				var request:PlayerActiontRequest = new PlayerActiontRequest;
				request.userid = userModel.myInfo.userId;
				request.seatid = userModel.myInfo.uSeatIndex;
				
				request.chips = new Int64(chip,0);
				if(request.chips.toNumber() == userModel.myInfo.uClip.toNumber())
				{
					request.userstatus = PlayerStatus.PLAYING_ALLIN;
				}else
				{
					request.userstatus = PlayerStatus.PLAYING_RAISE;
				}
				var bytest:ByteArray = new ByteArray;
				request.writeTo(bytest);
				dispatch(new NetSendEvent(MessageType.SEND_ACTION,bytest));
				
				operateEnd();
			}
		}
		
		/**
		 * 我坐下事件 
		 * @param e
		 */		
		private function iSeatHandler(e:flash.events.Event):void
		{
			//如果我坐下以后就有手牌，说明是断线重连,可以游戏,login的时候已经同步了当前玩家状态
			if(userModel.myInfo.cards.length > 0)
			{
			}else
			{
				var bet:Boolean = false;
				if(gameModel.tableBaseInfoVO.blinds>=Configure.jackpotConfig.getMinblind())
				{
					switch(gameModel.tableBaseInfoVO.type)
					{
						case TableInfoUtil.MTT:
						case TableInfoUtil.SPE_MTT:
						case TableInfoUtil.SIT_AND_GO:
							bet = true;
							break;
					}
				}
				//否则等待下一轮
				view.sitDown(bet);
			}
			//添加事件
			addContextListener(EventType.TURN, turnHandler);
			addContextListener(EventType.ACTION, actionHandler);
		}
		
		/**
		 * 回合处理 
		 * @param e
		 * 
		 */		
		private function turnHandler(e:SimpleEvent):void
		{
			var seat:uint = uint(e.carryData);
			//如果等待状态，不更新回合处理
			if(!gameModel.guide)
			{
				if(userModel.myInfo.uStatus == PlayerStatus.PLAYING_IDLE 
					|| userModel.myInfo.uStatus ==PlayerStatus.OBSERVING) 
				{
					trace("回合检查,你的状态是:"+userModel.myInfo.uStatus);
					return;
				}
			}
			
			var myTurn:Boolean = userModel.myInfo.uSeatIndex == seat;
			trace("轮到"+seat+"号位置的操作,是否是自己:"+myTurn);
			//如果弃牌，不需要显示回合
			var seatInfo:SeatInfoVO = tableModel.getUserBySeat(userModel.myInfo.uSeatIndex);
			if(seatInfo && seatInfo.userInfo.uStatus == PlayerStatus.PLAYING_FOLD)
			{
			}else
			{
				view.myTurn = myTurn;
			}
			//到我的回合
			if(myTurn)
			{
				checkOpenWindow();
				setSliderNum(gameModel.tableBaseInfoVO.blinds*2);
				gameModel.raiseMaxClip = gameModel.findWithoutMeMaxChip();
				//最大值不能超过自己的筹码数量
				gameModel.raiseMaxClip = Math.min(gameModel.raiseMaxClip,userModel.myInfo.uClip.toNumber());
				if(tableModel.preOperate == 0)
				{
					//设置最小为两倍小盲注
					gameModel.raiseMinClip = gameModel.tableBaseInfoVO.blinds * 2;
					gameModel.raiseClip = gameModel.raiseMinClip;
					
					var action:ActionVO = gameModel.getMoreAction();;
					//如果我是小盲
					if(tableModel.iamSmallBlinds && tableModel.round == 1)
					{
						//补齐盲注
						var less:Number = gameModel.tableBaseInfoVO.blinds * 2 - gameModel.myRoundClip;
						less = Math.max(0,less);
						//筹码增加的2倍
						var double:Number;
						if(!action)
						{
							double = gameModel.tableBaseInfoVO.blinds * 2;
						}else
						{
							double = (action.clip - gameModel.tableBaseInfoVO.blinds * 2) * 2;
						}
						gameModel.raiseClip =  Math.max(double,gameModel.tableBaseInfoVO.blinds * 2) + less;
						gameModel.raiseMinClip = gameModel.raiseClip;
					}else
					{
						if(!action)
						{
							//加注的钱要大于最小
							gameModel.raiseClip = gameModel.raiseMinClip;
							//							gameModel.raiseMinClip = 0;
						}else
						{
							//如果是check行为
							var checkLess:Number = action.clip - gameModel.myRoundClip;
							checkLess = Math.max(gameModel.tableBaseInfoVO.blinds,checkLess);
							gameModel.raiseClip = checkLess * 2;
							gameModel.raiseMinClip = gameModel.raiseClip;
						}
					}
					
					updateRaiseClipWithoutEvent();
					
					checkEnable();
				}else
				{
					var request:PlayerActiontRequest = new PlayerActiontRequest;
					request.userid = userModel.myInfo.userId;
					request.seatid = userModel.myInfo.uSeatIndex;
					request.chips = new Int64(0,0);
					switch(tableModel.preOperate)
					{
						case PreOperateType.CHECK_FOLD:
							if(gameModel.callClip > 0)
							{
								request.userstatus = PlayerStatus.PLAYING_FOLD;
							}else
							{
								request.userstatus = PlayerStatus.PLAYING_CHECK;
							}
							break;
						case PreOperateType.AUTO_CHECK:
							request.userstatus = PlayerStatus.PLAYING_CHECK;
							break;
						case PreOperateType.AUTO_CALL:
							request.chips = new Int64(gameModel.callClip,0);
							if(gameModel.callClip == userModel.myInfo.uClip.toNumber())
							{
								request.userstatus = PlayerStatus.PLAYING_ALLIN;
							}else
							{
								request.userstatus = PlayerStatus.PLAYING_CALL;
							}
							break;
					}
					trace('auto turnHandler:',request.chips.toNumber(),request.userstatus);
					var bytest:ByteArray = new ByteArray;
					request.writeTo(bytest);
					dispatch(new NetSendEvent(MessageType.SEND_ACTION,bytest));
					operateEnd();
				}
			}
		}
		/**
		 * 从座位站起 
		 * @param e
		 * 
		 */		
		private function standUpHandler(e:SimpleEvent):void
		{
			//添加事件
			var userBaseVO:UserBaseVO = UserBaseVO(e.carryData);
			if(userBaseVO.userId == userModel.myInfo.userId)
			{
				removeContextListener(EventType.TURN, turnHandler);
				removeContextListener(EventType.ACTION, actionHandler);
				view.standUp();
				
				//如果不是一般游戏模式,则不显示play now
				if(Math.floor(gameModel.tableBaseInfoVO.type) != TableInfoUtil.NORMAL_RING_GAME)
				{
//					view.standingView.visible = false;
				}
				
//				view.cardType.reset();
			}else
			{
				//				updateConsoleState();
			}
		}
		
		/**
		 * 行为 响应
		 * @param e
		 * 
		 */
		private function actionHandler(e:SimpleEvent):void
		{
			var action:ActionVO = e.carryData as ActionVO;
			gameModel.recordAction(action);
			
			//如果是自己的行为
			if(action.seatID == userModel.myInfo.uSeatIndex)
			{//大小盲的首轮筹码已经缓存
				switch(action.state)
				{
					case PlayerStatus.PLAYING_FOLD:
						view.fold();
						break;
					default:
						gameModel.myRoundClip += action.clip;
						break
				}
				view.raiseSlider.visible = false;
			}else
			{
				//如果玩家下注
				if(action.clip != 0)
				{
					//根据座位id
					var seatID:SeatInfoVO = tableModel.getUserBySeat(action.seatID);
					
					//获取下注最多的
					var getMore:ActionVO = gameModel.getMoreAction();
					var moreClip:Number  = Math.max(getMore.clip,gameModel.tableBaseInfoVO.blinds * 2);
					
					var callShowNumber:Number = moreClip - gameModel.myRoundClip;
					//不能小于0，防止大小盲下注异步
					callShowNumber = Math.max(0,callShowNumber);
					var tempCallClip:Number = gameModel.callClip;
					gameModel.callClip = Math.min(tableModel.getUserBySeat(userModel.myInfo.uSeatIndex).userInfo.uClip.toNumber(),callShowNumber);
					
					updatePreOperateState(tempCallClip!=gameModel.callClip);
				}else
				{
				}
				
				updateState();
			}
		}
		
		/**
		 * 检查是否有需要强制关闭的打开窗口
		 */		
		private function checkOpenWindow():void
		{
			var list:Array = WindowFactory.CHECK_WINDOWS;
			for(var i:String in list)
			{
//				var temp:PopUpWindow = PopUpWindowManager.getWindow(list[i]) as PopUpWindow;
//				if(temp)
//				{
//					WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("402201"));
//					return;
//				}
			}
		}
		
		/**
		 * 设置游标上的数字 
		 * @param slider
		 * 
		 */		
		private function setSliderNum(slider:Number):void
		{
			view.raiseSlider.setNum(slider);
		}
		
		/**
		 * 更新下注筹码 
		 * 避免因为除法运算，导致有差值
		 */
		private function updateRaiseClipWithoutEvent():void
		{
			gameModel.raiseClip = Math.min(gameModel.raiseClip,userModel.myInfo.uClip.toNumber());
			gameModel.raiseClip = Math.min(gameModel.raiseMaxClip,gameModel.raiseClip);
			gameModel.raiseMinClip = Math.min(gameModel.raiseMaxClip,gameModel.raiseMinClip);
			//设置最大值
			view.raiseSlider.setRange(gameModel.raiseClip,gameModel.raiseMaxClip);
			//如果最大跟最小一样，则到顶
			if(gameModel.raiseMaxClip == gameModel.raiseMinClip)
			{
				view.raiseSlider.value = 1;
//				enabledSliderArrow(false);
			}else
			{
//				enabledSliderArrow(true);
				view.raiseSlider.value = ( (gameModel.raiseClip - gameModel.raiseMinClip)/ (gameModel.raiseMaxClip - gameModel.raiseMinClip));
			}
			
			setSliderNum(gameModel.raiseClip);
		}
		/**
		 * 检测按钮 
		 * 
		 */		
		private function checkEnable():void
		{
//			var slider:Number= Math.floor(gameModel.tableBaseInfoVO.blinds) * 2;
//			var nValue:Number = view.slider.numValue - slider;
//			if(gameModel.raiseMinClip >= nValue)
//			{
//				nValue = gameModel.raiseMinClip;
//				view.slider.downBtn.enabled = false;
//			}else
//			{
//				view.slider.downBtn.enabled = true;
//			}
//			
//			nValue = view.slider.numValue + slider;
//			if(gameModel.raiseMaxClip <= view.slider.numValue)
//			{
//				view.slider.upBtn.enabled = false;
//			}else
//			{
//				view.slider.upBtn.enabled = true;
//			}
		}
		/**
		 *自己手动操作结束 
		 * 
		 */		
		private function operateEnd():void
		{
			//自己手动操作结束，将需要下的筹码重置
			gameModel.callClip = 0;
			updateState();
			clearPreSelect();
			view.myTurn = false;
			view.raiseSlider.visible = false;
//			view.slider.mouseEnabled = true;
//			view.slider.mouseChildren = true;
		}
		/**
		 * 清空预选 
		 * 
		 */		
		private function clearPreSelect():void
		{
			if(tableModel.preOperate != 0)
			{
				view.unselectAll();
				tableModel.preOperate = 0;
			}
		}
		/**
		 * 更新操作台状态 
		 * 
		 */		
		private function updateState():void
		{
			//根据下注筹码,显示
//			if(gameModel.callClip == 0)
//			{
//				view.call.setText(HtmlTransCenter.getHtmlStr(LangManager.getText("300917"),SystemColor.STR_WHITE,16));
//				view.myCall.setText(HtmlTransCenter.getHtmlStr(LangManager.getText("300917"),SystemColor.STR_WHITE,16));
//				view.myRaise.setText(HtmlTransCenter.getHtmlStr(LangManager.getText("300938"),SystemColor.STR_WHITE,16));
//				view.showCheck(true);
//				view.showPreCheck(true);
//			}else
//			{
//				view.myRaise.setText(HtmlTransCenter.getHtmlStr(LangManager.getText("300918"),SystemColor.STR_WHITE,16));
//				view.showPreCheck(false);
//				view.showCheck(false);
//				view.call.setText(HtmlTransCenter.getHtmlStr(LangManager.getText("300917")+" "+gameModel.callClip,SystemColor.STR_WHITE,16));
//				view.myCall.setText(HtmlTransCenter.getHtmlStr(LangManager.getText("300917")+" "+gameModel.callClip,SystemColor.STR_WHITE,16));
//			}
		}
		
		/**
		 * 更新预操作状态  ,如果筹码有改变,则去掉预选
		 * @param change 是否需要改变
		 * 
		 */			
		private function updatePreOperateState(change:Boolean):void
		{
			trace("updatePreOperateStateupdatePreOperateState:",tableModel.preOperate);
			switch(tableModel.preOperate)
			{
				//只有这种情况需要去除预选
				case PreOperateType.AUTO_CHECK:
					if(change)
					{
						view.unselectAll();
						tableModel.preOperate = 0;
					}
					break;
			}
		}
	}
}