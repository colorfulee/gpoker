package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class PlayerRecordsItemVO extends ValueObject
	{
		/*auther     :jim
		* file       :PlayerRecordsItemVO.as
		* date       :Jan 7, 2015
		* description: 个人记录单条内容
		*/
		public var name:String = "";
		public var times:uint = 0;
		public var percent:Number = 0;
		public function PlayerRecordsItemVO()
		{
			super();
		}
	}
}