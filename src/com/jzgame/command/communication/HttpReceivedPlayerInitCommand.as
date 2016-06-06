package com.jzgame.command.communication
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.gameFriends.GameFriendsProxy;
	import com.jzgame.common.services.HttpService;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.common.vo.FriendVO;
	import com.jzgame.common.vo.GameFriendVO;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.events.HandleJoinMTTEvent;
	import com.jzgame.events.HandleJoinTableEvent;
	import com.jzgame.model.BuffModel;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.model.UserProxy;
	import com.jzgame.vo.room.MTTTableListInfo;
	import com.jzgame.vo.room.RoomBaseInfoVO;
	import com.jzgame.vo.room.SpeMTTTableListInfo;
	import com.netease.protobuf.Int64;
	import com.spellife.util.TimerManager;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HttpReceivedPlayerInitCommand extends Command
	{
		/*auther     :jim
		* file       :HttpReceivedPlayerInitCommand.as
		* date       :Nov 25, 2014
		* description:
		*/
		
		[Inject]
		public var event:HttpResponseEvent;
		
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var httpService:HttpService;
//		[Inject]
//		public var friendListProxy:FriendListProxy;
//		
		[Inject]
		public var gameFriendsProxy:GameFriendsProxy;
		
//		[Inject]
//		public var attendMtt:MTTAttendModel;
//		[Inject]
//		public var speMttAttendMtt:SpeMTTAttendModel;
//		[Inject]
//		public var onlineModel:OnLineModel;
		[Inject]
		public var buffModel:BuffModel;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		public function HttpReceivedPlayerInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
//			{"e":0,"r":{"uid":"444","fb_id":"765749800139421",
//				"user_info":{"name":"\u7ee7\u660e \u674e","exp":0,"rank":0,"chips":50000,"coin":0,"vip_level":0,"title":""},
//				"friends":{"283":{"name":"Jun Bao","fb_id":"810269149011533","coin":0,"chips":50000}}}}
			
			var result:Object = event.data["r"];
			var time:Number = result["time"];
			TimerManager.syncTime(time);
			var userInfo:Object = result["user_info"];
			userModel.myInfo.userId = userInfo["uid"];
			userModel.myInfo.uNickName = userInfo["name"];
			userModel.myInfo.uPendingExp = userInfo["exp"];
			userModel.myInfo.uLevelExp = userInfo["exp"];
			userModel.myInfo.uRank = userInfo["chip_rank"];
			userModel.myInfo.uTitle = userInfo["title"];
			userModel.myInfo.uGamePlayed = userInfo["play_num"];
			userModel.myInfo.uWinning = userInfo["winning"];
			userModel.myInfo.uMaxWin = userInfo["max_win"];
			userModel.myInfo.uScore = userInfo["score"];
			userModel.myInfo.uEverMaxScore = userInfo["score_get"];
			userModel.myInfo.userRealName = userInfo["user_nickname"];
			userModel.myInfo.userPhone = userInfo["user_phone"];
			userModel.myInfo.userEmail = userInfo["user_email"];
			userModel.myInfo.uMoney = new Int64(userInfo["chip"]);
			userModel.myInfo.uGold = userInfo["coin"];
			userModel.myInfo.uEquipId = userInfo["equip_gift_id"];
			userModel.myInfo.uFB_ID = result["fb_id"];
			userModel.myInfo.uVipLevel = userInfo["vip_level"];
			userModel.myInfo.uDealer = userInfo["dealer"];
			if(userModel.myInfo.uDealer == 0) userModel.myInfo.uDealer = 2001;
			userModel.myInfo.uTableBack = userInfo["background"];
			userModel.myInfo.guideStatus = userInfo["guide_status"];
			userModel.myInfo.uMaxCards = userInfo["max_card"];
			userModel.myInfo.isset_box_pwd = Number(userInfo["isset_box_pwd"]);
			userModel.myInfo.chip_box = Number(userInfo["chip_box"]);
			userModel.myInfo.todayLoginBonus = uint(userInfo["daily_login_bonused"]);
			userModel.myInfo.isLike = userInfo["is_like"] == "1" ? true : false;
			userModel.newer = userInfo["is_first_login"] == "0" ? true : false;
			userModel.myInfo.uLevel = Configure.playerLevel.getLevelByExp(userModel.myInfo.uLevelExp);
			UserProxy.myInfo = userModel.myInfo;
			//设置通讯user id
			httpService.userId = userModel.myInfo.userId;
			//更新好友信息
			var gameFriends:Object = result["game_friends"];
			var fr:FriendVO;
			var gf:GameFriendVO;
			var gameFriendArr:Array = [];
			for(var i:String in gameFriends)
			{
				gf = new GameFriendVO;
				gf.name = gameFriends[i]["name"];
				gf.chip = Number(gameFriends[i]["chip"]);
				gf.fb_id= gameFriends[i]["fb_id"];
				gf.id = i;
				gf.last_login_time= Number(gameFriends[i]["last_login_time"]);
				gameFriendArr.push(gf);
			}
			gameFriendsProxy.setData(gameFriendArr);
			
			var friends:Object = result["fb_friends"];
			var friendArr:Array = [];
			for(var j:String in friends)
			{
				fr = new FriendVO;
				fr.name = friends[j]["name"];
				fr.chip = friends[j]["chip"];
				fr.fb_id= friends[j]["fb_id"];
				friendArr.push(fr);
			}
//			friendListProxy.setData(friendArr);
//			//好友状态
//			var friendStatus:Object = result["online"];
//			if(friendStatus)
//			{
//				onlineModel.updateInfo(friendStatus);
//			}
//			//mtt报名信息
//			var mtt:Object = result["mtt_attend"];
//			if(mtt)
//			{
//				attendMtt.updateInfo(mtt);
//			}
//			//mtt报名信息
//			var speMtt:Object = result["spec_mtt_attend"];
//			if(speMtt)
//			{
//				speMttAttendMtt.updateInfo(speMtt);
//			}
			//是否在线重连
//			PopUpWindowManager.removePopUpWindow(PopUpWindowManager.getWindow(WindowFactory.LOADING_WINDOW));
			var offline:Object = result["offline_retry"];
			if(offline && offline["table_id"])
			{
				gameModel.tableBaseInfoVO = new RoomBaseInfoVO;
				var tableId:int = int(offline["table_id"]);
				if(offline["blinds"])
				{
					gameModel.tableBaseInfoVO.blinds = offline["blinds"].split("/")[0];
				}
				if(offline["online"])
				{
					gameModel.tableBaseInfoVO.online = offline["online"].split("/")[0];
					gameModel.tableBaseInfoVO.maxRole = offline["online"].split("/")[1];
				}
				if(offline["ip"])
				{
					gameModel.tableBaseInfoVO.host = offline["ip"].split(":")[0];
					gameModel.tableBaseInfoVO.port = offline["ip"].split(":")[1];
				}
				
				if(offline["table"])
				{
					gameModel.tableBaseInfoVO.tableName = offline["table"];
				}
				//如果进入的是MTT
				if(tableId ==  110001)
				{
					var tableListInfo:MTTTableListInfo;
					tableListInfo = new MTTTableListInfo;
					tableListInfo.id = tableId;
					tableListInfo.match_id =offline["match_id"];
					tableListInfo.rewards = offline["desc"];
					tableListInfo.kick = TimerManager.getTimerFormat(offline["start_time"]);
					tableListInfo.img = offline["icon"];
					tableListInfo.requirement = offline["cost_chip"];
					tableListInfo.costChip = offline["cost_chip"];
					tableListInfo.costScore = offline["cost_score"];
					tableListInfo.competitor = offline["count"];
					tableListInfo.status = offline["status"];
					tableListInfo.initial_players = offline["initial_players"];
					tableListInfo.count = offline["count"];
					tableListInfo.start_time = offline["start_time"];
					tableListInfo.end_time = offline["end_time"];
					tableListInfo.mtt_id = offline["mtt_id"];
					tableListInfo.players_left = offline["players_left"];
					if(offline["result"])
					{
						tableListInfo.result = offline["result"]["r"];
					}
					var ip:Array = offline["ip"].split(AssetsCenter.COLON);
					tableListInfo.ip = ip[0];
					tableListInfo.port = ip[1];
//					attendMtt.MTTMatchId = tableListInfo.match_id;
//					attendMtt.addMTTInfo(tableListInfo);
//					Configure.gameConfig.tempHost = tableListInfo.ip;
//					Configure.gameConfig.tempPort = tableListInfo.port;
					
					AssetsCenter.eventDispatcher.dispatchEvent(new HandleJoinMTTEvent(tableListInfo.match_id));
				}else if(tableId ==  120001)
				{
					var spetableListInfo:SpeMTTTableListInfo;
					spetableListInfo = new SpeMTTTableListInfo;
					spetableListInfo.id = tableId;
					spetableListInfo.match_id =offline["match_id"];
					spetableListInfo.rewards = offline["desc"];
					spetableListInfo.kick = TimerManager.getTimerFormat(offline["start_time"]);
					spetableListInfo.img = offline["icon"];
					spetableListInfo.costChip = offline["cost_chip"];
					spetableListInfo.costScore = offline["cost_score"];
					spetableListInfo.competitor = offline["count"];
					spetableListInfo.status = offline["status"];
					spetableListInfo.initial_players = offline["initial_players"];
					spetableListInfo.count = offline["count"];
					spetableListInfo.start_time = offline["start_time"];
					spetableListInfo.end_time = offline["end_time"];
					spetableListInfo.mtt_id = offline["mtt_id"];
					spetableListInfo.players_left = offline["players_left"];
					if(offline["result"])
					{
						spetableListInfo.result = offline["result"]["r"];
					}
					var sip:Array = offline["ip"].split(AssetsCenter.COLON);
					spetableListInfo.ip = sip[0];
					spetableListInfo.port = ip[1];
//					speMttAttendMtt.SpeMTTMatchId = tableListInfo.match_id;
//					speMttAttendMtt.addMTTInfo(tableListInfo);
//					Configure.gameConfig.tempHost = tableListInfo.ip;
//					Configure.gameConfig.tempPort = tableListInfo.port;
					
					var speMttevent:HandleJoinMTTEvent = new HandleJoinMTTEvent(tableListInfo.match_id);
					speMttevent.joinType = TableInfoUtil.SPE_MTT;
					AssetsCenter.eventDispatcher.dispatchEvent(speMttevent);
				}else
				{
					eventDispatcher.dispatchEvent(new HandleJoinTableEvent(offline["table_id"].toString(),true));
				}
				
//				"is_fast": false,
//				"is_double_exp": false,
//				"max_buy": "400000",
//				"min_buy": "40000",
//				"blinds": "2000/4000",
//				"online": "0/5",
//				"table": "Paris",
//				"ip": "192.168.1.52:9088",
//				"table_id" : 10001
			}else
			{
				eventDispatcher.dispatchEvent(new Event(EventType.INIT_SCENE));
			}
			
//			"buff": {
//				"4008": {
//					"end_time": "1421037382"
//				}
//			},
			//更新buff信息
			var buff:Object = result["buff"];
			if(buff)
			{
				for(var bfi:String in buff)
				{
					buffModel.addBuff(bfi,buff[bfi]["end_time"]);
				}
			}

			SignalCenter.onUpdateUserInfo.dispatch();
//			eventDispatcher.dispatchEvent(new Event(EventType.INFO_INIT));
			
			Tracer.debug("HttpReceivedPlayerInitCommand execute");
//			"name": "Jun Bao",
//			"exp": 0,
//			"rank": 0,
//			"chips": 50000,
//			"coin": 0,
//			"vip_level": 0,
//			"title": ""
			//请求背包
			HttpSendProxy.sendPackageRequest(userModel.myInfo.userId.toString());
			//请求转盘奖励列表，只要请求一次
			HttpSendProxy.sendLuckyWheelPrizeList();
			//获取远端配置
			HttpSendProxy.getRemoteConfig();
			//获取公告
			//不管是否断线登录都弹
			HttpSendProxy.sendNoteList();
			
			if(userModel.newer)
			{
//				WindowFactory.addPopUpWindow(WindowFactory.FIRST_TIP_WINDOW);
			}
			//更新大乐透总奖金
			if(result["jack_pot"])
			{
				gameModel.jack_pot=Number(result["jack_pot"]);
				//eventDispatcher.dispatchEvent(new Event(EventType.UPDATE_JACK_POT_BOUNS_POOL));
			}
		}
	}
}