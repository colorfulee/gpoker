package com.jzgame.modules.lobby
{
	import com.freshplanet.ane.AirFacebook.Facebook;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.LogType;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.events.HandleJoinTableEvent;
	import com.jzgame.loader.AssetsLoader;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.RoomModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.ExternalCenter;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.vo.room.RoomBaseInfoVO;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.interfaces.display.IPopUpWindow;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.SampleDataEvent;
	import flash.events.StatusEvent;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import feathers.controls.Alert;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	
	import lzm.starling.swf.Swf;
	import lzm.starling.swf.display.SwfMovieClip;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class RoomViewMediator extends StarlingMediator
	{
		[Inject]
		public var roomView:RoomView;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var userModel:UserModel;
		
		[Inject]
		public var roomModel:RoomModel;

		public function RoomViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addListeners();
			//每次到大厅就要请求一次日常信息,方便提醒日常任务领奖状态
//			HttpSendProxy.getDailyInfo();
//			HttpSendProxy.sendActivityList();
//			HttpSendProxy.sendSpeMttList();
//			AssetsLoader.addQuene("assets/effects/smile/smile.bytes");
//			AssetsLoader.addQuene("assets/effects/smile/smile.png");
//			AssetsLoader.addQuene("assets/effects/smile/smile.xml");
//			var file:File = File.applicationDirectory;
//			AssetsLoader.getAssetManager().enqueue("Untitled-2",[file.resolvePath(formatString("assets/effects/Untitled-2/",STLConstant.scale))],50);
//			AssetsLoader.getAssetManager().enqueue("winning10",[file.resolvePath(formatString("assets/effects/winning10/",STLConstant.scale))],50);
//			AssetsLoader.getAssetManager().enqueue("effect",[file.resolvePath(formatString("assets/effects/effect/",STLConstant.scale))],50);
//			AssetsLoader.loadQuene(showTest);
			roomView.start();

			var listCollection:ListCollection =  new ListCollection([{'index':1},{'index':2},{'index':3},{'index':4},{'index':5},{'index':6},{'index':6}]);
			roomView.toolList.dataProvider = listCollection;
			roomView.gameList.dataProvider = new ListCollection([{'index':1},{'index':2},{'index':3}]);
			roomView.gameList.selectedIndex = 1;
			roomView.toolList.x = (ReleaseUtil.STAGE_WIDTH - roomView.toolList.width ) *0.5;
			trace("test start!：");
		}
		
		private function addListeners():void
		{
			addContextListener(EventType.CHANGE_DAILY_TASK_TIP, dailyTaskTip);
			addContextListener(EventType.CHANGE_ROOM_TYPE, roomTypeChange);
			
			roomView.addCashBtn.addEventListener(starling.events.Event.TRIGGERED, addCashTriggered);
			roomView.taskBtn.addEventListener(starling.events.Event.TRIGGERED, taskTriggered);
			roomView.toolList.addEventListener( starling.events.Event.CHANGE, toolListChangeHandler );
			roomView.gameList.addEventListener(starling.events.Event.CHANGE, gameListTriggredHandler);
			roomView.stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
			SignalCenter.onGameTriggered.add(gameTriggeredHandler);
			
//			roomView.addCashBtn.addEventListener(TouchEvent.TOUCH, testSound);
		}
//		private function testSound(e:TouchEvent):void
//		{
//			if(e.getTouch(roomView.addCashBtn,TouchPhase.BEGAN))
//			{
//				record();
//			}else if(e.getTouch(roomView.addCashBtn,TouchPhase.ENDED))
//			{
//				trace("stop and play!",Vibration.isSupported);
//				var path:String = _audio.stop_audio();
//				_audio.hello(path);
//				_audio.play_audio(path);
////				if(Vibration.isSupported)
////				{
////					var vb:Vibration=new Vibration();
////					vb.vibrate(2000);
////				}
//			}
//		}
		
//		private var _track:PartyTrackAPI;
//		private function testPartyTrack():void
//		{
//			_track.start(6882,'6ee0dfe4cfdd208dab3cd14d8915d830');
//			trace("start end!：");
//			//_track.hello(result);
//		}
		
		private function record():void
		{
			trace("record!");
		}
		private var soundbyte:ByteArray = new ByteArray;
		private function onSampleData(event:SampleDataEvent):void
		{
			trace("record");
			while (event.data.bytesAvailable)
			{
				soundbyte.writeFloat(event.data.readFloat());
			}
		}
		private function onPlaySampleData(event:SampleDataEvent):void
		{
			trace("play",soundbyte.bytesAvailable);
			for (var i:int = 0; i < 8192 && soundbyte.bytesAvailable > 0; i++)
			{
				event.data.writeFloat(soundbyte.readFloat());
				event.data.writeFloat(soundbyte.readFloat());
			}
		}
		
		override public function destroy():void
		{
			SignalCenter.onGameTriggered.remove(gameTriggeredHandler);
			removeContextListener(EventType.CHANGE_ROOM_TYPE, roomTypeChange);
			removeContextListener(EventType.CHANGE_DAILY_TASK_TIP, dailyTaskTip);
			roomView.gameList.removeEventListener(starling.events.Event.CHANGE, gameListTriggredHandler);
			roomView.toolList.removeEventListener( starling.events.Event.CHANGE, toolListChangeHandler );
			roomView.stage.removeEventListener(flash.events.Event.RESIZE, resizeHandler);
			roomView.taskBtn.removeEventListener(starling.events.Event.TRIGGERED, taskTriggered);
			roomView.addCashBtn.removeEventListener(starling.events.Event.TRIGGERED, addCashTriggered);
			
			roomView.dispose();
		}
		
		private function showTest(p:Number):void
		{ 
			return;
			if(p == 1)
			{
				var swf:Swf = new Swf(AssetsLoader.getAssetManager().getByteArray("winning10"),AssetsLoader.getAssetManager(),500);
				var swfM:SwfMovieClip = swf.createMovieClip("mc_51001_winning_10");
				roomView.addChild(swfM);
				DisplayManager.centerByStage(swfM);
			}
		}
		/**
		 * 
		 * @param index
		 * 
		 */		
		private function gameTriggeredHandler(index:uint):void
		{
			switch(index)
			{
				case 0:
//					PopUpWindowManager.centerPopUpWindow((WindowFactory.addPopUpWindow(WindowFactory.RING_ROOM_WINDOW) as DisplayObject));
//					joinTableHandler();
					break;
				case 1:
					PopUpWindowManager.centerPopUpWindow((WindowFactory.addPopUpWindow(WindowFactory.RING_ROOM_WINDOW) as DisplayObject));
					break;
				case 2:
					break;
			}
		}
		
		private function resizeHandler(e:flash.events.Event):void
		{
		}
		/**
		 * 任务触发 
		 * @param e
		 * 
		 */		
		private function taskTriggered(e:starling.events.Event):void
		{
			var targett:IPopUpWindow = WindowFactory.addPopUpWindow(WindowFactory.MISSION_WINDOW);
			PopUpWindowManager.centerPopUpWindow(targett as DisplayObject);
		}
		/**
		 * 充值界面 
		 * @param e
		 * 
		 */		
		private function addCashTriggered(e:starling.events.Event):void
		{
			var targett:IPopUpWindow = WindowFactory.addPopUpWindow(WindowFactory.NOTE_WINDOW);
			PopUpWindowManager.centerPopUpWindow(targett as DisplayObject);
		}
		/**
		 * 列表选择 
		 * @param e
		 * 
		 */		
		private function toolListChangeHandler(e:starling.events.Event):void
		{
			var list:List = e.currentTarget as List;
			switch(list.selectedIndex + 1)
			{
				case 4:
					var target:IPopUpWindow = WindowFactory.addPopUpWindow(WindowFactory.MESSAGE_WINDOW);
					PopUpWindowManager.centerPopUpWindow(target as DisplayObject);
					
//					var test:PopUpMessageCenterWindow = new PopUpMessageCenterWindow;
//					var t:Sprite = new Sprite;
//					t.addChild(test);
//					roomView.addChild(t);
					break;
				case 1:
//					var targett:IPopUpWindow = WindowFactory.addPopUpWindow(WindowFactory.MISSION_WINDOW);
//					PopUpWindowManager.centerPopUpWindow(targett as DisplayObject);
					break;
				case 2:
					var pack:IPopUpWindow = WindowFactory.addPopUpWindow(WindowFactory.PACK_WINDOW);
					PopUpWindowManager.centerPopUpWindow(pack as DisplayObject);
//					handler_loginBTNclick();
					break;
				case 3:
					var store:IPopUpWindow = WindowFactory.addPopUpWindow(WindowFactory.STORE_WINDOW);
					PopUpWindowManager.centerPopUpWindow(store as DisplayObject);
//					handler_infoBTNclick();
					break;
				case 5:
					var friends:IPopUpWindow = WindowFactory.addPopUpWindow(WindowFactory.FRIENDS_WINDOW);
					PopUpWindowManager.centerPopUpWindow(friends as DisplayObject);
//					start();
					break;
				case 6:
					var rank:IPopUpWindow = WindowFactory.addPopUpWindow(WindowFactory.RANK_WINDOW);
					PopUpWindowManager.centerPopUpWindow(rank as DisplayObject);
//					dialog();
					break;
				case 7:
					var setting:IPopUpWindow = WindowFactory.addPopUpWindow(WindowFactory.GAME_SET_WINDOW);
					PopUpWindowManager.centerPopUpWindow(setting as DisplayObject);
//					logout();
					break;
			}
			
			roomView.toolList.selectedIndex = -1;
		}
		
		private function logout():void
		{
			trace("logout a logout");
			_facebook.closeSessionAndClearTokenInformation()
		}
		private function dialog():void
		{
			trace("creat a dialog");
//			_facebook.dialog("feed");
			Facebook.getInstance().webDialog("feed", null, errorHandler);
//			_facebook.shareStatusDialog();
		}
		private function errorHandler(data:Object):void
		{
			
		}
		
		private function start():void
		{
//			trace("i am from start!");
//			return;
			_facebook.openSessionWithPublishPermissions(PERMISSIONS,handler_openSessionWithPermissions);
		}
		private function start2():void
		{
//			trace("i am from start!");
//			return;
			_facebook.openSessionWithReadPermissions(PERMISSIONS,handler_openSessionWithPermissions);
		}
		private static const PERMISSIONS:Array = ["email", "user_about_me", "user_birthday", "user_hometown", "user_website", "offline_access", "read_stream", "publish_stream", "read_friendlists"];
		
		protected function handler_loginBTNclick():void
		{
			_facebook = Facebook.getInstance();
			
			if(!_facebook.isSessionOpen)
			{
				_facebook.openSessionWithReadPermissions([],handler_openSessionWithPermissions);
//				_facebook.openSessionWithPublishPermissions(PERMISSIONS, handler_openSessionWithPermissions);
				//_facebook.dialog("oauth", null, handler_dialog);
			}
			else
			{
				trace('isSessionOpen!');
			}
		}
		private var _facebook:Facebook;
//		private function loginIn():void
//		{
//			trace("loginIn:",Facebook.isSupported,ExternalVars.appID);
//			if(Facebook.isSupported)
//			{
//				_facebook = Facebook.getInstance();
//				trace("loginIn facebook:",_facebook);
//				if(_facebook)
//				{
//					_facebook.addEventListener(StatusEvent.STATUS, handler_status);
//					_facebook.init(ExternalVars.appID);
//					//_facebook.publishInstall(APP_ID);
////					setTimeout(checkSession, 1000);
//				}
//			}
//		}
		protected function handler_status($evt:StatusEvent):void
		{
			trace("handler_status:",$evt.code,$evt.type);
		}
		
		private function checkSession():void
		{
			var __isSessionOpen:Boolean = _facebook.isSessionOpen;
//			Alert.show("check session:"+__isSessionOpen,"xxxxxxxx",new ListCollection[{label:"ok"}]);
			trace("checkSession:",__isSessionOpen,_facebook.accessToken);
			if(__isSessionOpen)
			{
				loginSuccess();
			}else
			{
				setTimeout(checkSession, 1000);
			}
		}
		
		private function handler_openSessionWithPermissions($success:Boolean, $userCancelled:Boolean, $error:String = null):void
		{
			if($success)
			{
				loginSuccess();
			}
			trace("success:", $success, ",userCancelled:", $userCancelled, ",error:", $error);
		}
		
		protected function handler_infoBTNclick():void
		{
			_facebook.requestWithGraphPath("/me", null, "GET", handler_requesetWithGraphPath);
		}
		
		private function handler_dialog($data:Object):void
		{
			trace('handler_dialog:', JSON.stringify($data));
		}
		
		private function handler_requesetWithGraphPath($data:Object):void
		{
			Alert.show(JSON.stringify($data),"xxxxxxxx",new ListCollection[{label:"ok"}]);
			trace("handler_requesetWithGraphPath:", JSON.stringify($data));
		}
		
		private function loginSuccess():void
		{
			trace("i am from loginSuccess!:",_facebook.accessToken);
			ExternalVars.token = _facebook.accessToken;
			_facebook.publishInstall(ExternalVars.appID);
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function gameListTriggredHandler(e:starling.events.Event):void
		{
			var target:List = e.currentTarget as List;
			roomView.toolList.selectedIndex = -1;
		}
		
		private function dailyTaskTip(e:SimpleEvent):void
		{
			var show:Boolean = e.carryData;
			
		}
		/**
		 * 更改游戏模式 
		 * @param e
		 * 
		 */		
		private function playModeChange(e:starling.events.Event):void
		{
		}
		/**
		 * 更改赛事 
		 * @param e
		 * 
		 */		
		private function roomTypeChange(e:SimpleEvent):void
		{
		}
		
		/**
		 * 日常任务 
		 * @param e
		 * 
		 */		
		private function dailyBonus(e:MouseEvent):void
		{
			WindowFactory.addPopUpWindow(WindowFactory.DAILY_BONUS_WINDOW);
		}
		
		/**
		 * 自动加入牌局
		 * @param e
		 * 
		 */		
		private function playGameHandler(e:MouseEvent):void
		{
			HttpSendProxy.timestamp(LogType.PLAY_NOW);
			ExternalCenter.checkPoint(ExternalCenter.LOG_PLAY_NOW);
			dispatch(new flash.events.Event(EventType.PLAY_NOW_IN_TABLE));
			return;
		}
		
		/**
		 * 加入桌子  
		 * @param e
		 * 
		 */		
		private function selectTable(e:MouseEvent):void
		{
			var tvo:RoomBaseInfoVO = roomModel.getCurrentTable()[roomModel.selectedRow - 1];
			joinTable(tvo);
		}
		/**
		 * 加入桌子 
		 * @param tvo
		 * 
		 */		
		private function joinTable(tvo:RoomBaseInfoVO):void
		{
//			gameModel.tableBaseInfoVO = tvo;
			dispatch(new HandleJoinTableEvent(tvo.id.toString()))
		}
	}
}