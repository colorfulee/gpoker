package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class HunterConfigVO extends ValueObject
	{
		/***********
		 * name:    HunterConfigVO
		 * data:    Sep 25, 2015
		 * author:  jim
		 * des:
		 ***********/
//		<id>60001</id>
//			<name>RingGame玩不停</name>
//			<img>ReceiveGifts_10K</img>
//			<num>5</num>
//			<type>1</type>
//			<point>10</point>
//			<cash>102:5</cash>
		public var id:String;
		public var name:String;
		public var num:Number;
		public var type:String;
		public var point:Number;
		public var img:String;
		public var cash:String;
		public var link:String;
		public function HunterConfigVO()
		{
			super();
		}
	}
}