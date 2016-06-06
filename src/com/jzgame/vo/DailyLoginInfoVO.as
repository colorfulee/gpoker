package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class DailyLoginInfoVO extends ValueObject
	{
		/*auther     :jim
		* file       :DailyLoginInfoVO.as
		* date       :Jan 26, 2015
		* description:日常登录数据
		*/
		//		       "days": "27",
		//				"fill_days": "0",
		//				"bonused_7": 0,
		//				"bonused_15": 0,
		//				"bonused_31": "0"
		public var year:Number;
		public var month:Number;
		//登录天数
		public var days:Number = 0;
		//补签的天数
		public var fillDays:Number = 0;
		public var bonus7:Number = 0;
		public var bonus15:Number = 0;
		public var bonus31:Number = 0;
		public function DailyLoginInfoVO()
		{
			super();
		}
	}
}