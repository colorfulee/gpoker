package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class SevenLoginBonus extends ValueObject
	{
		/***********
		 * name:    SevenLoginBonus
		 * data:    Jul 23, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var id:Number = 0;
		public var day:Number = 0;
		public var status:uint = 0;
		public var bonus:Array = [];
		public function SevenLoginBonus()
		{
			super();
		}
	}
}