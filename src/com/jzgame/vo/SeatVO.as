package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class SeatVO extends ValueObject
	{
		public var clip:Number = 0;
		
		public function SeatVO(value:Number)
		{
			super();
			
			clip = value;
		}
	}
}