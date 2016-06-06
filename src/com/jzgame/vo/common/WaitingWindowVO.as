package com.jzgame.vo.common
{
	import com.spellife.vo.ValueObject;
	
	public class WaitingWindowVO extends ValueObject
	{
		/***********
		 * name:    WaitingWindowVO
		 * data:    Sep 16, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var windowName:String;
		public var data:Array;
		public function WaitingWindowVO(n:String,d:Array)
		{
			super();
			
			windowName = n;
			data = d;
		}
	}
}