package com.jzgame.common.vo
{

	public class AchievementVO extends AchievementConfigVO
	{
		/*auther     :jim
		* file       :AchievementVO.as
		* date       :Dec 22, 2014
		* description:
		*/
		//成就完成状态 1--已完成 2--已领取奖励 
		private var _status:String="";
		public var finish_time:String = "0";
		public var bonus_time:String;
		//已经完成的
		public var current:Number = 0;
		//是否是自己的成就
		public var isMine:Boolean = true;
		public function AchievementVO()
		{
			super();
		}

		public function get status():String
		{
			return _status;
		}

		public function set status(value:String):void
		{
			if(_status != value)
			{
				_status = value;
//				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		override public function toString():String
		{
			var temp:String = "_status:"+this.status +":id:"+this.id+":current:"+this.current + ":finish time:"+this.finish_time;
			return temp;
		}
	}
}