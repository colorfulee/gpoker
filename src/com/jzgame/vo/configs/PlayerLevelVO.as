package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class PlayerLevelVO extends ValueObject
	{
		/*auther     :jim
		* file       :PlayerLevelVO.as
		* date       :Feb 2, 2015
		* description:玩家称号vo
		*/
		//		<id>22</id>
		//			<level>22</level>
		//			<title>World-class Player</title>
		//			<exp>326416</exp>
		//			<bonus>3003:2,4002:5</bonus>
		public var id:String;
		public var level:uint;
		public var title:String;
		public var exp:Number;
		public var bonus:String;
		
		public function PlayerLevelVO()
		{
			super();
		}
	}
}