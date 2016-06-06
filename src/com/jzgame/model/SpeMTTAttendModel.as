package com.jzgame.model
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.enmu.TableInfoUtil;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.vo.game.MTTAttendVO;
	import com.jzgame.vo.game.MTTGlobalRankVO;
	import com.jzgame.vo.room.MTTTableListInfo;
	import com.jzgame.vo.room.SpeMTTTableListInfo;
	import com.spellife.util.RealGameTimer;
	import com.spellife.util.TimerManager;
	
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class SpeMTTAttendModel
	{
		/*auther     :jim
		* file       :MTTAttendModel.as
		* date       :Mar 9, 2015
		* description:
		*/
		//已经报名参赛列表
		public var attendList:Dictionary = new Dictionary;
		
		//spe
		private var _SpeMTTMatchId:String;
		//旁观的人
		public var targetUid:uint;
		//是不是旁观
		public var obser:Boolean;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var eventDis:IEventDispatcher;
		//json
		public var mttRankList:Object;
		//multi_table玩法
		private var _speMttList:Array = [];
		private var _timer:RealGameTimer;
		//倒计时5分钟的时候弹窗进入
		private var _remindTime:Number = 300;
		//全局排行
		private var _globalRankList:Array = [];
		private var _rentThreeRankList:Array = [];
		//mtt 自己信息
		public var mttSelfInfo:Object;
		private var _settimeoutnum:Number = 0;
		public function SpeMTTAttendModel()
		{
		}

		public function get SpeMTTMatchId():String
		{
			return _SpeMTTMatchId;
		}

		public function set SpeMTTMatchId(value:String):void
		{
			_SpeMTTMatchId = value;
		}

		public function get rentThreeRankList():Array
		{
			return _rentThreeRankList.concat();
		}

		public function get globalRankList():Array
		{
			return _globalRankList.concat();
		}


		/**
		 * 同步更新状态
		 * @param obj
		 * 
		 */		
		public function updateInfo(obj:Object):void
		{
			var vo:MTTAttendVO;
			for(var index:String in obj)
			{
				if(attendList.hasOwnProperty(index))
				{
					vo = attendList[index];
					vo.status = obj[index]["status"];
				}else
				{
					vo = new MTTAttendVO;
					vo.matchID = index;
					vo.status  = obj[index]["status"];
					attendList[index] = vo;
				}
				checkCounting(index);
			}
		}
		/**
		 *延后提示 
		 * 
		 */		
		public function attendLater():void
		{
			var tableInfo:SpeMTTTableListInfo = getMTTTableInfoByID(_SpeMTTMatchId);
			
			var startTime:Number = Number(tableInfo.start_time);
			var left:Number = startTime - TimerManager.getCurrentSysTime();
			//			const STATUS_SIGN_UP = 1;  //可以报名
			//			const STATUS_READY = 2;  //准备参赛
			//			const STATUS_START = 3;  //旁观
			//			const STATUS_FINISHED = 4; //比赛结束或者可以查看结果
			//			const STATUS_CANCELED = 5;  //比赛取消
			//			const STATUS_EXPIRED = 6;   //比赛过期
			//如果存在剩余时间
			if(left<_remindTime && left > 59)
			{
				clearTimeout(_settimeoutnum);
				Tracer.info(_SpeMTTMatchId+",SpeMTTRemindCommand remind me later by:"+left+" seconds");
				_settimeoutnum = setTimeout(timerHandler,Math.floor((left % 60) * 1000));
			}
		}
		/**
		 * 取消提醒,如果进入了牌桌 
		 * 
		 */		
		public function cancelAttendLater():void
		{
			clearTimeout(_settimeoutnum);
		}
		
		/**
		 * 获取列表 
		 * @return 
		 * 
		 */		
		public function getList():Array
		{
			return _speMttList.concat();
		}
		/**
		 *  添加mtt列表信息,理论上只在断线重连使用
		 * @param vo
		 * 
		 */		
		public function addMTTInfo(vo:MTTTableListInfo):void
		{
			_speMttList.push(vo);
		}
		/**
		 * 初始化的时候更新状态
		 * @param object
		 * 
		 */		
		public function updateSpeMTTList(object:Object):void
		{
			_speMttList.splice(0,_speMttList.length);
			updateSpeMTTRoomListInfo(object,_speMttList);
			
			_speMttList.sortOn("start_time",Array.NUMERIC);
		}
		/**
		 * 根据match id 获取信息 
		 * @param match_id
		 * 
		 */		
		public function getMttInfoByMatchId(match_id:String):SpeMTTTableListInfo
		{
			for(var index:String in _speMttList)
			{
				if(_speMttList[index].match_id == match_id)
				{
					return _speMttList[index];
				}
			}
			
			return null;
		}
		/**
		 * 更新特殊房间列表
		 * @param value
		 * @param lib
		 * 
		 */		
		private function updateSpeMTTRoomListInfo(value:Object,lib:Array):void
		{
			var ringNew:Object = value;
			var tableListInfo:SpeMTTTableListInfo;
			var startTime:Number = 0;
			for(var index:String in ringNew)
			{
				//		"match_id": "19",
				//		"mtt_id": "3001",
				//		"desc": "$ 1 Billion + VIP 30days",
				//		"icon": "icon_huodong_1",
				//		"cost_score": 1000,
				//		"cost_chip": 50000000,
				//		"status": "1",
				//		"start_time": "1427798400",
				//		"end_time": "0",
				//		"players_left": "0",
				//		"initial_players": "0",
				//		"count": 0,
				//		"ip": "192.168.1.52:9088"
				tableListInfo = new SpeMTTTableListInfo;
				tableListInfo.id = Number(index);
				tableListInfo.match_id =ringNew[index]["match_id"];
				tableListInfo.rewards = ringNew[index]["desc"];
				tableListInfo.kick = TimerManager.getTimerFormat(ringNew[index]["start_time"]);
				tableListInfo.img = ringNew[index]["icon"];
				tableListInfo.costChip = ringNew[index]["cost_chip"];
				tableListInfo.costScore = ringNew[index]["cost_score"];
				tableListInfo.competitor = ringNew[index]["count"];
				tableListInfo.status = ringNew[index]["status"];
				tableListInfo.initial_players = ringNew[index]["initial_players"];
				tableListInfo.count = ringNew[index]["count"];
				tableListInfo.start_time = Number(ringNew[index]["start_time"]);
				tableListInfo.end_time = ringNew[index]["end_time"];
				tableListInfo.mtt_id = ringNew[index]["mtt_id"];
				tableListInfo.players_left = ringNew[index]["players_left"];
				if(ringNew[index]["result"])
				{
					tableListInfo.result = ringNew[index]["result"]["r"];
				}
				var ip:Array = ringNew[index]["ip"].split(AssetsCenter.COLON);
				tableListInfo.ip = ip[0];
				tableListInfo.port = ip[1];
				lib.push(tableListInfo);
				
				//如果当前房间有我的信息
				checkCounting(index);
			}
		}
		/**
		 * 更新全局排行列表 
		 * @param v
		 * 
		 */		
		public function updateGlobalRank(v:Object):void
		{
			var rent:Object = v.recent_mtt_rank;
			if(rent)
			{
				_globalRankList.splice(0,_globalRankList.length);
				var rank:MTTGlobalRankVO;
				for(var i:String in rent)
				{
					rank = new MTTGlobalRankVO;
					rank.championTimes = rent[i].championTimes;
					rank.fbId = rent[i].fbId;
					rank.joinTimes = rent[i].joinTimes;
					rank.name = rent[i].name;
					rank.runnerUpTimes = rent[i].runnerUpTimes;
					rank.secondRunnerUpTimes = rent[i].secondRunnerUpTimes;
					rank.totalPrize = rent[i].totalPrize;
					rank.uid = rent[i].uid;
					rank.index = Number(i);
					
					_globalRankList.push(rank);
				}
			}
			
			rent = v.recent_mtt_result;
			if(rent)
			{
				for(var mm:String in rent)
				{
					
					_rentThreeRankList.splice(0,_rentThreeRankList.length);
					if(rent[mm]["r"])
					{
						_rentThreeRankList.push(rent[mm]["r"][1]);
					}
				}
			}
			
			rent = v.self_mtt;
			if(rent)
			{
				mttSelfInfo  = v.self_mtt;
			}
		}
		/**
		 * 检测是否要倒数 
		 * @param index
		 * 
		 */		
		private function checkCounting(index:String):void
		{
			//如果当前房间有我的信息
			if(attendList.hasOwnProperty(index))
			{
				var tableListInfo:SpeMTTTableListInfo = getMTTTableInfoByID(index);
				//判断是否存在，避免异步出问题
				if(tableListInfo)
				{
					var startTime:Number = 0;
					var vo:MTTAttendVO=attendList[index];
					if(vo.status != tableListInfo.myStatus)
					{
						tableListInfo.myStatus = vo.status;
					}
					
					if(vo.status == 1)
					{
						startTime = Number(tableListInfo.start_time);
						var left:Number = startTime - TimerManager.getCurrentSysTime();
						Tracer.info(index + "实物赛剩余时间为:"+left + ":开赛时间:"+startTime+":服务器时间:"+TimerManager.getCurrentSysTime());
						//如果存在剩余时间
						if(left > 0 && vo.status < 4)
						{
							updateRemind(vo);
						}else
						{
							Tracer.info(index + "实物赛剩余时间为:"+left+":我的状态为:"+vo.status);
						}
					}else
					{
						Tracer.info(index +"实物赛:我的状态为:"+vo.status);
					}
				}
			}else
			{
				Tracer.info(index + "实物赛 当前房间我没报名:");
			}
		}
		
		private function updateRemind(vo:MTTAttendVO):void
		{
			var tableInfo:SpeMTTTableListInfo = getMTTTableInfoByID(vo.matchID);
			
			var startTime:Number = Number(tableInfo.start_time);
			var left:Number = startTime - TimerManager.getCurrentSysTime();
			//			const STATUS_SIGN_UP = 1;  //可以报名
			//			const STATUS_READY = 2;  //准备参赛
			//			const STATUS_START = 3;  //旁观
			//			const STATUS_FINISHED = 4; //比赛结束或者可以查看结果
			//			const STATUS_CANCELED = 5;  //比赛取消
			//			const STATUS_EXPIRED = 6;   //比赛过期
//			if(gameModel.inTable)
//			{
//				if(gameModel.tableBaseInfoVO.type != TableInfoUtil.MTT)
//				{
//					WindowFactory.addPopUpWindow(WindowFactory.MTT_IN_TABLE_REMIND_WINDOW,null,tableInfo.rewards,TimerManager.getTimerFormat(tableInfo.start_time,"hh:ii"),tableInfo.img,tableInfo);
//				}
//			}else
//			{
//				WindowFactory.addPopUpWindow(WindowFactory.MTT_REMIND_WINDOW,null,tableInfo.rewards,left,TimerManager.getTimerFormat(tableInfo.start_time,"hh:ii"),tableInfo);
//			}
//			return
			//如果存在剩余时间
			if(left<_remindTime)
			{
				if(tableInfo.status == 2)
				{
					if(gameModel.inTable)
					{
						if(gameModel.tableBaseInfoVO.type != TableInfoUtil.SPE_MTT)
						{
							WindowFactory.addPopUpWindow(WindowFactory.MTT_IN_TABLE_REMIND_WINDOW,null,tableInfo.rewards,TimerManager.getTimerFormat(tableInfo.start_time,"hh:ii"),tableInfo.img,tableInfo);
						}
					}else
					{
						WindowFactory.addPopUpWindow(WindowFactory.MTT_REMIND_WINDOW,null,tableInfo.rewards,left,TimerManager.getTimerFormat(tableInfo.start_time,"hh:ii"),tableInfo);
					}
					
					_SpeMTTMatchId = vo.matchID;
				}else
				{
					Tracer.info(vo.matchID+",SPEMTTRemindCommand less 5 but table status != 2 等20秒再刷一次");
					setTimeout(timerHandler,(20)* 1000);
				}
			}else
			{
				Tracer.info(vo.matchID+",SPEMTTRemindCommand 看看剩余时间:"+left+":"+(left -  _remindTime)* 1000);
				//超过一天就不提示。因为如果超过max int值,setTimeout就会不准。
				if((left - _remindTime) < 86400)
				{
					setTimeout(timerHandler,(left -  _remindTime)* 1000)
				}
			}
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function timerHandler():void
		{
			Tracer.info("SPEMTT发送请求同步状态");
			//时间到了同步下状态
			HttpSendProxy.sendSpeMttList();
		}
		
		/**
		 * 
		 * @param matchId
		 * @return 
		 * 
		 */		
		public function getMTTTableInfoByID(matchId:String):SpeMTTTableListInfo
		{
			for each(var vo:SpeMTTTableListInfo in _speMttList)
			{
				if(vo.match_id == matchId)
				{
					return vo;
				}
			}
			
			return null;
		}
	}
}