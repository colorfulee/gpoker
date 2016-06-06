package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class MTTConfigVO extends ValueObject
	{
		/*auther     :jim
		* file       :MTTConfigVO.as
		* date       :Apr 21, 2015
		* description:
		*/
		public var id:String;
		public var name:String;
		public var type:String;
		public var icon:String;
		public var bonus:Array = [];
		public function MTTConfigVO()
		{
			super();
		}
	}
}