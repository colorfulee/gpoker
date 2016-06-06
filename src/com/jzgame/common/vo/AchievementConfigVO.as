package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class AchievementConfigVO extends ValueObject
	{
		/*auther     :jim
		* file       :AchievementConfigVO.as
		* date       :Dec 22, 2014
		* description:
		*/
		public var id:String;
		public var name:String;
		public var desc:String;
		public var achi_desc:String;
		public var img:String;
		public var firstlabel:String;
		public var secondlabel:String;
		public var level:String;
		public var type:String;
		public var point:String;
		public var bonus:String;
		public function AchievementConfigVO()
		{
			super();
		}
	}
}