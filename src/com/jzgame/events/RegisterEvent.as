package com.jzgame.events
{
	import flash.events.Event;
	
	public class RegisterEvent extends Event
	{
		public static var IN:String = "IN";
		public function RegisterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}