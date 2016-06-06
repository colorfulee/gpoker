package com.jzgame.common.events
{
	import flash.events.Event;

	public class SimpleEvent extends Event
	{
		public var carryData:Object;
		public function SimpleEvent(type:String,data_:Object = null)
		{
			super(type, bubbles);
			
			carryData = data_;
		}
		
		override public function clone():Event
		{
			return new SimpleEvent(type,carryData);
		}
	}
}