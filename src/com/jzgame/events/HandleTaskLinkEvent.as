package com.jzgame.events
{
	import flash.events.Event;
	
	public class HandleTaskLinkEvent extends Event
	{
		/*auther     :jim
		* file       :HandlerTaskLinkEvent.as
		* date       :Apr 28, 2015
		* description:任务超链事件
		*/
		public static var CHANGE:String = "HandlerTaskLinkEvent_CHANGE";
		
		public var tabIndex:uint = 1;
		public var secondIndex:uint = 1;
		public function HandleTaskLinkEvent(tab:uint = 1, second:uint = 1)
		{
			super(CHANGE, bubbles, cancelable);
			
			tabIndex = tab;
			secondIndex = second;
		}
		
		override public function clone():Event
		{
			return new HandleTaskLinkEvent(tabIndex,secondIndex);
		}
	}
}