package com.jzgame.vo.game
{
	import com.spellife.vo.ValueObject;
	
	public class MTTGlobalRankVO extends ValueObject
	{
		/*auther     :jim
		* file       :MTTGlobalRankVO.as
		* date       :May 8, 2015
		* description:mtt 全局排名vo
		*/
//		"uid": 1008,
//		"fbId": "012345678901008",
//		"name": "Player 1008",
//		"joinTimes": 10,
//		"championTimes": 5,
//		"runnerUpTimes": 2,
//		"secondRunnerUpTimes": 2,
//		"totalPrize": 9

		public var uid:String = "";
		public var fbId:String = "";
		public var name:String = "";
		public var joinTimes:String = "";
		public var championTimes:String = "";
		public var runnerUpTimes:String = "";
		public var secondRunnerUpTimes:String = "";
		public var totalPrize:String = "";
		public var index:Number = 0;
		public function MTTGlobalRankVO()
		{
			super();
		}
	}
}