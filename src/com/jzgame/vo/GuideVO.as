package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	import flash.geom.Rectangle;
	
	public class GuideVO extends ValueObject
	{
		/*auther     :jim
		* file       :GuideVO.as
		* date       :Sep 29, 2014
		* description:
		*/
		
		public var index:uint = 0;
		public var tipText:Rectangle = new Rectangle;
		public var tipHole:Rectangle = new Rectangle;
		public var arrowVO:GuideArrowVO = new GuideArrowVO;
		
		public function GuideVO()
		{
			super();
		}
	}
}