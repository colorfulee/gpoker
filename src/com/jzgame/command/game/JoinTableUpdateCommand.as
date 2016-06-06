package com.jzgame.command.game
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.LogType;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.signals.SignalJoinSocket;
	import com.jzgame.vo.room.MTTTableListInfo;
	import com.jzgame.vo.room.RoomBaseInfoVO;
	import com.jzgame.vo.room.SitAndGoTourTableListInfo;
	import com.jzgame.vo.room.SpeMTTTableListInfo;
	import com.jzgame.vo.room.SpecialAllInTableListInfo;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.util.TimerManager;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class JoinTableUpdateCommand extends Command
	{
		/*auther     :jim
		* file       :JoinTableUpdateCommand.as
		* date       :Apr 21, 2015
		* description:
		*/
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var event:HttpResponseEvent;
		
		[Inject]
		public var signalJoinSocket:SignalJoinSocket;
		public function JoinTableUpdateCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//			"is_fast": true,
			//			"is_double_exp": false,
			//			"max_buy": "10000",
			//			"min_buy": "1000",
			//			"blinds": "50/100",
			//			"online": "0/5",
			//			"table": "Lyon",
			//			"ip": "192.168.1.52:9088"
			//          "table_id"
			var result:Object = event.result;
			if(result)
			{
				var iip:String;
				var port:uint;
				gameModel.guide = false;
				gameModel.tableBaseInfoVO.id = uint(event.request.data[0]);
				if(gameModel.tableBaseInfoVO.type == TableInfoUtil.MTT)
				{
					var tableListInfo:MTTTableListInfo;
					tableListInfo = new MTTTableListInfo;
					tableListInfo.id = gameModel.tableBaseInfoVO.id;
					tableListInfo.match_id =result["match_id"];
					tableListInfo.rewards = result["desc"];
					tableListInfo.kick = TimerManager.getTimerFormat(result["start_time"]);
					tableListInfo.img = result["icon"];
					tableListInfo.requirement = result["cost_chip"];
					tableListInfo.costChip = result["cost_chip"];
					tableListInfo.costScore = result["cost_score"];
					tableListInfo.competitor = result["count"];
					tableListInfo.status = result["status"];
					tableListInfo.initial_players = result["initial_players"];
					tableListInfo.count = result["count"];
					tableListInfo.start_time = result["start_time"];
					tableListInfo.end_time = result["end_time"];
					tableListInfo.mtt_id = result["mtt_id"];
					tableListInfo.players_left = result["players_left"];
					if(result["result"])
					{
						tableListInfo.result = result["result"]["r"];
					}
					var ip:Array = result["ip"].split(AssetsCenter.COLON);
					tableListInfo.ip = ip[0];
					tableListInfo.port = ip[1];
					
					iip  = tableListInfo.ip;
					port = tableListInfo.port;
//					Configure.gameConfig.tempHost = tableListInfo.ip;
//					Configure.gameConfig.tempPort = tableListInfo.port;
				}else if(gameModel.tableBaseInfoVO.type == TableInfoUtil.SPE_MTT)
				{
					var spetableListInfo:SpeMTTTableListInfo;
					spetableListInfo = new SpeMTTTableListInfo;
					spetableListInfo.id = gameModel.tableBaseInfoVO.id;
					spetableListInfo.match_id =result["match_id"];
					spetableListInfo.rewards = result["desc"];
					spetableListInfo.kick = TimerManager.getTimerFormat(result["start_time"]);
					spetableListInfo.img = result["icon"];
					spetableListInfo.costChip = result["cost_chip"];
					spetableListInfo.costScore = result["cost_score"];
					spetableListInfo.competitor = result["count"];
					spetableListInfo.status = result["status"];
					spetableListInfo.initial_players = result["initial_players"];
					spetableListInfo.count = result["count"];
					spetableListInfo.start_time = result["start_time"];
					spetableListInfo.end_time = result["end_time"];
					spetableListInfo.mtt_id = result["mtt_id"];
					spetableListInfo.players_left = result["players_left"];
					if(result["result"])
					{
						spetableListInfo.result = result["result"]["r"];
					}
					var sip:Array = result["ip"].split(AssetsCenter.COLON);
					spetableListInfo.ip = sip[0];
					spetableListInfo.port = sip[1];
					
					iip  = sip[0];
					port = sip[1];
//					Configure.gameConfig.tempHost = spetableListInfo.ip;
//					Configure.gameConfig.tempPort = spetableListInfo.port;
				}
				else if(gameModel.tableBaseInfoVO.type == TableInfoUtil.SIT_AND_GO)
				{
					if(!result.hasOwnProperty("champion_prize"))
					{
						eventDispatcher.dispatchEvent(new SimpleEvent(EventType.ERROR_CODE_WINDOW,"找不到房间信息:"+event.request.data));
						return;
					}
					var sngtableInfo:SitAndGoTourTableListInfo;
					sngtableInfo = new SitAndGoTourTableListInfo;
					sngtableInfo.attendance_fee = result["attendance_fee"];
					sngtableInfo.online = result["kick_off_time"].split("/")[0];
					sngtableInfo.maxRole = result["kick_off_time"].split("/")[1];
					sngtableInfo.service_fee = result["service_fee"];
					sngtableInfo.sign_up = result["sign_up"];
					sngtableInfo.champion_prize = result["champion_prize"];
					sngtableInfo.host = result.ip.split(":")[0];
					sngtableInfo.port = result.ip.split(":")[1];
					
					var sngroom:RoomBaseInfoVO = gameModel.tableBaseInfoVO;
					sngroom.maxRole = sngtableInfo.maxRole;
					
					iip  = sngtableInfo.host;
					port = sngtableInfo.port;
//					Configure.gameConfig.tempHost = sngtableInfo.host;
//					Configure.gameConfig.tempPort = sngtableInfo.port;
				}else if(gameModel.tableBaseInfoVO.type == TableInfoUtil.ALL_IN)
				{
					if(!result.hasOwnProperty("online"))
					{
						eventDispatcher.dispatchEvent(new SimpleEvent(EventType.ERROR_CODE_WINDOW,"找不到房间信息:"+event.request.data));
						return;
					}
					var allInInfo:SpecialAllInTableListInfo = new SpecialAllInTableListInfo;
					allInInfo.reward = result["reward"];
					allInInfo.online = result["online"].split("/")[0];
					allInInfo.maxRole = result["online"].split("/")[1];
					allInInfo.enter_cost = result["enter_cost"];
					allInInfo.service_cost = result["service_cost"];
					allInInfo.table = result["table"];
					allInInfo.host = result.ip.split(":")[0];
					allInInfo.port = result.ip.split(":")[1];
					
					iip  = allInInfo.host;
					port = allInInfo.port;
//					Configure.gameConfig.tempHost = allInInfo.host;
//					Configure.gameConfig.tempPort = allInInfo.port;
				}else
				{
					var room:RoomBaseInfoVO = gameModel.tableBaseInfoVO;
					if(!result.hasOwnProperty("blinds"))
					{
						eventDispatcher.dispatchEvent(new SimpleEvent(EventType.ERROR_CODE_WINDOW,"找不到房间信息:"+event.request.data));
						return;
					}
					room.blinds = result.blinds.split("/")[0];
					room.maxBuy = result.max_buy;
					room.minBuy = result.min_buy;
					room.online = result.online.split("/")[0];
					room.maxRole = result.online.split("/")[1];
					room.tableName = result.table;
					room.limit = result.limit;
					room.host = result.ip.split(":")[0];
					room.port = result.ip.split(":")[1];
					
//					Configure.gameConfig.tempHost = room.host;
//					Configure.gameConfig.tempPort = room.port;
					iip  = room.host;
					port = room.port;
					HttpSendProxy.timestamp(LogType.JOIN_TABLE,room.id.toString());
				}
				
				if(gameModel.inTable)
				{
					NetSendProxy.leaveTable(userModel.myInfo.userId);
					
					eventDispatcher.dispatchEvent(new Event(EventType.HIDE_TABLE));
				}else
				{
					gameModel.inTable = true;
				}
				
				PopUpWindowManager.removeAll();
				
				signalJoinSocket.dispatch(iip,port);
			}
		}
	}
}