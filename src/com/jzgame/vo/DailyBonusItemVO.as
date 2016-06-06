package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class DailyBonusItemVO extends ValueObject
	{
		/*auther     :jim
		* file       :DailyBonusItemVO.as
		* date       :Jan 22, 2015
		* description:日常任务的数据集合
		*/
		public var id:String = "";
		//标题
		public var title:String = "";
		//当前完成数量
		public var current:uint = 0;
		//需要完成数量
		public var target:uint = 0;
		//描述信息
		public var des:String="";
		//状态
		public var status:uint = 0;
		public function DailyBonusItemVO()
		{
			super();
		}
	}
}