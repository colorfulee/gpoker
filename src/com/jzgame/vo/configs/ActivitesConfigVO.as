package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class ActivitesConfigVO extends ValueObject
	{
		/***********
		 * name:    ActivitesConfigVO
		 * data:    Sep 17, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var id:String;
		public var name:String;
		public var desc:String;
		public var img:String;
		public var type:uint;
		public var repeat:uint;
		public var rewards:Array;
		public var bonus:Object ;
		public var realBonus:Array;
		public var refresh:String;
		public function ActivitesConfigVO()
		{
			super();
		}
	}
}