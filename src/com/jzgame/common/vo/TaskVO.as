package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class TaskVO extends ValueObject
	{
		/*auther     :jim
		* file       :TaskVO.as
		* date       :Dec 9, 2014
		* description:
		*/
		public var id:String;//task id
		public var status:uint;//状态
		public var finishTime:Number=0;//完成时间
		public var current:Number=0;//当前完成
		public var taskConfigVO:TaskConfigVO;
		public function TaskVO()
		{
			super();
		}
	}
}