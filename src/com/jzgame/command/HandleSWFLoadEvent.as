package com.jzgame.command
{
	import flash.events.Event;
	
	public class HandleSWFLoadEvent extends Event
	{
		/*auther     :jim
		* file       :HandleSWFLoadEvent.as
		* date       :Apr 16, 2015
		* description:
		*/
		public static var LOAD:String = "HandleSWFLoadEvent_LOAD";
		public var sourceId:String;
		public var sourceLink:String;
		public function HandleSWFLoadEvent(sourceid:String, link_:String)
		{
			super(LOAD, bubbles, cancelable);
			
			sourceId = sourceid;
			sourceLink = link_;
		}
		
		override public function clone():Event
		{
			return new HandleSWFLoadEvent(sourceId,sourceLink);
		}
	}
}