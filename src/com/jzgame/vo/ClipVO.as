package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class ClipVO extends ValueObject
	{
		/*auther     :jim
		* file       :ClipVO.as
		* date       :Oct 31, 2014
		* description:
		*/
		public var seatID:uint = 0;
		public var clip:Number = 0;
		public var winType:uint = 0;
		public function ClipVO(seatID_:uint,clip_:Number = 0,winType_:uint = 1)
		{
			super();
			
			seatID = seatID_;
			clip = clip_;
			winType = winType_;
		}
	}
}