package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class TaskConfigVO extends ValueObject
	{
		/*auther     :jim
		* file       :TaskConfigVO.as
		* date       :Dec 9, 2014
		* description:
		*/
		
		public var id:String;//唯一索引
		public var name:String;//任务名称
		public var title:String;//任务名称描述
		public var desc:String;//任务详细描述
		public var img:String//任务icon
		public var type:String;//任务类型
		public var point:String;//目标值XXX
		public var level:String;//开启等级
		public var task_desc:String;//开启等级
		public var limited:uint;//是否限时
		public var start_time:Number;//限时开始时间
		public var end_time:Number;//是否结束时间
		public var bonus:String;// 奖励，格式：101:1;4001:2
		
		public function TaskConfigVO()
		{
			super();
		}
	}
}