package com.jzgame.vo.room
{
	import com.spellife.vo.ValueObject;
	
	public class SitAndGoTourTableListInfo extends ValueObject
	{
		/*auther     :jim
		* file       :SpecialTourTableListInfo.as
		* date       :Feb 4, 2015
		* description:
		*/
		//						"champion_prize": "SNG-9-1",
		//						"attendance_fee": 200,
		//						"service_fee": 20000,
		//						"kick_of_time": "0/9",
		//						"sign_up": ""
		
		public var id:uint = 0;
		public var attendance_fee:Number = 0;
		public var service_fee:Number = 0;
		public var online:Number = 0;
		public var maxRole:Number = 0;
		public var sign_up:String = "";
		public var champion_prize:String;
		public var host:String;
		public var port:Number;
		
		public function SitAndGoTourTableListInfo()
		{
			super();
		}
	}
}