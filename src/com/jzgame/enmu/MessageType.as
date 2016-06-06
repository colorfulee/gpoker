package com.jzgame.enmu
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
		//登陆房间
		public static var SEND_LOGIN_IN_FROM_LOBBY:uint = 0x1001;
		//登陆房间
		public static var SEND_LOGIN_IN:uint = 0x1000;
		//登陆房间返回
		public static var RECEIVE_LOGIN_IN:uint = 0x6000;
		public static var RECEIVE_LOGIN_IN_STANDARD:uint = 0x6001;
		//进入游戏
		public static var SEND_ENTER_GAME:uint = 0x1003;
		//进入游戏返回
		public static var RECEIVE_ENTER_GAME:uint = 0x6003;
		//进入游戏广播返回
		public static var RECEIVE_ENTER_GAME_BRODCAST:uint = 0xB003;
		//结算成功返回
		public static var COUNT_GAME_SUCCESS:uint = 0x6007;
		//结算成功广播
		public static var COUNT_GAME_BRODCAST:uint = 0xB007;
		
		
		//离开游戏
		public static var SEND_LEAVE_GAME:uint = 0x1009;
		//离开游戏反馈
		public static var RECEIVE_LEAVE_GAME:uint = 0x6009;
		//离开游戏廣播
		public static var LEAVE_BRODCAST_RETURN:uint = 0xB009;
		//后台调试信息
		public static var SERVER_DEBUG_INFO:uint = 0xB201;
		
		
//		####################
//		AI
//		####################
		//进入游戏
		public static var RECEIVE_AI_ENTER_GAME:uint = 0xB301;
		//离开游戏
		public static var RECEIVE_AI_LEAVE_GAME:uint = 0xB302;
		
		//协议头长度
		public static const MSG_HEADER_LENGTH:int = 24;
		public static const MSG_HEADER_INFO_LENGTH:int = 4;//协议总长度
		//协议最大长度
		public static const MSG_MAX_LENGTH:int = 10240;
		
		public static const MAX_LOGINPRIZE_DAYS:int = 7;
	}
}