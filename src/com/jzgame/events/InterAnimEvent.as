package com.jzgame.events
{
	import flash.events.Event;
	
	public class InterAnimEvent extends Event
	{
		/*auther     :jim
		* file       :InterAnimEvent.as
		* date       :Apr 8, 2015
		* description:
		*/
		public static var SEND:String = "SEND";
		
		public var animId:uint;
		public var seat:uint;
		public var fromSeat:uint;
		public function InterAnimEvent(item:uint,targetSeatId:uint,from:uint)
		{
			super(SEND, bubbles, cancelable);
			
			animId = item;
			seat   = targetSeatId;
			fromSeat  = from;
		}
		
		override public function clone():Event
		{
			return new InterAnimEvent(animId,seat,fromSeat);
		}
	}
}