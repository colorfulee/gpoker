package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class FestervalDayVO extends ValueObject
	{
		/***********
		 * name:    FestervalDayVO
		 * data:    Sep 25, 2015
		 * author:  jim
		 * des:
		 ***********/
//		<id>50002</id>
//			<name>越买越开心</name>
//			<num>5</num>
//			<type>2</type>
//			<point>10</point>
		public var id:String;
		public var name:String;
		public var num:Number;
		public var type:String;
		public var point:Number;
		public function FestervalDayVO()
		{
			super();
		}
	}
}