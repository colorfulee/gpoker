package com.jzgame.util
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.events.HandleDynamicSWFLoadCompleteEvent;
	import com.jzgame.vo.common.WaitingWindowVO;
	import com.spellife.display.PopUpWindow;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.interfaces.display.IPopUpWindow;
	
	import flash.utils.Dictionary;
	
	import feathers.controls.Alert;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	public class WindowFactory
	{
		/*auther     :jim
		* file       :WindowFactory.as
		* date       :Jan 4, 2015
		* description:
		*/
		//普通购买筹码界面
		public static var GAME_PAY_INIT_WINDOW:String = "20001";
		public static var TABLE_GUIDE_WINDOW:String = "20002";
		//帮助界面
		public static var HELP_WINDOW:String = "20005";
		public static var LOADING_WINDOW:String = "20008";
		public static var FLEX_TIP_WINDOW:String = "20009";
		public static var MESSAGE_WINDOW:String = "20010";
		public static var MISSION_COMPLETE_WINDOW:String = "20011";
		public static var STORE_WINDOW:String = "20013";
		//提示界面
		public static var ALERT:String = "20014";
		//玩家信息界面
		public static var PLAYER_INFO_WINDOW:String = "20015";
		public static var MISSION_WINDOW:String = "20016";
		//加载资源等待界面
//		public static var ASSETS_LOADING_WINDOW:String = "20017";
		//赠送礼物
		public static var SEND_GIFT_WINDOW:String = "20018";
		//all in 购买筹码界面
		public static var GAME_ALL_IN_PAY_WINDOW:String = "20019";
		//倒数10s
		public static var ALL_IN_MODE_COUNTING_WINDOW:String = "20020";
		//排行榜
		public static var RANK_WINDOW:String = "20021";
		//日常任务
		public static var DAILY_BONUS_WINDOW:String = "20022";
		//日常登录奖励领取界面
		public static var DAILY_LOGIN_REWARD_WINDOW:String = "20023";
		//预览数据界面
		public static var PREVIEW_WINDOW:String = "20024";
		//更换皮肤界面
		public static var TABLE_SKIN_WINDOW:String = "20025";
		//游戏设置界面
		public static var GAME_SET_WINDOW:String = "20026";
		//选择荷官界面
		public static var ROSE_CHANGE_WINDOW:String = "20027";
		//特殊玩法提示窗口
		public static var SIT_AND_GO_JOIN_WINDOW:String = "20028";
		public static var SIT_AND_GO_WAITING_WINDOW:String = "20029";
		//mtt 报名界面
		public static var MTT_SIGN_UP_WINDOW:String = "20030";
		//mtt rule
		public static var MTT_RULE_WINDOW:String = "20031";
		//mtt 提醒入口
		public static var MTT_REMIND_WINDOW:String = "20032";
		//mtt 拼桌等待界面
		public static var MTT_WAITING_WINDOW:String = "20033";
		//mtt 排名界面
		public static var MTT_RESULT_RANK_LIST_WINDOW:String = "20034";
		//mtt 查看排名
		public static var MTT_OUT_RESULT_WINDOW:String = "20036";
		//mtt 淘汰界面
		public static var MTT_GAME_COUNT_WINDOW:String = "20035";
		//MTT 积分界面
		public static var MTT_MY_SCORE_WINDOW:String = "20037";
		//消息喇叭
		public static var MESSAGE_ALERT_WINDOW:String = "20038";
		//截屏
		public static var SCREEN_SHOT:String = "20039";
		public static var SLOT_ALERT:String = "20040";
		//通訊等待界面
		public static var COMMUNICATE_WINDOW:String = "20041";
		//筹码不足提示界面
		public static var LESS_CHIP_WINDOW:String = "20042";
		
		//加载资源加载资源等待界面
		public static var LOAD_RESOURCE:String = "20043";
		public static var MTT_IN_TABLE_REMIND_WINDOW:String = "20044";
		public static var INVITE_FRIEND_TABLE:String = "20045";
		//mtt開賽等待界面
		public static var MTT_WAIT_START_WINDOW:String = "20046";
		//MTT 排名
		public static var MTT_RANK_WINDOW:String = "20047";
		//sng 规则
		public static var SNG_RULE_WINDOW:String = "20048";
		//奖励界面
		public static var REWARD_TIP_WINDOW:String = "20049";
		//通用fade out tip
		public static var FADE_TIP_WINDOW:String = "20050";
		//sng結算彈窗
		public static var SNG_GAME_COUNT_WINDOW:String = "20051";
		//公告窗口
		public static var NOTE_WINDOW:String = "20052";
		//首次登录
//		public static var FIRST_TIP_WINDOW:String = "20053";
		//胜利弹窗
		public static var WIN_RESULT_WINDOW:String = "20054";
		//七日登录
		public static var SEVEN_LOGIN_BONUS_WINDOW:String = "20055";
		//七日登录奖励
		public static var SEVEN_LOGIN_REWARD_WINDOW:String = "20056";
		//保险箱
		public static var SAFE_BOX_WINDOW:String = "20057";
		public static var SAFE_BOX_PASS_WINDOW:String = "20058";
		public static var SAFE_BOX_ALERT_WINDOW:String = "20059";
		public static var SAFE_BOX_LOGIN_WINDOW:String = "20060";
		
		//定点玩牌
		public static var TIME_LIMIT_PLAY_WINDOW:String = "20061";
		
		public static var TIME_LIMIT_SHOW_REWARD_WINDOW:String = "20062";
		//大乐透
		
		public static var JACKPOT_LOTTERY_WINDOW:String = "20063";
		public static var JACK_POT_WINDOW:String = "20064";
		//欢呼界面
		public static var RUMBLE_WINDOW:String = "20065";
		//筹码不够并且银行有存款
		public static var LESS_CHIP_WITH_BANK_WINDOW:String = "20066";
		//个人信息
		public static var EDIT_INFO_WINDOW:String = "20067";
		//神秘好礼
		public static var MISTERY_WINDOW:String = "20068";
		//神秘好礼排行榜
		public static var MISTERY_RANK_WINDOW:String = "20069";
		//获得礼券
		public static var MESSAGE_GET_COUPON_WINDOW:String = "20070";
		///节日好礼
		public static var FESTERVAL_WINDOW:String = "20071";
		//拼图
		public static var RAIDER_WINDOW:String = "20072";
		//赏金
		public static var HUNTER_WINDOW:String = "20073";
		//赏金帮助界面
		public static var HUNTER_HELP_WINDOW:String = "20074";
		//获得碎片
		public static var PUZZLE_ITEM_WINDOW:String = "20075";
		//特殊MTT玩法提示窗口
		public static var SPE_MTT_JOIN_WINDOW:String = "20076";
		//SPEMTT 排名
		public static var SPE_MTT_RANK_WINDOW:String = "20077";
		
		//spe mtt 排名界面
		public static var SPE_MTT_RESULT_RANK_LIST_WINDOW:String = "20078";
		//商店购买界面
		public static var STORE_BUY_WINDOW:String = "30001";
		//成就界面
		public static var ACHIEVE_WINDOW:String = "30002";
		//好友界面
		public static var FRIENDS_WINDOW:String = "30003";
		//背包
		public static var PACK_WINDOW:String = "30004";
		//物品详情
		public static var PACK_DETAIL_WINDOW:String = "30005";
		//ring game room
		public static var RING_ROOM_WINDOW:String = "30006";
		//rounds
		public static var ROUND_WINDOW:String = "30007";
		//other info
		public static var OTHER_USER_INFO_WINDOW:String = "30008";
		//我的信息
		public static var MY_INFO_WINDOW:String = "30009";
		//achievement detail
		public static var ACHIE_DETAIL_WINDOW:String = "30010";
		//聊天详细页面
		public static var CHAT_DETAIL_WINDOW:String = "30011";
		
		public static var OPERATE:String = "_";
		
		public static var CHECK_WINDOWS:Array = [STORE_WINDOW,PLAYER_INFO_WINDOW,MESSAGE_WINDOW,MISSION_WINDOW
		,PREVIEW_WINDOW,SCREEN_SHOT,GAME_SET_WINDOW,RANK_WINDOW,DAILY_BONUS_WINDOW,HELP_WINDOW];
		private static var window:Dictionary = new Dictionary;
		private static var dic:Dictionary = new Dictionary;
		private static var WAITING:Array = [];
		public function WindowFactory()
		{
		}
		/**
		 * 关闭所有弹窗 
		 * 
		 */		
		public static function removeAll():void
		{
//			PopUpManager.
		}
		/**
		 * 显示提示弹窗 
		 * @param rests
		 * 
		 */		
		public static function showAlert(...rests):void
		{
			var data:Array = [ALERT,null].concat(rests);
//			WindowFactory.addPopUpWindow.apply(WindowFactory,data);
			Alert.show(rests[0],"alert");
		}
		
		/**
		 * 创建窗体
		 * @param name
		 * @return 
		 * 
		 */		
		private static function createWindow(name:String):IPopUpWindow
		{
			var window:IPopUpWindow = new dic[name] as IPopUpWindow;
			
			var path:String;
			var itemName:String;
			
			return window;
		}
		/**
		 * 打开序列窗体 
		 * @param name 窗体名字
		 * @param parent 父级
		 * @param rests 参数[]
		 * 
		 */			
		public static function addAutoPopUpWindow(name:String,parent:DisplayObjectContainer = null,...rests):void
		{
//			Tracer.info("addAutoPopUpWindow:"+name);
//			var windowIns:DisplayObject = PopUpManager.getWindow(name) as PopUpWindow;
//			if(!windowIns)
//			{
//				windowIns = createWindow(name) as DisplayObject;
//			}
//			if(!parent)
//			{
//				parent = WindowModel.popUpContainer;
//			}
//			var data:Array = [windowIns,parent].concat(rests);
//			PopUpWindowManager.addAutoPopUpWindow(data);
		}
		/**
		 * 打开窗体 
		 * @param name 窗体名字
		 * @param parent 父级
		 * @param rests 参数[]
		 * 
		 */			
		public static function addPopUpWindow(name:String,parent:DisplayObjectContainer = null,...rests):IPopUpWindow
		{
			Tracer.info("addPopUpWindow:"+name);
			var windowIns:IPopUpWindow = PopUpWindowManager.getWindow(name) as IPopUpWindow;
			if(!windowIns)
			{
				windowIns = createWindow(name) as IPopUpWindow;
			}
			
//			if(!parent)
//			{
//				parent = WindowModel.popUpContainer;
//			}
			
			var data:Array = [windowIns,parent].concat(rests);
			PopUpWindowManager.addPopUpWindow.apply(PopUpWindowManager,data);
			return windowIns;
		}
		/**
		 * 加载素材完毕 
		 * @param e
		 * 
		 */		
		private static function afterLoadResourceHandler(e:HandleDynamicSWFLoadCompleteEvent):void
		{
			WindowFactory.removeMemWindow(WindowFactory.LOAD_RESOURCE);
			AssetsCenter.eventDispatcher.removeEventListener(HandleDynamicSWFLoadCompleteEvent.COMPLETE,afterLoadResourceHandler);
			var vo:WaitingWindowVO = WAITING.shift();
			var data:Array = [vo.windowName].concat(vo.data);
			WindowFactory.addPopUpWindow.apply(WindowFactory,data)
		}
		/**
		 * 打开窗体并缓存 
		 * @param name
		 * @return 
		 * 
		 */		
		public static function addMemWindow(name:String):DisplayObject
		{
			trace("add mem window:",name);
			if(!window[name])
			{
				window[name] = createWindow(name);
			}
			var windowIns:PopUpWindow = window[name];
			PopUpWindowManager.addPopUpWindow(windowIns);
			return windowIns;
		}
		/**
		 * 移除窗体 
		 * @param name
		 * 
		 */		
		public static function removeMemWindow(name:String):void
		{
			trace("remove mem window:",name);
			var windowIns:PopUpWindow = window[name];
			if(windowIns)
			{
				PopUpWindowManager.removePopUpWindow(windowIns);
			}
		}
		/**
		 * 显示资源请求界面 
		 * 
		 */		
		public static function showResourceWindow():void
		{
			addMemWindow(WindowFactory.LOAD_RESOURCE);
		}
		/**
		 * 隐藏资源请求界面 
		 * 
		 */		
		public static function hideResourceWindow():void
		{
			removeMemWindow(WindowFactory.LOAD_RESOURCE);
		}
		/**
		 * 显示请求界面 
		 * 
		 */		
		public static function showCommuWindow():void
		{
			addMemWindow(WindowFactory.COMMUNICATE_WINDOW);
		}
		/**
		 * 隐藏请求界面 
		 * 
		 */		
		public static function hideCommuWindow():void
		{
			removeMemWindow(WindowFactory.COMMUNICATE_WINDOW);
		}
		/**
		 * 注册窗体类
		 * @param windowName
		 * @param windowc
		 * 
		 */		
		public static function register(windowName:String, windowc:Class) : void
		{
			dic[windowName] = windowc;
		}
	}
}