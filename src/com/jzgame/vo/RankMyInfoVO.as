package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class RankMyInfoVO extends ValueObject
	{
		/*auther     :jim
		* file       :RankMyInfoVO.as
		* date       :Jan 22, 2015
		* description:
		*/
		//目标
		public var target:uint;
		//需求
		public var need:Number;
		//当前排名
		public var rank:Number;
		//当前值
		public var value:Number;
		public var myName:String;
		public var myFBID:String;
		public function RankMyInfoVO()
		{
			super();
		}
	}
}