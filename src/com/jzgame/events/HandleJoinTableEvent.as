package com.jzgame.events
{
	import flash.events.Event;
	
	public class HandleJoinTableEvent extends Event
	{
		/*auther     :jim
		* file       :HandleJoinTableEvent.as
		* date       :Apr 17, 2015
		* description:加入桌子
		*/
		public static var JOIN:String = "HandleJoinTableEvent_JOIN";
		public var id:String;
		public var offLine:Boolean = false;
		public function HandleJoinTableEvent(tableid:String,offLine_:Boolean = false)
		{
			super(JOIN, bubbles, cancelable);
			
			id = tableid;
			
			offLine = offLine_;
		}
		
		override public function clone():Event
		{
			return new HandleJoinTableEvent(id,offLine);
		}
	}
}