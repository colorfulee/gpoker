package com.jzgame.events
{
	import flash.events.Event;
	
	public class HandleDynamicSWFLoadCompleteEvent extends Event
	{
		/*auther     :jim
		* file       :HandleDynamicSWFLoadCompleteEvent.as
		* date       :Apr 17, 2015
		* description:
		*/
		public var id:String;
		public var source:*;
		
		public static var COMPLETE:String = "HandleDynamicSWFLoadCompleteEvent_COMPLETE";
		public function HandleDynamicSWFLoadCompleteEvent(id_:String,source_:* = null)
		{
			super(COMPLETE, bubbles, cancelable);
			
			id = id_;
			source = source_;
		}
		
		override public function clone():Event
		{
			return new HandleDynamicSWFLoadCompleteEvent(id,source);
		}
	}
}