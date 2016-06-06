package com.jzgame.common.services
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 9, 2013 5:30:05 PM
	 * @description:
	 */ 
	public class MessageType
	{
		//登陆桌子
		public static var SEND_LOGIN_TABLE:uint = 1;
		//登陆桌子返回
		public static var RECEIVE_LOGIN_TABLE:uint = 1001;
		//坐下
		public static var SEND_SIT_DOWN:uint = 2;
		//站起来
		public static var SEND_STAND_UP:uint = 4;
		//发送行为
		public static var SEND_ACTION:uint = 5;
		//准备完毕
		public static var SEND_READY:uint = 8;
		//发送聊天
		public static var SEND_CHAT:uint = 9;
		//给荷官小费
		public static var SEND_GIVE_MONEY:uint = 17;
		//加入mtt
		public static var SEND_JOIN_MTT:uint = 21;
		//全局喇叭
		public static var SEND_GLOBAL_MESSAGE:uint = 24;
		//邀请好友参加比赛
		public static var SEND_INVITE_FRIEND_JOIN_GAME:uint = 27;
		//互动事件
		public static var SEND_INTER_EVENT:uint = 30;
		//请求围观群众
		public static var SEND_OBSERVE_PLAYERS:uint = 32;
		//坐下返回
		public static var RECEIVE_SIT_DOWN:uint = 1002;
		//发手牌
		public static var RECEIVE_HAND_POKER:uint = 1003;
		//某人站起来
		public static var RECEIVE_STAND_UP:uint = 1004;
		//收到行为
		public static var RECEIVE_ACTION:uint = 1005;
		//接受桌牌
		public static var RECEIVE_TABLE_CARD:uint = 1006;
		//结算
		public static var RECEIVE_RESULT:uint = 1007;
		//聊天
		public static var RECEIVE_MESSAGE:uint = 1009;
		//成就弹框
		public static var RECEIVE_ACHIEMENT:uint = 1011;
		//其他人进入游戏
		public static var RECEIVE_ENTER_GAME_BRODCAST:uint = 0xB003;
		
		//离开游戏
		public static var SEND_LEAVE_GAME:uint = 0x1009;
		//离开游戏反馈
		public static var RECEIVE_LEAVE_GAME:uint = 0x6009;
		//离开游戏廣播
		public static var LEAVE_BRODCAST_RETURN:uint = 0xB009;
		//后台调试信息
		public static var SERVER_DEBUG_INFO:uint = 0xB201;
		
		//老虎机
		public static const SEND_START_SLOT:uint = 12;
		//老虎机返回
		public static const RECEIVE_START_SLOT:uint = 1012;
		//表情互动
		public static const USE_INTERACTIVE_ITEM_REQUEST:uint = 16;
		//表情互动返回
		public static const USE_INTERACTIVE_ITEM_RESPONSE:uint = 1016;
		//给荷官小费返回
		public static const GIVE_MONEY_RESPONSE:uint = 1017;
		//收到盲注改变
		public static const BLINDS_CHANGE_RESPONSE:uint = 1014;
		//特殊牌局结算
		public static const TOUR_GAME_COUNT_RESPONSE:uint = 1015;
		//mtt 即时排名
		public static const MTT_REAL_RANK_RESPONSE:uint = 1022;
		//mtt 结束
		public static const MTT_FINISH_RESPONSE:uint = 1023;
		//MTT 等待拼桌
		public static const MTT_WAITING_RESPONSE:uint = 1019;
		//mtt 拼桌完成
		public static const MTT_WAITING_END_RESPONSE:uint = 1020;
		//tour 比赛取消
		public static const TOUR_CANCEL:uint = 1031;
		//全局喇叭
		public static const GLOBAL_MESSAGE_RESPONSE:uint = 1024;
		//玩家结算信息
		public static const PLAYER_SETTLEMENT_RESPONSE:uint = 1025;
		//玩家牌型
		public static const PLAYER_BEST_CARD_TYPE_RESPONSE:uint = 1026;
		//更新道具
		public static const ITEM_UPDATE_RESPONSE:uint = 1028;
		//MTT 开赛
		public static const MTT_START_RESPONSE:uint = 1029;
		//互动事件
		public static const INTER_EVENT_RESPONSE:uint = 1030;
		//围观群众
		public static const OBSERVER_PLAYERS:uint = 1032;
		
		//展示底牌
		public static const SHOW_HOLE_CARDS_REQUEST:uint = 33;
		//展示底牌
		public static const SHOW_HOLE_CARDS_RESPONSE:uint = 1033;
				
		//同步倒计时宝箱剩余时间
		public static const COUNT_DOWN_BOX_RESPONSE:uint = 1034;
		//倒计时宝箱领奖
		public static const OPEN_COUNT_DOWN_BOX_REQUEST:uint = 35;
		//倒计时宝箱领奖
		public static const OPEN_COUNT_DOWN_BOX_RESPONSE:uint = 1035;
		//大乐透更新
		public static const JACK_POT_RESPONSE:uint = 1037;
		//下注大乐透
		public static const BET_JACK_POT:uint = 36;
		//获得奖券
		public static const GET_COUPON_RESPONSE:uint = 1101;
		//获得拼图
		public static const GET_PUZZLE_RESPONSE:uint = 1102;
		
		
		//#################短链####################
		//玩家手机初始化
		public static var PLAYER_LOGIN:String = "player.login";
		//玩家初始化
		public static var PLAYER_INIT:String = "player.init";
		public static var ADD_FRIEND:String = "player.add_friend";
		public static var DELETE_FRIEND:String = "player.delete_friend";
		//邮件
		public static var MESSAGE_GET:String = "message.get";
		//任务
		public static var TASK_GET:String = "task.get";
		public static var TASK_BONUS:String = "task.bonus";
		//成就
		public static var ACHIEVEMENT_GET:String = "achievement.get_by_uid";
		//领取奖励
		public static var ACHIEVEMENT_BONUS_GET:String = "achievement.bonus";
		//其他玩家成就
		public static var ACHIEVEMENT_OTHER_GET:String = "achievement.get_by_uid";
		//处理邮件
		public static var MESSAGE_PROCESS:String = "message.process_message";
		//获取玩家信息
		public static var PLAYER_SUMMARY:String = "player.get_summary";
		//获取在线好友信息
		public static var PLAYER_GET_ONLINE:String = "player.get_online";
		//获得玩家排行信息
		public static var PLAYER_RANK:String = "player.get_rank";
		//获取远端存储的配置
		public static var PLAYER_GET_CONFIG:String = "player.get_client_config";
		//存储远端配置
		public static var PLAYER_SEND_CONFIG:String = "player.set_client_config";
		//商店购买
		public static var MESSAGE_SHOP_BUY:String = "shop.buy";
		//商店送人
		public static var MESSAGE_SHOP_SEND:String = "shop.send";
		//查询背包
		public static var MESSAGE_PACKAGE:String = "pack.get";
		//使用物品
		public static var MESSAGE_PACKAGE_USE:String = "pack.use_item";
		//使用荷官或者桌子主题
		public static var USE_ROSE_OR_TABLEBACK:String = "shop.use_special";
		//日常任务信息
		public static var MESSAGE_DAILY_INFO:String = "daily.get_info";
		//日常获取筹码
		public static var MESSAGE_DAILY_GET_CHIP:String = "daily.get_daily_chip";
		//使用筹码填充
		public static var MESSAGE_DAILY_FILL_LOGIN:String = "daily.fill_login_days";
		//获取任务奖励
		public static var GET_TASK_BONUS:String = "daily.get_daily_task_bonus";
		//连续登陆筹码
		public static var MESSAGE_DAILY_GET_LOGIN_BONUS:String = "daily.get_login_bonus";
		//获取全部房间列表
		public static var MESSAGE_GET_ROOM_LIST:String = "player.get_room_info";
		//MTT 报名
		public static var MESSAGE_MTT_SIGN_UP:String = "player.mtt_sign";
		//mtt 比赛即时排名
		public static var MESSAGE_MTT_MATCH_RANK:String = "player.get_mtt_rank_list";
		//SPEmtt 比赛即时排名
		public static var MESSAGE_SPE_MTT_MATCH_RANK:String = "player.get_spec_mtt_rank_list";
		//获取房间信息
		public static var MESSAGE_GET_TABLE_INFO:String = "player.get_table_info";
		//保存玩家最近的游戏记录 
		public static var MESSAGE_SET_PLAY_RECORD:String = "player.set_play_record";
		//获取玩家最近的游戏记录 
		public static var MESSAGE_GET_PLAY_RECORD:String = "player.get_play_record";
		//删除消息
		public static var MESSAGE_DELETE_MESSAGE:String = "message.delete_message";
		//批量处理消息
		public static var MESSAGE_PROGCESS_MESSAGE:String = "message.process_multi_message";
		//新手引导领取奖励
		public static var MESSAGE_GUIDE_PRIZE:String = "player.finish_guide";
		//获取mtt列表
		public static var MESSAGE_MTT_LIST:String = "player.get_mtt_list";
		//mtt全局排行榜
		public static var MESSAGE_MTT_G_LIST:String = "player.get_global_mtt_rank";
		//心跳
		public static var HEART:String = "player.hello";
		//加载素材所用时间
		public static var START_LOAD_TIME:String = "player.record_flash_load_time";
		//购买ticket门票
		public static var LUCKY_WHEEL_BUY:String = "lucky_wheel.buy";
		//成就完成
		public static var ACHIEVEMENT_FINISH:String = "achievement.finish";
		
		public static var LUCKY_WHEEL_CHECK_REWARD:String = "lucky_wheel.check";
		public static var LUCKY_WHEEL_START:String = "lucky_wheel.draw";
		public static var LUCKY_WHEEL_RECORD_LIST:String = "lucky_wheel.get_record_list";
		//获取公告
		public static var NOTE:String = "player.get_announcement";
		//获取七日登录状态
		public static var SEVEN_LOGIN_INFO:String = "player.get_total_login_info";
		//七日获取奖励
		public static var SEVEN_GET_REWARD:String = "player.get_total_login_bonus";
		//保险箱
		public static var SAFE_BOX_SET_PASSWARD:String = "player.set_box_pwd";
		public static var SAFE_BOX_LOGIN:String = "player.box_login";
		public static var SAFE_BOX_SAVE:String = "player.box_deposit";
		public static var SAFE_BOX_GET_BACK:String = "player.box_withdraw";
		//重置密码
		public static var SAFE_BOX_RESET_PWD:String = "player.reset_box_pwd";
		//大乐透
		public static var JACK_POT_RECORD:String = "player.get_jack_pot_record";
		//新手操作
		public static var CHANGE_LOGIN_STATUS:String = "player.change_login_status";
		public static var TASK_DEBUG:String = "player.gm";
		//设置个人信息
		public static var SET_USER_INFO:String = "player.set_user_info";
		//活动列表
		public static var ACTIVITY_LIST_INFO:String = "activity.get_list";
		//兑换奖券
		public static var ACTIVITY_EXCHANGE:String = "activity.exchange";
		//排行榜
		public static var ACTIVITY_RANK:String = "activity.get_rank";
		//翻牌
		public static var ACTIVITY_LUCKY_DRAW:String = "activity.lucky_draw";
		//刷新翻牌
		public static var ACTIVITY_RFRESH_LUCKY_DRAW:String = "activity.refresh_lucky_draw";
		//刷新任务
		public static var ACTIVITY_RFRESH_FESTERVAL_TASK:String = "activity.refresh_holiday_task";
		//领取任务奖励
		public static var ACTIVITY_GET_FESTERVAL_TASK:String = "activity.get_holiday_task_bonus";
		//完成赏金任务
		public static var FINISH_BOUNTY_HUNTER:String = "activity.finish_bounty_hunter";
		//领取赏金任务
		public static var TAKE_BOUNTY_HUNTER:String = "activity.get_bounty_hunter_bonus";
		//刷新任务
		public static var REFRESH_BOUNTY_HUNTER:String = "activity.refresh_bounty_hunter";
		//兑换赏金奖励
		public static var EXCHANGE_BOUNTY_HUNTER:String = "activity.exchange_bounty_hunter_bonus";
		//兑换拼图奖励
		public static var EXCHANGE_PUZZLE_PRIZE:String = "activity.exchange_pics_bonus";
		//获取特殊列表
		public static var SPE_MTT_LIST:String = "player.get_spec_mtt_list";
		//特殊报名
		public static var SPE_MTT_SIGN:String = "player.spec_mtt_sign";
		//spemtt全局排名
		public static var SPE_MTT_GLOBAL_RANK:String = "player.get_global_spec_mtt_rank";
		/*定点玩牌*/
		
		//获取详细信息
		public static var LIMIT_GAME_GET_INFO:String = "limit_game.get_info";
		//领取奖励
		public static var LIMIT_GAME_BONUS:String = "limit_game.bonus";
		
		
		//协议头长度
//		public static const MSG_HEADER_LENGTH:int = 4;
		public static const MSG_HEADER_INFO_LENGTH:int = 4;//协议总长度
		//协议最大长度
//		public static const MSG_MAX_LENGTH:int = 10240;
		
		public static const MAX_LOGINPRIZE_DAYS:int = 7;
	}
}