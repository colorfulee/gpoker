package com.jzgame.vo.game
{
	import com.spellife.vo.ValueObject;
	
	import flash.events.Event;
	
	public class MTTAttendVO extends ValueObject
	{
		/*auther     :jim
		* file       :MTTAttendVO.as
		* date       :Mar 9, 2015
		* description:
		*/
		public var matchID:String;
		private var _status:uint;
		public function MTTAttendVO()
		{
			super();
		}

		public function get status():uint
		{
			return _status;
		}

		public function set status(value:uint):void
		{
			_status = value;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}