package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class PackageItemConfigVO extends ValueObject
	{
		/***********
		 * name:    PackageItemConfigVO
		 * data:    Jul 23, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var id:uint = 0;
		public var name:String = "";
		public var desc:String = "";
		public var auto_use:uint = 0;
		public var img:String = "";
		public var bonus:Array = [];
		
		public function PackageItemConfigVO()
		{
			super();
		}
	}
}