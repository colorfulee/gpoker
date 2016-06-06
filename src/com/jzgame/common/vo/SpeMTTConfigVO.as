package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class SpeMTTConfigVO extends ValueObject
	{
		/*auther     :jim
		* file       :SpeMTTConfigVO.as
		* date       :Apr 21, 2015
		* description:
		*/
		public var id:String;
		public var name:String;
		public var type:String;
		public var icon:String;
		public var cost_item:String;
		public var bonus:Array = [];
		public var reward:String;
		public function SpeMTTConfigVO()
		{
			super();
		}
	}
}