package com.jzgame.modules.table.ui
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.common.model.SocketSendProxy;
	import com.jzgame.common.services.protobuff.PlayerStatus;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.ConfigSO;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.LogType;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.TableModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.model.UserProxy;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.chat.ChatInputLineView;
	import com.jzgame.vo.UserBaseVO;
	import com.netease.protobuf.Int64;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import feathers.controls.Alert;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class TableUIViewMediator extends StarlingMediator
	{
		/***********
		 * name:    TableUIViewMediator
		 * data:    Nov 18, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:TableUIView;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var tableModel:TableModel;
		public function TableUIViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			SignalCenter.onChatShowInputTriggered.add(showInputView);
			SignalCenter.onChatInputSendTriggered.add(sendInputText);
			
			addContextListener(EventType.I_AM_IN_SEAT, iamSeated);
			addContextListener(EventType.STAND_UP, receiveStandUpHandler);
			view.toolView.toolList.addEventListener( starling.events.Event.CHANGE, toolListChangeHandler );
			view.toolButton.addEventListener(starling.events.Event.TRIGGERED,toolButtonHandler);
			view.stage.addEventListener(TouchEvent.TOUCH, toolViewHandler);
			if(userModel.getUserByID(userModel.myInfo.userId))
			{
				iamSeated(null);
			}else
			{
				if(userModel.userList.length >= gameModel.tableBaseInfoVO.maxRole)
				{
				}else
				{
				}
				
				loginHandler(null);
			}
			
			view.roomLabel.text = LangManager.getText("500004",gameModel.tableBaseInfoVO.id);
			
			view.toolView.toolList.dataProvider = new ListCollection([{label:'返回'},{label:'返回'},{label:'返回'}]);
			view.toolView.toolList.selectedIndex = -1;
			
			view.start();
		}
		
		override public function destroy():void
		{
			SignalCenter.onChatInputSendTriggered.remove(sendInputText);
			SignalCenter.onChatShowInputTriggered.remove(showInputView);
			
			view.stage.removeEventListener(TouchEvent.TOUCH, toolViewHandler);
			view.toolButton.removeEventListener(starling.events.Event.TRIGGERED,toolButtonHandler);
			removeContextListener(EventType.STAND_UP, receiveStandUpHandler);
			removeContextListener(EventType.I_AM_IN_SEAT, iamSeated);
			view.toolView.toolList.removeEventListener( starling.events.Event.CHANGE, toolListChangeHandler );
			view.dispose();
		}
		/**
		 * 
		 * @param word
		 * 
		 */		
		private function showInputView(word:String):void
		{
			var chatview:ChatInputLineView = new ChatInputLineView();
			view.addChild(chatview);
			chatview.text = word;
			chatview.y = ReleaseUtil.STAGE_HEIGHT - chatview.height;
			chatview.setFocus();
		}
		/**
		 * 聊天 
		 * @param word
		 * 
		 */		
		private function sendInputText(word:String):void
		{
			NetSendProxy.talk(userModel.myInfo.userId,word);
		}
		/**
		 *  
		 * @param e
		 * 
		 */		
		private function toolButtonHandler(e:starling.events.Event):void
		{
			view.toolView.visible = true;
			e.stopImmediatePropagation();
			e.stopPropagation();
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function toolViewHandler(e:starling.events.TouchEvent):void
		{
			if(e.getTouch(view.toolView,TouchPhase.ENDED))
			{
				
			}else
			{
				var target:DisplayObject = e.currentTarget as DisplayObject;
				if(target && e.getTouch(target) && e.getTouch(target).phase == TouchPhase.ENDED )
				{
					var point:Point = new Point(e.getTouch(target).globalX,e.getTouch(target).globalY);
					var rect:Rectangle = new Rectangle(0,0,136,215);
					if(!rect.containsPoint(point))
					{
						if(view.toolView.visible)
						{
							view.toolView.visible = false;
						}
					}
				}
			}
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function iamSeated(e:flash.events.Event):void
		{
		}
		/**
		 * 功能按钮
		 * @param e
		 * 
		 */		
		private function toolListChangeHandler(e:starling.events.Event):void
		{
			var list:List = List( e.currentTarget );
			switch(list.selectedIndex)
			{
				case 0:
					clickLobby();
					list.selectedIndex = -1;
					break;
				case 1:
					break;
				case 2:
					standUpHandler();
					list.selectedIndex = -1;
					break;
			}
			
			view.toolView.visible = false;
		}
		/**
		 * 触发起身
		 * @param e
		 * 
		 */		
		private function standUpHandler(e:* = null):void
		{
			if(ConfigSO.getInstance().muteStandUp || userModel.myInfo.uStatus == PlayerStatus.PLAYING_IDLE || userModel.myInfo.uStatus == PlayerStatus.OBSERVING|| userModel.myInfo.uStatus == PlayerStatus.PLAYING_FOLD)
			{
				standUp();
			}else
			{
				var tips:String = LangManager.getText("202023");
				Alert.show(tips,"message",new ListCollection([{label:"ok",triggered:standUp},{label:"cancel"}]));
			}
		}
		/**
		 * 起身
		 * 
		 */		
		private function standUp():void
		{
			NetSendProxy.standUp(userModel.myInfo.userId);
		}
		/**
		 * 玩家站起来 
		 * @param e
		 * 
		 */		
		private function receiveStandUpHandler(e:SimpleEvent):void
		{
			var userBaseVO:UserBaseVO = UserBaseVO(e.carryData);
			if(userBaseVO.userId == userModel.myInfo.userId)
			{
			}
			
			loginHandler(null);
		}
		/**
		 * 回大厅 
		 * @param e
		 */		
		private function clickLobby():void
		{
			if(ConfigSO.getInstance().muteStandUp || userModel.myInfo.uStatus == PlayerStatus.PLAYING_IDLE || userModel.myInfo.uStatus == PlayerStatus.OBSERVING)
			{
				returnLobby();
			}else
			{
				var tips:String = LangManager.getText("202023");
				Alert.show(tips,"message",new ListCollection([{label:"ok",triggered:confirmLobby},{label:"cancel"}]));
			}
		}
		/**
		 * 确认回大厅 
		 */		
		private function confirmLobby():void
		{
			HttpSendProxy.timestamp(LogType.GAME_EXIT);
			returnLobby();
		}
		/**
		 * 返回大厅
		 * 
		 */		
		private function returnLobby():void
		{
			WindowFactory.removeAll();
			AssetsCenter.eventDispatcher.dispatchEvent(new flash.events.Event(EventType.RETURN_LOBBY));
		}
		/**
		 * 登录成功 
		 * @param e
		 * 
		 */		
		private function loginHandler(e:flash.events.Event):void
		{
			var length:uint = userModel.userList.length;
			
			switch(gameModel.tableBaseInfoVO.type)
			{
				case TableInfoUtil.SIT_AND_GO:
//					view.imageButtonChangeTable.visible = false;
					break;
				case TableInfoUtil.MTT:
				case TableInfoUtil.SPE_MTT:
//					view.imageButtonChangeTable.visible = false;
					break;
				default:
					if(userModel.myInfo.uSeatIndex == 0)
					{
						if(length >= gameModel.tableBaseInfoVO.maxRole)
						{
//							view.imageButtonChangeTable.visible = true;
						}else
						{
//							view.imageButtonChangeTable.visible = false;
						}
					}
					break;
			}
		}
		private function playNow():void
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
					SocketSendProxy.sitDown(seat,new Int64(chips),true);
					return;
				}
			}else
			{
				for(i=1; i<=gameModel.tableBaseInfoVO.maxRole;i++)
				{
					seat = 1 + (i - 1) * 2;
					if(tableModel.getUserBySeat(seat))continue;
					SocketSendProxy.sitDown(seat,new Int64(chips),true);
					return;
				}
			}
		}
	}
}