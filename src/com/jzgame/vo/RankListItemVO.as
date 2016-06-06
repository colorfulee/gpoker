package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class RankListItemVO extends ValueObject
	{
		/*auther     :jim
		* file       :RankListItemVO.as
		* date       :Jan 21, 2015
		* description:
		*/
		//当前排名
		public var index:Number = 1;
		public var name:String = "";
		public var uid:String = "";
		public var fbID:String = "";
		public var field:String = "";
		//上次排名
		public var lastIndex:Number = 1;
//		public var 
		public function RankListItemVO()
		{
			super();
		}
	}
}