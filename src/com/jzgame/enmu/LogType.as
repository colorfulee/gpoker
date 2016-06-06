package com.jzgame.enmu
{
	public class LogType
	{
		/***********
		 * name:    LogType
		 * data:    Jun 29, 2015
		 * author:  jim
		 * des:
		 ***********/
//		public static var LOAD_END:String = "pgl";
//		flash加载资源
		public static var LOAD_PROGRESS:String = "fld";
//		主文件加载成功
		public static var LOAD_END:String = "fml";
//		弹出新玩家选择框
		public static var SHOW_NEW_TIP:String = "shf";
		//选择“新手教程”or“立刻游戏”  值，0代表“新手教程”，1代表“立刻游戏”
		public static var FIRST_CHOICE:String = "chs";
//		新手教程（玩法）
		public static var NEWER_GUIDE:String = "grt";
//		退出新手教程（玩法）
		public static var NEWER_GUIDE_QUIT:String = "qrt";
//		直接进入新手教程（实战演练）
		public static var GO_NEWER_GUIDE:String = "tct";
//		新手教程（实战演练）
		public static var GO_NEWER_GAME_GUIDE:String = "gct";
//		退出新手教程（实战演练）
		public static var QUIT_NEWER_GAME_GUIDE:String = "qct";
//		进入房间
		public static var JOIN_TABLE:String = "jnt";
//		坐下
		public static var SIT:String = "std";
//		牌局开始
		public static var HAND:String = "hnb";
//		牌局结束（正常结算，没有正常退出）
		public static var GAME_ROUND:String = "hne";
//		中途退出（站起来）
		public static var GAME_STAND_UP:String = "xts";
//		中途退出（离开牌桌）
		public static var GAME_EXIT:String = "xtl";
		//立即游戏
		public static var PLAY_NOW:String = "pln";
		//事件，Newbie play now，新手场立即游戏
		public static var NEWBI_PLAY_NOW:String = "npl";
		
		public function LogType()
		{
		}
	}
}