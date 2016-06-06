package com.jzgame.events
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 23, 2013 5:51:44 PM 
	 * @description:
	 */ 
	import flash.events.Event;
	
	public class ChangeStateEvent extends Event
	{
		public static var CHANGE_PARENT_STATE:String = 'CHANGE_PARENT_STATE';
		public static var CHANGE_STATE:String = 'CHANGE_STATE';
		public static var CHANGE_STATE_ENTER:String = 'CHANGE_STATE_ENTER';
		public static var CHANGE_STATE_EXIT:String = 'CHANGE_STATE_EXIT';
		
		public var state:String;
		public function ChangeStateEvent(newState:String,eventType:String = 'CHANGE_STATE')
		{
			state = newState;
			super(eventType, bubbles, cancelable);
		}
	}
}