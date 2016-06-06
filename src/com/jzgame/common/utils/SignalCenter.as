package com.jzgame.common.utils
{
	import org.osflash.signals.Signal;

	public class SignalCenter
	{
		/***********
		 * name:    SignalCenter
		 * data:    Nov 10, 2015
		 * author:  jim
		 * des:
		 ***********/
		//初始结束
		public static var onInitialLoadComplete:Signal = new Signal();
		//握手信号
		public static var onConnectComplete:Signal = new Signal();
		//更新个人信息
		public static var onUpdateUserInfo:Signal = new Signal();
		//加入普通桌子
		public static var onJoinTable:Signal = new Signal();
		//领取任务奖励
		public static var onTaskReward:Signal = new Signal(uint);
		//点击商店item显示详细信息
		public static var onShopItemTriggered:Signal = new Signal(uint);
		//点击商店item购买
		public static var onShopItemBuyTriggered:Signal = new Signal(uint);
		//显示别人详细信息界面
		public static var onShowFriendInfoTriggered:Signal = new Signal(String);
		//显示我的道具详细信息
		public static var onShowPackItemInfoTriggered:Signal = new Signal(String,Number,Boolean);
		//all check mail
		public static var onShowMailItemInfoSelected:Signal = new Signal(Boolean);
		//邮件选择
		public static var onShowMailItemSelected:Signal = new Signal(uint,Boolean);
		//物品使用
		public static var onUsePackItem:Signal = new Signal(String);
		//游戏类型选择
		public static var onGameTriggered:Signal = new Signal(uint);
		//进入房间
		public static var onJoinTableTriggered:Signal = new Signal(uint);
		//点击坐下箭头
		public static var onSitDownArrowTriggered:Signal = new Signal(String);
		//聊天表情
		public static var onChatAnimItemTriggered:Signal = new Signal(String);
		//文本聊天
		public static var onChatQuickWordTriggered:Signal = new Signal(String);
		//@ some one
		public static var onChatAtTriggered:Signal = new Signal(String);
		//点击输入   默认输入内容
		public static var onChatShowInputTriggered:Signal = new Signal(String);
		//
		public static var onChatInputSendTriggered:Signal = new Signal(String);
//		public static var onInviteFriendTriggered:Signal = new Signal(String);
		public function SignalCenter()
		{
		}
	}
}