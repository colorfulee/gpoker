package com.jzgame.command
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.utils.VersionDic;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.common.vo.VersionObject;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.model.RoomModel;
	import com.jzgame.util.ExternalCenter;
	
	import flash.events.IEventDispatcher;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.getTimer;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.framework.api.IInjector;
	
	public class GameStartCommand extends Command
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		
		[Inject]
		public var injector:IInjector;
		
		public function GameStartCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//if(ExternalVars.start_time.length > 0)
			{
				var timer:Number = getTimer();
				var range:Number = (timer/1000);
				HttpSendProxy.sendStartTime(range);
				Tracer.info("加载时间:"+range);
			}
			
			register();
			login();
//			eventDispatcher.dispatchEvent(new Event(EventType.INIT_SCENE));
		}
		
		private function register():void
		{
			//commands
//			commandMap.map(SocketServiceEvent.SOCKET_GET_SOMETHING,SocketServiceEvent).toCommand(NetReceivedCommand);
			
			injector.map(RoomModel).asSingleton();
//			HttpSendProxy.sendPlayerInit();
			
			initMenu();
//			HttpSendProxy.sendRemoteConfig(ConfigSO.getInstance());
		}
		/**
		 * 初始化版本号 
		 * 
		 */		
		private function initMenu():void
		{
			var contextMenu:ContextMenu = new ContextMenu();
			var menuItem:ContextMenuItem;
			var vo:VersionObject = VersionDic.getInstance().getPathVO("versionTime");
			if(vo)
			{
				menuItem = new ContextMenuItem("time:"+vo.newPath);
			}else
			{
				menuItem = new ContextMenuItem(ReleaseUtil.VERSION);
			}
			contextMenu.customItems.push(menuItem);
			menuItem = new ContextMenuItem("version:"+ReleaseUtil.versionPath);
			contextMenu.customItems.push(menuItem);
			contextMenu.hideBuiltInItems();
		}
		
		private function login():void
		{
			ExternalCenter.checkPoint(ExternalCenter.LOG_GAME_LOAD);
		}
	}
}