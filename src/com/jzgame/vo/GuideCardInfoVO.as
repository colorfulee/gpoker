package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class GuideCardInfoVO extends ValueObject
	{
		/*auther     :jim
		* file       :GuideCardInfoVO.as
		* date       :Oct 10, 2014
		* description:
		*/
		public var index:uint = 1;
		public var shadow:uint= 1;
		public var card:Array = [];
		
		public function GuideCardInfoVO()
		{
			super();
		}
	}
}