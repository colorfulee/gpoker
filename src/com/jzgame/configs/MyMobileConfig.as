package com.jzgame.configs
{
	import com.jzgame.command.AppStartCommand;
	import com.jzgame.command.AssetsLoadCommand;
	import com.jzgame.command.HandleAchieCommand;
	import com.jzgame.command.HandleDailyBonusCommand;
	import com.jzgame.command.HandleGetSevenBonusCommand;
	import com.jzgame.command.HandleMsgDeleteCommand;
	import com.jzgame.command.HandleNoteCommand;
	import com.jzgame.command.HandleOnlineFriendsCommand;
	import com.jzgame.command.HandlePackCommand;
	import com.jzgame.command.HandlePlayGameCommand;
	import com.jzgame.command.HandleProcessMessageCommand;
	import com.jzgame.command.HandleUserSummaryCommand;
	import com.jzgame.command.HeartCommand;
	import com.jzgame.command.RoundStartCommand;
	import com.jzgame.command.communication.HttpHeartReturnCommand;
	import com.jzgame.command.communication.HttpReceivedCommand;
	import com.jzgame.command.communication.HttpReceivedPlayerInitCommand;
	import com.jzgame.command.communication.NetReceivedCommand;
	import com.jzgame.command.communication.NetSendCommand;
	import com.jzgame.command.game.GetRoomListCommand;
	import com.jzgame.command.game.JoinTableCommand;
	import com.jzgame.command.game.JoinTableUpdateCommand;
	import com.jzgame.command.safeBox.SafeBoxLoginCommand;
	import com.jzgame.command.safeBox.SafeBoxMoneyChangeCommand;
	import com.jzgame.command.safeBox.SafeBoxSetPassBackCommand;
	import com.jzgame.common.controller.HttpRequestCommand;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.LuckyWheelProxy;
	import com.jzgame.common.model.achiement.AchiementProxy;
	import com.jzgame.common.model.connect.ConnectCommand;
	import com.jzgame.common.model.connect.ConnectStartupCommand;
	import com.jzgame.common.model.friendList.FriendListProxy;
	import com.jzgame.common.model.gameFriends.GameFriendsProxy;
	import com.jzgame.common.model.message.HttpReceivedMessageCommand;
	import com.jzgame.common.model.message.MessageProxy;
	import com.jzgame.common.model.task.HttpReceivedTaskCommand;
	import com.jzgame.common.model.task.TaskProxy;
	import com.jzgame.common.services.HttpService;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.SocketService;
	import com.jzgame.common.services.http.events.HttpRequestEvent;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.services.socket.SocketServiceEvent;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.NetEventType;
	import com.jzgame.events.HandleJoinTableEvent;
	import com.jzgame.events.communication.NetSendEvent;
	import com.jzgame.mediator.windows.achie.PopUpAchieWindowMediator;
	import com.jzgame.mediator.windows.chat.ChatAnimViewMediator;
	import com.jzgame.mediator.windows.chat.ChatAtViewMediator;
	import com.jzgame.mediator.windows.chat.ChatDetailViewMediator;
	import com.jzgame.mediator.windows.chat.ChatQuickResponseViewMediator;
	import com.jzgame.mediator.windows.chat.ChatViewMediator;
	import com.jzgame.mediator.windows.friends.PopUpFriendsWindowMediator;
	import com.jzgame.mediator.windows.login.PopUpSignInWindowMediator;
	import com.jzgame.mediator.windows.message.PopUpMessageCenterWindowMediator;
	import com.jzgame.mediator.windows.note.PopUpNoteWindowMediator;
	import com.jzgame.mediator.windows.online.OnlineViewMediator;
	import com.jzgame.mediator.windows.pack.PopUpPackWindowMediator;
	import com.jzgame.mediator.windows.rank.PopUpRankWindowMediator;
	import com.jzgame.mediator.windows.ringGame.RingGameRoomWindowMediator;
	import com.jzgame.mediator.windows.rounds.PopUpRoundWindowMediator;
	import com.jzgame.mediator.windows.safeBox.PopUpSafeBoxWindowMediator;
	import com.jzgame.mediator.windows.safeBox.SafeGetViewMediator;
	import com.jzgame.mediator.windows.safeBox.SafeSaveViewMediator;
	import com.jzgame.mediator.windows.setting.PopUpGameSettingWindowMediator;
	import com.jzgame.mediator.windows.store.PopUpStoreWindowMediator;
	import com.jzgame.mediator.windows.task.PopUpTaskWindowMediator;
	import com.jzgame.mediator.windows.userInfo.MttInfoViewMediator;
	import com.jzgame.mediator.windows.userInfo.PopUpPlayerInfoInGameViewMediator;
	import com.jzgame.mediator.windows.userInfo.PopUpPlayerMyInfoInGameViewMediator;
	import com.jzgame.mediator.windows.userInfo.PopUpUserDetailWindowMediator;
	import com.jzgame.model.ActivitiesModel;
	import com.jzgame.model.BuffModel;
	import com.jzgame.model.DailyModel;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.MTTAttendModel;
	import com.jzgame.model.NoteModel;
	import com.jzgame.model.OnLineModel;
	import com.jzgame.model.PackageModel;
	import com.jzgame.model.PlayerRecordsModel;
	import com.jzgame.model.PreRoundInfoModel;
	import com.jzgame.model.RankModel;
	import com.jzgame.model.RoomModel;
	import com.jzgame.model.SpeMTTAttendModel;
	import com.jzgame.model.TableModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.model.WindowModel;
	import com.jzgame.modules.friends.FriendsInfoView;
	import com.jzgame.modules.friends.FriendsInfoViewMediator;
	import com.jzgame.modules.lobby.RoomView;
	import com.jzgame.modules.lobby.RoomViewMediator;
	import com.jzgame.modules.operate.OperateView;
	import com.jzgame.modules.operate.OperateViewMediator;
	import com.jzgame.modules.table.ChipView;
	import com.jzgame.modules.table.ChipViewMediator;
	import com.jzgame.modules.table.PlayersView;
	import com.jzgame.modules.table.PlayersViewMediator;
	import com.jzgame.modules.table.TableView;
	import com.jzgame.modules.table.TableViewMediator;
	import com.jzgame.modules.table.ui.TableUIView;
	import com.jzgame.modules.table.ui.TableUIViewMediator;
	import com.jzgame.modules.userInfo.UserInfoView;
	import com.jzgame.modules.userInfo.UserInfoViewMediator;
	import com.jzgame.signals.SignalJoinSocket;
	import com.jzgame.signals.SignalJoinTable;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.LessChipWindow;
	import com.jzgame.view.windows.PopUpCommunicateWindow;
	import com.jzgame.view.windows.achie.PopUpAchieDescriptionWindow;
	import com.jzgame.view.windows.achie.PopUpAchieWindow;
	import com.jzgame.view.windows.chat.ChatAnimView;
	import com.jzgame.view.windows.chat.ChatAtView;
	import com.jzgame.view.windows.chat.ChatDetailView;
	import com.jzgame.view.windows.chat.ChatQuickResponseView;
	import com.jzgame.view.windows.chat.ChatView;
	import com.jzgame.view.windows.friends.PopUpFriendsWindow;
	import com.jzgame.view.windows.login.PopUpSevenRewardWindow;
	import com.jzgame.view.windows.login.PopUpSignInWindow;
	import com.jzgame.view.windows.message.PopUpMessageCenterWindow;
	import com.jzgame.view.windows.note.PopUpFadeOutWindow;
	import com.jzgame.view.windows.note.PopUpNoteWindow;
	import com.jzgame.view.windows.online.OnlineView;
	import com.jzgame.view.windows.pack.PackDetailWindow;
	import com.jzgame.view.windows.pack.PopUpPackWindow;
	import com.jzgame.view.windows.rank.PopUpRankWindow;
	import com.jzgame.view.windows.ringGame.RingGameRoomWindow;
	import com.jzgame.view.windows.rounds.PopUpRoundWindow;
	import com.jzgame.view.windows.safeBox.PopUpSafeBoxLoginWindow;
	import com.jzgame.view.windows.safeBox.PopUpSafeBoxSetPwdWindow;
	import com.jzgame.view.windows.safeBox.PopUpSafeBoxWindow;
	import com.jzgame.view.windows.safeBox.SafeBoxGetView;
	import com.jzgame.view.windows.safeBox.SafeBoxSaveView;
	import com.jzgame.view.windows.setting.PopUpGameSettingWindow;
	import com.jzgame.view.windows.store.PopUpStoreWindow;
	import com.jzgame.view.windows.store.StoreBuyWindow;
	import com.jzgame.view.windows.task.PopUpTaskWindow;
	import com.jzgame.view.windows.userInfo.MttInfoView;
	import com.jzgame.view.windows.userInfo.PlayerInfoInGameView;
	import com.jzgame.view.windows.userInfo.PlayerMyInfoInGameView;
	import com.jzgame.view.windows.userInfo.PopUpUserDetailWindow;
	import com.starling.mediator.StarlingViewMediator;
	import com.starling.view.StarlingGame;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.api.LifecycleEvent;
	
	
	public class MyMobileConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		[Inject]
		public var signalCommandMap:ISignalCommandMap;
		
//		
		[Inject]
		public var contextView:ContextView;
		
		[Inject]
		public var logger:ILogger;

		[Inject]
		public var eventDis:IEventDispatcher;
		
		public function MyMobileConfig()
		{
		}
		
		public function configure():void
		{
			initModels();
			initMediators();
			initCommands();
			initServer();
			initWindows();
			
			
			//开始加载素材
			eventDis.dispatchEvent(new Event(EventType.ASSETS_START));
		}
		
		private function onLoadComplete():void
		{
			ResManager.start();
		}
		
		private function initModels():void
		{
			//作为唯一实例
			injector.map(UserModel).asSingleton();
			injector.map(RoomModel).asSingleton();
			injector.map(GameModel).asSingleton();
			injector.map(TableModel).asSingleton();
			injector.map(DailyModel).asSingleton();
			injector.map(BuffModel).asSingleton();
			injector.map(PackageModel).asSingleton();
			injector.map(MTTAttendModel).asSingleton();
			injector.map(SpeMTTAttendModel).asSingleton();
			injector.map(AchiementProxy).asSingleton();
			injector.map(PreRoundInfoModel).asSingleton();
			injector.map(MessageProxy).asSingleton();
			injector.map(TaskProxy).asSingleton();
			
			//作为唯一实例
			injector.map(FriendListProxy).asSingleton();
			injector.map(GameFriendsProxy).asSingleton();
			
			injector.map(WindowModel).asSingleton();
			injector.map(PlayerRecordsModel).asSingleton();
			injector.map(RankModel).asSingleton();
			injector.map(OnLineModel).asSingleton();
			injector.map(NoteModel).asSingleton();
			injector.map(ActivitiesModel).asSingleton();
			
			injector.map(LuckyWheelProxy).asSingleton();
//			injector.map( RegisterModule ).asSingleton();
//			injector.map(GameModel).asSingleton();
//			injector.map(WindowModel).asSingleton();
		}
		
		private function initMediators():void
		{
			mediatorMap.map(StarlingGame).toMediator(StarlingViewMediator);
			mediatorMap.map(RoomView).toMediator(RoomViewMediator);
			mediatorMap.map(UserInfoView).toMediator(UserInfoViewMediator);
			
			mediatorMap.map(TableView).toMediator(TableViewMediator);
			mediatorMap.map(TableUIView).toMediator(TableUIViewMediator);
			mediatorMap.map(OperateView).toMediator(OperateViewMediator);
			mediatorMap.map(PlayersView).toMediator(PlayersViewMediator);
			mediatorMap.map(ChipView).toMediator(ChipViewMediator);
			mediatorMap.map(PopUpMessageCenterWindow).toMediator(PopUpMessageCenterWindowMediator);
			mediatorMap.map(PopUpTaskWindow).toMediator(PopUpTaskWindowMediator);
			mediatorMap.map(PopUpStoreWindow).toMediator(PopUpStoreWindowMediator);
			mediatorMap.map(PopUpUserDetailWindow).toMediator(PopUpUserDetailWindowMediator);
			mediatorMap.map(PopUpRankWindow).toMediator(PopUpRankWindowMediator);
			mediatorMap.map(MttInfoView).toMediator(MttInfoViewMediator);
			mediatorMap.map(PopUpFriendsWindow).toMediator(PopUpFriendsWindowMediator);
			mediatorMap.map(PopUpPackWindow).toMediator(PopUpPackWindowMediator);
			mediatorMap.map(PopUpNoteWindow).toMediator(PopUpNoteWindowMediator);
			mediatorMap.map(PopUpGameSettingWindow).toMediator(PopUpGameSettingWindowMediator);
			mediatorMap.map(RingGameRoomWindow).toMediator(RingGameRoomWindowMediator);
			mediatorMap.map(PopUpAchieWindow).toMediator(PopUpAchieWindowMediator);
			mediatorMap.map(PopUpRoundWindow).toMediator(PopUpRoundWindowMediator);
			mediatorMap.map(FriendsInfoView).toMediator(FriendsInfoViewMediator);
			mediatorMap.map(PlayerInfoInGameView).toMediator(PopUpPlayerInfoInGameViewMediator);
			mediatorMap.map(PlayerMyInfoInGameView).toMediator(PopUpPlayerMyInfoInGameViewMediator);
			mediatorMap.map(PopUpSignInWindow).toMediator(PopUpSignInWindowMediator);
			mediatorMap.map(PopUpSafeBoxWindow).toMediator(PopUpSafeBoxWindowMediator);
			mediatorMap.map(SafeBoxSaveView).toMediator(SafeSaveViewMediator);
			mediatorMap.map(SafeBoxGetView).toMediator(SafeGetViewMediator);
			mediatorMap.map(OnlineView).toMediator(OnlineViewMediator);
			mediatorMap.map(ChatView).toMediator(ChatViewMediator);
			mediatorMap.map(ChatDetailView).toMediator(ChatDetailViewMediator);
			mediatorMap.map(ChatAnimView).toMediator(ChatAnimViewMediator);
			mediatorMap.map(ChatQuickResponseView).toMediator(ChatQuickResponseViewMediator);
			mediatorMap.map(ChatAtView).toMediator(ChatAtViewMediator);
		}
		
		private function initCommands():void
		{
//			signals
//			fuckCommand.map( RegisterSignal ).toCommand( GetInTableCommand );
			
			//events
//			commandMap.map( EventType.GAME_START ).toCommand( GameStartCommand );
			commandMap.map(LifecycleEvent.POST_INITIALIZE).toCommand(AppStartCommand);
			commandMap.map(LifecycleEvent.POST_INITIALIZE).toCommand(ConnectStartupCommand);
			commandMap.map( EventType.ASSETS_START ).toCommand( AssetsLoadCommand );
			
			commandMap.map( EventType.HEART_TO_SERVER ).toCommand( HeartCommand );
			
			commandMap.map( MessageType.PLAYER_INIT , HttpResponseEvent).toCommand( HttpReceivedPlayerInitCommand );
			commandMap.map( MessageType.PLAYER_LOGIN , HttpResponseEvent).toCommand( HttpReceivedPlayerInitCommand );
			commandMap.map( HttpRequestEvent.HTTP_REQUEST , HttpRequestEvent).toCommand( HttpRequestCommand );
			commandMap.map( HttpResponseEvent.HTTP_RESPONSE_RECEIVE, HttpResponseEvent).toCommand(HttpReceivedCommand);
			commandMap.map( MessageType.MESSAGE_DAILY_INFO, HttpResponseEvent).toCommand(HandleDailyBonusCommand);
			commandMap.map(MessageType.MESSAGE_GET_TABLE_INFO,HttpResponseEvent).toCommand(JoinTableUpdateCommand);
			commandMap.map( SocketServiceEvent.SOCKET_RECEIVED , SocketServiceEvent).toCommand( NetReceivedCommand );
			commandMap.map( NetEventType.SEND , NetSendEvent).toCommand( NetSendCommand );
			commandMap.map(EventType.PLAY_NOW_IN_TABLE).toCommand(HandlePlayGameCommand);
			//message
			commandMap.map(MessageType.MESSAGE_DELETE_MESSAGE, HttpResponseEvent).toCommand(HandleMsgDeleteCommand);
			commandMap.map(MessageType.MESSAGE_PROGCESS_MESSAGE, HttpResponseEvent).toCommand(HandleMsgDeleteCommand);
			commandMap.map(MessageType.MESSAGE_PROCESS, HttpResponseEvent).toCommand(HandleProcessMessageCommand);
			commandMap.map(MessageType.MESSAGE_GET).toCommand(HttpReceivedMessageCommand);
			commandMap.map( MessageType.TASK_GET ,HttpResponseEvent).toCommand( HttpReceivedTaskCommand);
			commandMap.map(MessageType.MESSAGE_PACKAGE, HttpResponseEvent).toCommand(HandlePackCommand);
			commandMap.map(MessageType.ACHIEVEMENT_GET, HttpResponseEvent).toCommand(HandleAchieCommand);
			commandMap.map(MessageType.PLAYER_SUMMARY, HttpResponseEvent).toCommand(HandleUserSummaryCommand);
			commandMap.map( MessageType.NOTE, HttpResponseEvent).toCommand(HandleNoteCommand);
			commandMap.map(MessageType.MESSAGE_GET_ROOM_LIST,HttpResponseEvent).toCommand(GetRoomListCommand);
			commandMap.map(EventType.ROUND_START, SimpleEvent).toCommand(RoundStartCommand);
			commandMap.map( MessageType.SEVEN_GET_REWARD, HttpResponseEvent).toCommand(HandleGetSevenBonusCommand);
			commandMap.map( MessageType.PLAYER_GET_ONLINE , HttpResponseEvent).toCommand( HandleOnlineFriendsCommand );
			commandMap.map(MessageType.SAFE_BOX_GET_BACK).toCommand(SafeBoxMoneyChangeCommand);
			commandMap.map(MessageType.SAFE_BOX_SAVE).toCommand(SafeBoxMoneyChangeCommand);
			commandMap.map(MessageType.SAFE_BOX_RESET_PWD).toCommand(SafeBoxMoneyChangeCommand);
			commandMap.map(MessageType.SAFE_BOX_LOGIN).toCommand(SafeBoxLoginCommand);
			commandMap.map(MessageType.SAFE_BOX_SET_PASSWARD).toCommand(SafeBoxSetPassBackCommand);
			commandMap.map(HandleJoinTableEvent.JOIN, HandleJoinTableEvent).toCommand(JoinTableCommand);
			commandMap.map( MessageType.HEART ,HttpResponseEvent).toCommand( HttpHeartReturnCommand );
//			commandMap.map(EventType.CHANGE_TABLE_COLOR, Event).toCommand(ChangeColorCommand);
			
			//需要传参数的时候用信号,否则要新建信号类- -麻烦
			signalCommandMap.map( SignalJoinTable ).toCommand(JoinTableCommand);
			signalCommandMap.map( SignalJoinSocket ).toCommand(ConnectCommand);
		}
		
		private function initServer():void
		{
			injector.map( SocketService ).asSingleton();
			injector.map( HttpService ).asSingleton();
		}
		
		private function initWindows():void
		{
			WindowFactory.register(WindowFactory.COMMUNICATE_WINDOW, PopUpCommunicateWindow);
			WindowFactory.register(WindowFactory.MESSAGE_WINDOW, PopUpMessageCenterWindow);
			WindowFactory.register(WindowFactory.MISSION_WINDOW, PopUpTaskWindow);
			WindowFactory.register(WindowFactory.STORE_WINDOW, PopUpStoreWindow);
			WindowFactory.register(WindowFactory.STORE_BUY_WINDOW, StoreBuyWindow);
			WindowFactory.register(WindowFactory.LESS_CHIP_WINDOW, LessChipWindow);
			WindowFactory.register(WindowFactory.PLAYER_INFO_WINDOW, PopUpUserDetailWindow);
			WindowFactory.register(WindowFactory.RANK_WINDOW, PopUpRankWindow);
			WindowFactory.register(WindowFactory.FRIENDS_WINDOW, PopUpFriendsWindow);
			WindowFactory.register(WindowFactory.PACK_WINDOW, PopUpPackWindow);
			WindowFactory.register(WindowFactory.NOTE_WINDOW, PopUpNoteWindow);
			WindowFactory.register(WindowFactory.PACK_DETAIL_WINDOW, PackDetailWindow);
			WindowFactory.register(WindowFactory.GAME_SET_WINDOW, PopUpGameSettingWindow);
			WindowFactory.register(WindowFactory.RING_ROOM_WINDOW, RingGameRoomWindow);
			WindowFactory.register(WindowFactory.ACHIEVE_WINDOW, PopUpAchieWindow);
			WindowFactory.register(WindowFactory.ROUND_WINDOW, PopUpRoundWindow);
			WindowFactory.register(WindowFactory.OTHER_USER_INFO_WINDOW, PlayerInfoInGameView);
			WindowFactory.register(WindowFactory.MY_INFO_WINDOW, PlayerMyInfoInGameView);
			WindowFactory.register(WindowFactory.SEVEN_LOGIN_BONUS_WINDOW, PopUpSignInWindow);
			WindowFactory.register(WindowFactory.SEVEN_LOGIN_REWARD_WINDOW, PopUpSevenRewardWindow);
			WindowFactory.register(WindowFactory.ACHIE_DETAIL_WINDOW, PopUpAchieDescriptionWindow);
			WindowFactory.register(WindowFactory.SAFE_BOX_WINDOW, PopUpSafeBoxWindow);
			WindowFactory.register(WindowFactory.SAFE_BOX_LOGIN_WINDOW, PopUpSafeBoxLoginWindow);
			WindowFactory.register(WindowFactory.FADE_TIP_WINDOW, PopUpFadeOutWindow);
			WindowFactory.register(WindowFactory.SAFE_BOX_PASS_WINDOW, PopUpSafeBoxSetPwdWindow);
			WindowFactory.register(WindowFactory.CHAT_DETAIL_WINDOW, ChatDetailView);
		}
	}
}