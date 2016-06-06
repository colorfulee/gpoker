package com.jzgame.command.game
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.events.ModuleEvent;
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.ModuleType;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.events.HandleJoinMTTEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.MTTAttendModel;
	import com.jzgame.model.SpeMTTAttendModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.vo.room.RoomBaseInfoVO;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class MTTJoinInCommand extends Command
	{
		/*auther     :jim
		* file       :MTTJoinInCommand.as
		* date       :Mar 12, 2015
		* description:
		*/
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var attendModel:MTTAttendModel;
		[Inject]
		public var speAttendModel:SpeMTTAttendModel;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var eventDis:IEventDispatcher;
		[Inject]
		public var event:HandleJoinMTTEvent;
		public function MTTJoinInCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			WindowFactory.removeAll();
			gameModel.tableBaseInfoVO = new RoomBaseInfoVO;
			gameModel.tableBaseInfoVO.id = TableInfoUtil.MTT * 10000;
			
			if(event.joinMatchId != "")
			{
				attendModel.MTTMatchId = event.joinMatchId;
			}
			attendModel.targetUid = event.targetUid;
			attendModel.obser = event.obv;
			var matchVO:Object ;
			//设置mtt服务器
			if(event.joinType == TableInfoUtil.SPE_MTT)
			{
				matchVO = speAttendModel.getMttInfoByMatchId(speAttendModel.SpeMTTMatchId);
				gameModel.tableBaseInfoVO.id = TableInfoUtil.SPE_MTT * 10000;
				//这里是方便从观察者入口进来的。
				if(event.joinMatchId != "")
				{
					speAttendModel.SpeMTTMatchId = event.joinMatchId;
				}
			}else
			{
				matchVO = attendModel.getMttInfoByMatchId(attendModel.MTTMatchId);
			}
			if(matchVO)
			{
				Configure.gameConfig.tempHost = matchVO.ip;
				Configure.gameConfig.tempPort = matchVO.port;
			}else
			{
				Configure.gameConfig.tempHost = Configure.gameConfig.host;
				Configure.gameConfig.tempPort = Configure.gameConfig.port;
			}
			
			if(gameModel.inTable)
			{
				NetSendProxy.leaveTable(userModel.myInfo.userId);
				
				eventDis.dispatchEvent(new Event(EventType.HIDE_TABLE));
			}else
			{
				gameModel.inTable = true;
			}
			
			var moduleEvent:ModuleEvent = new ModuleEvent(ModuleEvent.LOAD_MODULE);
			moduleEvent.moduleName = ModuleType.TABLE;
			eventDis.dispatchEvent(moduleEvent);
		}
	}
}