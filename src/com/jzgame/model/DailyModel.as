package com.jzgame.model
{
	import com.jzgame.vo.DailyLoginInfoVO;

	public class DailyModel
	{
		/*auther     :jim
		* file       :DailyModel.as
		* date       :Jan 26, 2015
		* description:日常任务的数据模块
		*/
		
//		"daily_chips": {
//			"login_bonus": 0,
//			"friend_bonus": 1,
//			"vip_bonus": "0", 
//			"bonused": "1"   #是否领取过奖励
//		},
//		"daily_login": {
//			"201501": {
//				"days": "1",
//				"fill_days": "0",
//				"bonused_7": "0",
//				"bonused_15": "0",
//				"bonused_31": "0"
//			},
//			"201412": {
//				"days": "27",
//				"fill_days": "0",
//				"bonused_7": 0,
//				"bonused_15": 0,
//				"bonused_31": "0"
//			}
//		}
		//每日登录奖励
		public var loginBonus:Number = 0;
		//邀请数量
		public var friendNum:Number = 0;
		public var friendBonus:Number = 0;
		public var vipBonus:Number = 0;
		public var getBonus:Boolean = false;
		public var month:DailyLoginInfoVO;
		public var lastMonth:DailyLoginInfoVO;
		
		//缓存每日登录的奖励id
		public var dailyBonus:Array = [1];
		//缓存总奖励id
		public var totalBonus:Array = [];
		public function DailyModel()
		{
		}
	}
}