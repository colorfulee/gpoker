package com.jzgame.command.game
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.events.ModuleEvent;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.ModuleType;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.events.HandleJoinTableEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.MTTAttendModel;
	import com.jzgame.model.UserModel;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class JoinTableCommand extends Command
	{
		/*auther     :jim
		* file       :JoinTableCommand.as
		* date       :Apr 11, 2015
		* description:加入桌子
		*/
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var attendModel:MTTAttendModel;
		[Inject]
		public var event:HandleJoinTableEvent;
		public function JoinTableCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			gameModel.offLine = event.offLine;
			//如果是同一桌
			if(gameModel.tableBaseInfoVO.id.toString()==event.id)
			{
				eventDispatcher.dispatchEvent(new SimpleEvent(EventType.ERROR_CODE_WINDOW,20510));
			}else
			{
				var type:uint = Math.floor(Number(event.id)/10000);
				//如果是mtt就不需要请求信息
				if(type == TableInfoUtil.MTT || type==TableInfoUtil.SPE_MTT)
				{
					if(gameModel.inTable)
					{
						NetSendProxy.leaveTable(userModel.myInfo.userId);
						
						eventDispatcher.dispatchEvent(new Event(EventType.HIDE_TABLE));
					}else
					{
						gameModel.inTable = true;
					}
					
					attendModel.cancelAttendLater();
					
					gameModel.tableBaseInfoVO.id = uint(event.id);
//					Configure.gameConfig.tempHost = Configure.gameConfig.host;
//					Configure.gameConfig.tempPort = Configure.gameConfig.port;
					var moduleEvent:ModuleEvent = new ModuleEvent(ModuleEvent.LOAD_MODULE);
					moduleEvent.moduleName = ModuleType.TABLE;
					eventDispatcher.dispatchEvent(moduleEvent);
				}else
				{
					HttpSendProxy.sendTableInfo(uint(event.id));
				}
				//				gameModel.guide = false;
			}
		}
	}
}