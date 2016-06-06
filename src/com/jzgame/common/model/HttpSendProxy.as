package com.jzgame.common.model
{
	import com.adobe.crypto.MD5;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.http.AES;
	import com.jzgame.common.services.http.HttpRequest;
	import com.jzgame.common.services.http.HttpResponse;
	import com.jzgame.common.services.http.events.HttpRequestEvent;
	import com.jzgame.common.services.protobuff.ReadyRequest;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.events.communication.NetSendEvent;
	import com.jzgame.util.WindowFactory;
	import com.spellife.util.FastBase64;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;

	public class HttpSendProxy
	{
		/*auther     :jim
		* file       :HttpSendProxy.as
		* date       :Jan 16, 2015
		* description:http 通讯代理
		*/
		public function HttpSendProxy()
		{
		}
		
		public static function timestamp(type:String,i1:String=""):void
		{
//			if(ExternalVars.enable_flash_log == "1")
			{
				var SESSION_ID:String = ExternalVars.log_track_session_id;
				ExternalVars.log_track_seq_id++;
				var id:String = Math.floor(ExternalVars.userID/1000).toString();
				
				if(id.length < 7)
				{
					id = ("0000000" + id).substr(id.length,7);
				}
				
				var SEQ_ID:String  =  ExternalVars.log_track_seq_id + id;
					
				var DATA:Object = new Object;
				DATA.s = SESSION_ID;
				DATA.u = ExternalVars.userID;
				DATA.e = type;
				if(i1 != "")
				{
					DATA.i1 = i1;
				}
				var JSON_DATA:String = JSON.stringify(DATA);
				var KEY:String = "474f1b5149ba6e2c474f1";
				var SIG:String = MD5.hash(SEQ_ID + JSON_DATA + KEY);
				var gateway:String = ExternalVars.log_track_url+"?seq="+SEQ_ID+"&p="+JSON_DATA+"&sig="+SIG+"";
				Tracer.info("gateway:"+gateway);
				var loader:URLLoader = new URLLoader();
				var urlReq:URLRequest = new URLRequest();
				urlReq.method = URLRequestMethod.POST;
				urlReq.url = gateway;
				loader.load(urlReq);
				
			}
//			xxx.com/log/?seq={SEQ_ID}&p={JSON_DATA}&sig={SIG}
//				
//				
//				SESSION_ID = ((timestamp - 1262275200) * 100 + 0     ) * 10000000 + floor({UID}/10000)
//			SEQ_ID     = ((timestamp - 1262275200) * 100 + REQ_ID) * 10000000 + floor({UID}/10000)
//			
//			REQ_ID 每次刷新后从1开始累加，每次加一
//			
//			SIG = md5(SEQ_ID + JSON_DATA + KEY)
//			
//			KEY=474f1b5149ba6e2c474f1
		}
		/**
		 * 获取特殊活动报名
		 */		
		public static function sendSpeMttSign(match_id:String, cost_type:String="normal"):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SPE_MTT_SIGN;
			requestVo.data = [match_id,cost_type];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取特殊活动列表
		 */		
		public static function sendSpeMttList():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SPE_MTT_LIST;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取mtt排名
		 */		
		public static function sendSpeMTTRank():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SPE_MTT_GLOBAL_RANK;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取活动奖励
		 * activity_id 活动唯一id 
		 */		
		public static function sendActivityPuzzlePrize(aid:String,type:Number):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.EXCHANGE_PUZZLE_PRIZE;
			requestVo.data = [aid,type];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取活动奖励
		 * activity_id 活动唯一id 
		 */		
		public static function sendActivityExchangeHunterTask(aid:String,type:Number):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.EXCHANGE_BOUNTY_HUNTER;
			requestVo.data = [aid,type];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取活动奖励
		 * activity_id 活动唯一id 
		 */		
		public static function sendActivityRefreshHunterTask(aid:String):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.REFRESH_BOUNTY_HUNTER;
			requestVo.data = [aid];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取活动奖励
		 * activity_id 活动唯一id 
		 */		
		public static function sendActivityTakeHunterTask(aid:String,tid:String):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.TAKE_BOUNTY_HUNTER;
			requestVo.data = [aid,tid];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取活动奖励
		 * activity_id 活动唯一id 
		 */		
		public static function sendActivityFinishHunterTask(aid:String,tid:String):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.FINISH_BOUNTY_HUNTER;
			requestVo.data = [aid,tid];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取活动奖励
		 * activity_id 活动唯一id 
		 */		
		public static function sendActivityGetTaskBonus(aid:String,tid:String):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ACTIVITY_GET_FESTERVAL_TASK;
			requestVo.data = [aid,tid];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取活动列表
		 * activity_id 活动唯一id pos 位置 分别是1-12 
		 */		
		public static function sendActivityRefreshTaskList(aid:String):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ACTIVITY_RFRESH_FESTERVAL_TASK;
			requestVo.data = [aid];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取活动列表
		 * activity_id 活动唯一id pos 位置 分别是1-12 
		 */		
		public static function sendActivityGetLucky(aid:String,pos:String):void
		{
			WindowFactory.showCommuWindow();
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ACTIVITY_LUCKY_DRAW;
			requestVo.data = [aid,pos];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 刷新
		 * 
		 */		
		public static function sendActivityRefreshLucky(aid:String):void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ACTIVITY_RFRESH_LUCKY_DRAW;
			requestVo.data = [aid];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 设置活动列表
		 * 
		 */		
		public static function sendActivityRank(aid:String,start:Number,end:Number):void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ACTIVITY_RANK;
			requestVo.data = [aid,start,end];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 设置活动列表
		 * 
		 */		
		public static function sendActivityList():void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ACTIVITY_LIST_INFO;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 兑换 
		 * @param activity_id
		 * @param amount
		 * 
		 */
		public static function sendExchange(activity_id:String,amount:Number):void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ACTIVITY_EXCHANGE;
			requestVo.data = [activity_id,amount];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 设置个人信息
		 * 
		 */		
		public static function setUserInfo(nickname:String,phone:String,email:String):void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SET_USER_INFO;
			requestVo.data = [nickname,phone,email];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 完成成就
		 * 
		 */		
		public static function achieveFinish(aid:String):void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ACHIEVEMENT_FINISH;
			requestVo.data = [aid];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 购买门票 
		 * 
		 */		
		public static function buyLuckyTicket():void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.LUCKY_WHEEL_BUY;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *记录加载素材时间
		 * second
		 */
		public static function sendStartTime(time:Number):void
		{
//			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.START_LOAD_TIME;
			requestVo.data = [time];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *更改新手状态
		 * 
		 */
		public static function sendChangeState():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.CHANGE_LOGIN_STATUS;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *七日登录状态
		 * 
		 */
		public static function sendSevenInfo():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SEVEN_LOGIN_INFO;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *七日获取奖励
		 * 
		 */
		public static function sendSevenReward():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SEVEN_GET_REWARD;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *note列表
		 * 
		 */
		public static function sendNoteList():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.NOTE;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *mtt全局列表
		 * 
		 */
		public static function sendMTTGList():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_MTT_G_LIST;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *领取任务奖励
		 * 
		 */
		public static function sendTaskReward(taskId:String):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.TASK_BONUS;
			requestVo.data = [taskId];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *获取好友在线列表
		 * 
		 */
		public static function sendONlineList():void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.PLAYER_GET_ONLINE;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 *获取mtt列表
		 * 
		 */
		public static function sendMTTList():void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_MTT_LIST;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * 使用道具
		 * @param id
		 * @param type ||normal ,achievement 
		 * 
		 */			
		public static function sendUseItem(id:String,type:String = "normal"):void
		{
			WindowFactory.showCommuWindow();
			
			var data:Array = [id,type];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_PACKAGE_USE;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *获取任务列表
		 * 
		 */		
		public static function sendGetTaskList():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.TASK_GET;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *获取邮件列表
		 * 
		 */		
		public static function sendGetMessageList():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_GET;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		
		/**
		 *单一处理邮件
		 * 
		 */		
		public static function sendProcessSingleMessage(ids:String):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_PROCESS;
			requestVo.data = [ids];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *批量处理邮件
		 * 
		 */		
		public static function sendProcessMessage(ids:Array):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_PROGCESS_MESSAGE;
			requestVo.data = [ids];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *删除邮件
		 * 
		 */		
		public static function sendDelMessage(ids:Array):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_DELETE_MESSAGE;
			requestVo.data = [ids];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *保存玩家牌局信息
		 * 
		 */		
		public static function sendPlayRecord(json:String):void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_SET_PLAY_RECORD;
			requestVo.data = [json];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *查询玩家牌局信息
		 * 
		 */		
		public static function getPlayRecord():void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_GET_PLAY_RECORD;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *查询单个房间信息
		 * 
		 */		
		public static function sendTableInfo(tableId:uint):void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_GET_TABLE_INFO;
			requestVo.data = [tableId];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 发送心跳 
		 * 
		 */		
		public static function sendHeart():void
		{
			trace("发送心跳了啊?");
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.HEART;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 查询背包 
		 * @param uid
		 * 
		 */		
		public static function sendPackageRequest(uid:String):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_PACKAGE;
			requestVo.data = [uid];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * 请求成就领奖 
		 * 
		 */		
		public static function sendAchieBonusRequest(auid:String):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ACHIEVEMENT_BONUS_GET;
			requestVo.data = [auid];
			//			requestVo.responseEvent = MessageType.ACHIEVEMENT_GET_RETURN;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 请求成就状态 
		 * 
		 */		
		public static function sendAchieRequest(uid:String):void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ACHIEVEMENT_GET;
			requestVo.data = [uid];
			//			requestVo.responseEvent = MessageType.ACHIEVEMENT_GET_RETURN;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 *手游玩家信息初始化 
		 * 
		 */		
		public static function sendPlayerLogin():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.PLAYER_LOGIN;
			requestVo.data = [ExternalVars.token];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 *玩家信息初始化 
		 * 
		 */		
		public static function sendPlayerInit():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.PLAYER_INIT;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 添加好友
		 * 
		 */		
		public static function addFriend(uid:uint):void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.ADD_FRIEND;
			requestVo.data = [uid.toString()];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 删除好友
		 * 
		 */		
		public static function deleteFriend(uid:uint):void
		{
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.DELETE_FRIEND;
			requestVo.data = [uid.toString()];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取玩家个人信息
		 * uid 玩家id
		 */		
		public static function getPlayerSummary(uid:String):void
		{
			WindowFactory.showCommuWindow();
			
			var data:Array = [uid];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.PLAYER_SUMMARY;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * 发送ready消息 
		 * 
		 */		
		public static function iamready(uid:uint,tableId:int):void
		{
			var ready:ReadyRequest = new ReadyRequest;
			ready.uid = uid;
			ready.ready = 1;
			ready.tableid = tableId;
			Tracer.info("i am ready :",ready.tableid);
			var bytest:ByteArray = new ByteArray;
			ready.writeTo(bytest);
			AssetsCenter.eventDispatcher.dispatchEvent(new NetSendEvent(MessageType.SEND_READY,bytest))
		}
		/**
		 * 获取玩家的排行信息 
		 * @param uid
		 * 
		 */		
		public static function getRank(uid:String):void
		{
			var data:Array = [uid];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.PLAYER_RANK;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取玩家的日常任务信息 
		 * @param uid
		 * 
		 */		
		public static function getDailyInfo():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_DAILY_INFO;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取玩家的日常筹码
		 * @param uid
		 * 
		 */		
		public static function getDailyChip():void
		{
			WindowFactory.showCommuWindow();
			
			var data:Array = [];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_DAILY_GET_CHIP;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 补足未登录天数补签
		 * @param uid
		 * 
		 */		
		public static function fillDays():void
		{
			WindowFactory.showCommuWindow();
			var data:Array = [];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_DAILY_FILL_LOGIN;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 连续登陆获取筹码
		 * @param uid
		 * 
		 */		
		public static function getDaysBonus(days:Number):void
		{
			WindowFactory.showCommuWindow();
			
			var data:Array = [days];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_DAILY_GET_LOGIN_BONUS;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取远端配置
		 * 
		 */		
		public static function getRemoteConfig():void
		{
			var data:Array = [];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.PLAYER_GET_CONFIG;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 保存远端配置 
		 * @param config
		 * 
		 */		
		public static function sendRemoteConfig(config:Object):void
		{
			var data:Array = [config];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.PLAYER_SEND_CONFIG;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * 领取每日奖励
		 * 
		 */		
		public static function getTaskBonus(taskId:String):void
		{
			WindowFactory.showCommuWindow();
			
			var data:Array = [taskId];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.GET_TASK_BONUS;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 获取房间列表
		 * 
		 */		
		public static function getRoomList():void
		{
			WindowFactory.showCommuWindow();
			
			var data:Array = [];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_GET_ROOM_LIST;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * 赠送物品发送请求 
		 * 
		 */
		public static function sendGiftRequest(friends:Array,itemId:String,num:uint = 1, useType:uint = 1,inGame:uint = 0):void
		{
			var data:Array = [friends,itemId,1,useType,inGame];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_SHOP_SEND;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 购买物品发送请求 
		 * cost_type chip->1 coin->2 
		 */		
		public static function sendBuyRequest(id:String,num:uint = 1, useType:uint = 1):void
		{
			WindowFactory.showCommuWindow();
			
			var data:Array = [id,num,useType];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_SHOP_BUY;
			requestVo.data = data;
			//			requestVo.responseEvent = MessageType.MESSAGE_SHOP_BUY_RETURN;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 购买物品发送请求 
		 * type 1 背景  2 荷官
		 */
		public static function sendRoseRequest(id:String,type:uint = 1,num:uint = 1, useType:uint = 1):void
		{
			var data:Array = [type,id,num,useType];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.USE_ROSE_OR_TABLEBACK;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * MTT报名请求
		 * match_id 场次的唯一ID 
		 * cost_type 1->score 2->chip 
		 */		
		public static function sendMTTSignUpRequest(match_id:String, cost_type:String):void
		{
			var data:Array = [match_id,cost_type];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_MTT_SIGN_UP;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * SPEMTT请求排名
		 * match_id 场次的唯一ID 
		 */		
		public static function sendSPEMTTRankRequest(match_id:String):void
		{
			if(match_id=="")
			{
				Tracer.error("sendMTTRankRequest null:");
				
				return;
			}
			var data:Array = [match_id];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_SPE_MTT_MATCH_RANK;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * MTT请求排名
		 * match_id 场次的唯一ID 
		 */		
		public static function sendMTTRankRequest(match_id:String):void
		{
			if(match_id=="")
			{
				Tracer.error("sendMTTRankRequest null:");
				
				return;
			}
			var data:Array = [match_id];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_MTT_MATCH_RANK;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 新手引导领取奖励
		 * 
		 */		
		public static function sendGuidePrizeRequest():void
		{
			var data:Array = [];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.MESSAGE_GUIDE_PRIZE;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 设置保险箱密码
		 * 密码
		 */		
		public static function sendSafeBoxSetPasswardRequest(pwd:String ):void
		{
			var data:Array = [pwd];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SAFE_BOX_SET_PASSWARD;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 登录保险箱
		 * 密码
		 */		
		public static function sendSafeBoxLoginInRequest(pwd:String ):void
		{
			var data:Array = [pwd];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SAFE_BOX_LOGIN;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 保险箱存钱
		 * 密码
		 * 金额
		 */
		public static function sendSafeBoxSaveRequest(pwd:String ,amount:Number):void
		{
			var data:Array = [pwd,amount];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SAFE_BOX_SAVE;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * 保险箱改密码
		 * 密码
		 */
		public static function sendSafeBoxResetPsdRequest(pwd:String ,newPwd:String):void
		{
			var data:Array = [pwd,newPwd];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SAFE_BOX_RESET_PWD;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 保险箱存钱
		 * 密码
		 * 金额
		 */
		public static function sendSafeBoxGetBackRequest(pwd:String ,amount:Number):void
		{
			var data:Array = [pwd,amount];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.SAFE_BOX_GET_BACK;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 *请求转盘数据 
		 * 
		 */		
		public static function sendLuckyWheelPrizeList():void
		{
			//			//请求转盘数据
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.LUCKY_WHEEL_CHECK_REWARD;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		private static const AES_KEY:String = "hellohellohelloo";
		public static function decode(str:String):HttpResponse
		{
			encryptKey = getKey();
			var by:ByteArray = FastBase64.decodeToByteArray(str);
			var resultData:* = decryptData(by)
			//		trace("-----HttpServic:收到数据返回,"+resultData+"-----");
			var responseData:HttpResponse = new HttpResponse(resultData);
			return responseData;
		}
		
		private static function getKey():ByteArray
		{
			//		var key : ByteArray = Hex.toArray(AES_KEY);
			var key:ByteArray = new ByteArray();
			key.writeMultiByte(AES_KEY,"ascii");
			return key;
		}
		
		
		/**
		 * 定点玩牌获取详细信息  
		 */		
		public static function limitGameGetInfo():void
		{
			WindowFactory.showCommuWindow();
			
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.LIMIT_GAME_GET_INFO;
			requestVo.data = [];
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * 定点玩牌获取奖励
		 * 
		 */		
		public static function limitGameBonus(rid:int):void
		{
			WindowFactory.showCommuWindow();
			
			var data:Array = [rid];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.LIMIT_GAME_BONUS;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		/**
		 * 
		 * 获取大乐透记录
		 * 
		 */		
		public static function getJackPotRecord():void
		{
			WindowFactory.showCommuWindow();
			
			var data:Array = [];
			var requestVo:HttpRequest = new HttpRequest();
			requestVo.name = MessageType.JACK_POT_RECORD;
			requestVo.data = data;
			var event:HttpRequestEvent = new HttpRequestEvent(requestVo);
			AssetsCenter.eventDispatcher.dispatchEvent(event);
		}
		
		
		static private var encryptKey:ByteArray; 
		/**
		 * 解密 
		 * @return json类型对象
		 */	
		private static function decryptData(by:ByteArray):*
		{
			by.position = 0;
			var magicWord:String = by.readUnsignedInt().toString(16);  // magic word
			
			var paddingLength:uint = by.readByte(); //PaddingLength
			
			var temp1:uint = by.readByte();
			var temp2:uint = by.readShort();
			var dataLength:uint =  temp1 << 16 | temp2;  //Data Length
			
			var dataBy:ByteArray = new ByteArray();
			dataBy.writeBytes(by, by.position, dataLength+paddingLength);
			by.position += dataLength+paddingLength;
			
			var iv:ByteArray = new ByteArray();
			iv.writeBytes(by, by.position, 16);
			
			//			var iv : ByteArray = Hex.toArray(AEK_IV);
			//			var key:ByteArray = AES.generateKey(AES_KEY);//AES.DEFAULT_CIPHER_NAME
			var aes : AES = new AES(encryptKey, iv, AES.DEFAULT_CIPHER_NAME, "null");
			dataBy.position = 0;
			var result:String;
			
			{
				result = parseResultData(aes.decrypt(dataBy), paddingLength);
			}
			
			iv.clear();
			dataBy.clear();
			by.clear();
			var obj:*;
			try
			{
				obj = JSON.parse(result);
			}
			catch (e:Error)
			{
				Tracer.error("------HttpService JSON解析出错!!!------");
				//				dispatcher.dispatchEvent(new HttpResponseEvent(HttpResponseEvent.HTTP_RESPONSE_PARSE_ERROR, null, null));
			}
			return obj;
		}
		
		private static function parseResultData(by:ByteArray, paddingLength:uint):String
		{
			by.position = 0;
			by.length -= paddingLength;
			var dataLen:Number = by.length - 7; //CRC32+zip+flag 总计7字节
			var dataBy:ByteArray = new ByteArray();
			dataBy.writeBytes(by, 0, dataLen);
			dataBy.position = 0;
			by.position = dataLen;
			var crcValue:uint = by.readUnsignedInt();
			if (by.readByte() == 1)
			{
				dataBy.uncompress();
			}
			//		var resultStr:String = dataBy.readUTF();
			var resultStr:String = dataBy.readUTFBytes(dataBy.length);
			var okFlag:String = by.readMultiByte(2,"ACSII");
			dataBy.clear();
			return resultStr;
		}
	}
}