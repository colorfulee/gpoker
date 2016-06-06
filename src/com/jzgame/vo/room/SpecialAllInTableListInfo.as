package com.jzgame.vo.room
{
	public class SpecialAllInTableListInfo extends RoomBaseInfoVO
	{
		/*auther     :jim
		* file       :SpecialTableListInfo.as
		* date       :Feb 4, 2015
		* description:all in玩法数据集合
		*/
//		"ip": "192.168.1.52:9088",
//		"enter_cost": "200000",
//		"online": "0/2",
//		"table": "Level A-1",
//		"reward": "400000",
//		"id": 140007,
//		"service_cost": "10000"

		public var table:String = "";
		public var reward:Number = 0;
		public var enter_cost:Number = 0;
		public var service_cost:Number = 0;
		public function SpecialAllInTableListInfo()
		{
			super();
		}
	}
}