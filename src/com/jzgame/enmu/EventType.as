package com.jzgame.enmu
{
	public class EventType
	{
		public static var ASSETS_START:String = "ASSETS_START";
		public static var PRELOAD_ASSETS_END:String = "PRELOAD_ASSETS_END";
		public static var GAME_START:String = "GAME_START";
//		public static var SHOW_TABLE:String = "SHOW_TABLE";
//		public static var SHOW_ROOM:String = "SHOW_ROOM";
		public static var PLAY_GAME:String = "PLAY_GAME";
		public static var HEART_TO_SERVER:String = "HEART_TO_SERVER";
		public static var STOP_GAME:String = "STOP_GAME";
//		public static var SHOW_TABLE_IN_SCENE:String = "SHOW_TABLE_IN_SCENE";
//		public static var SHOW_ROOM_IN_SCENE:String = "SHOW_ROOM_IN_SCENE";
		public static var INIT_SCENE:String = "INIT_SCENE";
		public static var SHOW_LEFT_TABLE:String = "SHOW_LEFT_TABLE";
		public static var CHANGE_TABLE_COLOR:String = "CHANGE_TABLE_COLOR";
		
		public static var GUIDE_I_AM_IN_SEAT:String = "GUIDE_I_AM_IN_SEAT";
		public static var GUIDE_SECOND_ROUND_START_TO_MAIN:String = "GUIDE_SECOND_ROUND_START_TO_MAIN";
		public static var GUIDE_SMALL_BLINDS_BET:String = "GUIDE_SMALL_BLINDS_BET";
		public static var GUIDE_BET:String = "GUIDE_BET";
		public static var GUIDE_BIG_BLINDS_BET:String = "GUIDE_BIG_BLINDS_BET";
		public static var GUIDE_FIRST_ROUND_LAST:String = "GUIDE_FIRST_ROUND_LAST";
		public static var GUIDE_SECOND_ROUND_END:String = "GUIDE_SECOND_ROUND_END";
		public static var GUIDE_THIRD_ROUND_END:String = "GUIDE_THIRD_ROUND_END";
		public static var GUIDE_FOUR_ROUND_END:String = "GUIDE_FOUR_ROUND_END";
		public static var GUIDE_SHOW_RESULT:String = "GUIDE_SHOW_RESULT";
		public static var GUIDE_NEXT_TURN:String = "GUIDE_NEXT_TURN";
		public static var GUIDE_MY_TURN_TO_MAIN:String = "GUIDE_MY_TURN_TO_MAIN";
		public static var GUIDE_ACTION_FOLD:String = "GUIDE_ACTION_FOLD";
		public static var GUIDE_MY_CALL:String = "GUIDE_MY_CALL";
		public static var GUIDE_COVER3_END:String = "GUIDE_COVER3_END";
		public static var GUIDE_NEXT_STEP:String = "GUIDE_NEXT_STEP";
		public static var I_AM_IN_SEAT:String = "I_AM_IN_SEAT";
		public static var PLAYER_IN_SEAT:String = "PLAYER_IN_SEAT";
		public static var SHOW_MESSAGE_RED_ICON:String = "SHOW_MESSAGE_RED_ICON";
		public static var HIDE_MESSAGE_RED_ICON:String = "HIDE_MESSAGE_RED_ICON";
		
		public static var SHOW_TASK_RED_ICON:String = "SHOW_TASK_RED_ICON";
		public static var HIDE_TASK_RED_ICON:String = "HIDE_TASK_RED_ICON";
		
		//更新大乐透总奖金
		public static var UPDATE_JACK_POT_BOUNS_POOL:String = "UPDATE_JACK_POT_BOUNS_POOL";
		//获得礼券
		public static var GET_COUPON:String = "GET_COUPON";
		//获得拼图碎片
		public static var GET_PUZZLE:String = "GET_PUZZLE";
		
		
		public static var DEBUG_INFO:String = "DEBUG_INFO";
		public static var LOADING_INFO:String = "LOADING_INFO";
		public static var LOADING_NUM_INFO:String = "LOADING_NUM_INFO";
		//mtt 比赛开始
		public static var MTT_START:String = "MTT_START";
		//mtt 完毕
		public static var MTT_FINISH:String = "MTT_FINISH";
		//给筹码返回
		public static var UPDATE_GIVEN_MONEY:String = "UPDATE_GIVEN_MONEY";
		//荷官说话
		public static var ROSE_REAL_TALK:String = "ROSE_REAL_TALK";
		public static var ROSE_CHECK_TALK:String = "ROSE_CHECK_TALK";
		//更新在线好友
		public static var UPDATE_ONLINE_FRIEND:String = "UPDATE_ONLINE_FRIEND";
		
		public static var ERROR_CODE_WINDOW:String = "ERROR_CODE_WINDOW";
		//显示奖品提示
		public static var SHOW_REWARD_TIPS:String = "SHOW_REWARD_TIPS";
		//初始化桌面
		public static var NET_FORCE_RESET_TABLE:String = "NET_FORCE_RESET_TABLE";
		//本人登录桌子
		public static var NET_LOGIN_TABLE:String = "NET_LOGIN_TABLE";
		public static var NET_INIT_TABLE:String = "NET_INIT_TABLE";
		public static var NET_HAND_POKER:String = "NET_HAND_POKER";//发手牌
		public static var ROUND_START:String = "ROUND_START";//紧跟发手牌后面牌局开始
		//显示allin ready按钮
		public static var SHOW_ALL_IN_READY_BTN:String = "SHOW_ALL_IN_READY_BTN";
		//更改桌子主题
		public static var TABLE_CHANGE_STYLE:String = "TABLE_CHANGE_STYLE";
		//桌牌
		public static var TABLE_CARD_BACK_CHANGE_STYLE:String = "TABLE_CARD_BACK_CHANGE_STYLE";
		//进入桌子
		public static var GET_IN_TABLE:String = "GET_IN_TABLE";
		//自动进入牌桌
		public static var PLAY_NOW_IN_TABLE:String = "PLAY_NOW_IN_TABLE";
		//更新房间列表
		public static var UPDATE_ROOM_LIST:String = "UPDATE_ROOM_LIST";
		
		public static var SLIDE_CHANGE:String = "SLIDE_CHANGE";
		public static var CLICK_CHANGE:String = "CLICK_CHANGE";
		//mtt 进入比赛提醒 
		public static var MTT_REMIND:String = "MTT_REMIND";
		//mtt 我的排名变化
		public static var MTT_MY_REAL_RANK:String = "MTT_MY_REAL_RANK";
		//mtt 拼桌等待
		public static var MTT_SHOW_WAITING_PINZHUO:String = "MTT_SHOW_WAITING_PINZHUO";
		//mtt 比赛取消
		public static var MTT_CANCEL:String = "MTT_CANCEL";
		//更新牌型
		public static var UPDATE_MY_POKER_TYPE:String = "UPDATE_MY_POKER_TYPE";
		//晃动手牌
		public static var SHAKE_HAND_POKER:String = "SHAKE_HAND_POKER";
		//更新经验显示
		public static var UPDATE_EXP:String = "UPDATE_EXP";
		//截屏
		public static var SCREEN_SHOT:String = "SCREEN_SHOT";
		//牌桌互动事件
		public static var INTER_EVENT:String = "INTER_EVENT";
		//初始化房间
		public static var INIT_ROOM:String = "INIT_ROOM";
		//显示玩家详细信息
		public static var SHOW_PLAYER_DETAIL:String = "SHOW_PLAYER_DETAIL";
		public static var SHOW_ROUND_PLAYER_DETAIL:String = "SHOW_ROUND_PLAYER_DETAIL";
		//快速回复
		public static var QUICK_TALK:String = "QUICK_TALK";
		//更新成就
		public static var UPDATE_ACHIE:String = "UPDATE_ACHIE";
		//更改赛事
		public static var CHANGE_ROOM_TYPE:String = "CHANGE_ROOM_TYPE";
		//更改ringgame
		public static var CHANGE_RING_GAME_TYPE:String = "CHANGE_RING_GAME_TYPE";
		
		public static var WINDOW_SHOW:String = "WINDOW_SHOW";
		public static var WINDOW_HIDE:String = "WINDOW_HIDE";
		
		/*========================================
		*状态机事件
		*=========================================
		*/
		public static var AI_ROUND:String = "AI_ROUND";
		public static var FIRST_ROUND:String = "FIRST_ROUND";
		public static var COVER_ROUND:String = "COVER_ROUND";
		public static var SECOND_ROUND:String = "SECOND_ROUND";
		public static var THIRD_ROUND:String = "THIRD_ROUND";
		public static var FINAL_ROUND:String = "FINAL_ROUND";
		public static var RESULT_ROUND:String = "RESULT_ROUND";
		
		/*========================================
		*打牌事件
		*=========================================
		*/
		public static var SHOW_BUTTON:String = "SHOW_BUTTON";//选庄
		public static var RETURN_LOBBY:String = "RETURN_LOBBY";//回大厅
		public static var HIDE_TABLE:String = "HIDE_TABLE";//回大厅
		public static var STAND_UP:String = "STAND_UP";//从座位站起
		public static var HAND_POKER:String = "HAND_POKER";//发手牌
		public static var HAND_POKER_END:String = "HAND_POKER_END";//发手牌
		public static var ACTION:String = "ACTION";//动作
		public static var NEXT_TURN:String = "NEXT_TURN";//回合
		public static var TURN:String = "TURN";//回合
		public static var WIN_TURN:String = "WIN_TURN";//回合
		public static var EARN_CLIP:String = "EARN_CLIP";//玩家赢得筹码
		public static var COLLECT_CLIP:String = "COLLECT_CLIP";//收集筹码
		public static var TURN_END:String = "TURN_END";//回合
		public static var SHOW_RESULT:String = "SHOW_RESULT";//结算
		public static var SHOW_OTHER_HAND_POKER:String = "SHOW_OTHER_HAND_POKER";//其他玩家手牌
		public static var SHOW_RESULT_FLIP:String = "SHOW_RESULT_FLIP";//结算
		public static var CLIP_CHANGE:String = "CLIP_CHANGE";//玩家筹码变化
		public static var CARD_COMPARE:String = "CARD_COMPARE";//玩家比牌
		public static var RESULT_LOG:String = "RESULT_LOG";//结算log
		public static var OPERATE_LOG_CARD:String = "OPERATE_LOG_CARD";//显示桌牌
		public static var SHOW_ANIMATION:String = "SHOW_ANIMATION";//互动表情
		public static var BLIND_CHANGE:String = "BLIND_CHANGE";//更改盲注
		public static var CHANGE_DAILY_TASK_TIP:String = "CHANGE_DAILY_TASK_TIP";//显示日常任务提醒
		public static var UPDATE_DAILY_TASK:String = "UPDATE_DAILY_TASK";//更新日常任务显示
		public static var BIG_CARD_HAPPEN:String = "BIG_CARD_HAPPEN";//好牌发生
		
		public static var SHOW_HOLE_CARDS:String = "SHOW_HOLE_CARDS";//展示底牌
		public static var GET_OBSERVE_PLAYERS:String = "OBSERVE_PLAYERS";//获取围观群众
		
		public static var COUNT_DOWN_BOX:String = "COUNT_DOWN_BOX";//同步倒计时宝箱剩余时间
		public static var COUNT_DOWN_BOX_STOP:String = "COUNT_DOWN_BOX_STOP";//同步倒计时宝箱剩余时间
		public static var OPEN_COUNT_DOWN_BOX:String = "OPEN_COUNT_DOWN_BOX";//倒计时宝箱领奖
		public static var EVENT_RED_TIP:String = "EVENT_RED_TIP";//完成任务
		public static var UPDATE_ACTIVITES_LIST:String = "UPDATE_ACTIVITES_LIST";//活动列表
		public static var UPDATE_SPE_MTT_LIST:String = "UPDATE_SPE_MTT_LIST";//更新特殊活动列表
		
		public static var FLOP_CARD:String = "FLOP_CARD";//发公共牌
		public static var RESET:String = "RESET";//重置桌子
		public static var CHAT:String = "CHAT";//聊天
		public static var SEND_PRIVATE_CHAT:String = "SEND_PRIVATE_CHAT";//发起私聊聊天
//		public static var OPERATE_ACHIEVEMENT:String = "OPERATE_ACHIEVEMENT";//操作成就 
		public static var KEY_DOWN:String = "KEY_DOWN";//键盘事件
		
		/*========================================
		*http
		*=========================================
		*/
		public static var INFO_INIT:String = "INFO_INIT";//玩家信息初始化 
		public static var OFFLINE_RETRY:String = "OFFLINE_RETRY";//短线重连
		public static var UPDATE_USER_INFO:String = "UPDATE_USER_INFO";//更新个人信息
		public static var UPDATE_PACK_INFO:String = "UPDATE_PACK_INFO";//更新背包信息
		public static var UPDATE_USER_SUMMARY:String = "UPDATE_USER_SUMMARY";//更新个人详细信息
		
		
		public static var UN_SELECTED:String = "UN_SELECTED";//取消选择
		
//		public static var UPDATE_MESSAGE:String = "UPDATE_MESSAGE";//更新消息中心
//		public static var UPDATE_TASK:String = "UPDATE_TASK";//更新任务
		public function EventType()
		{
		}
	}
}