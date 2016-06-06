package com.jzgame.events
{
	import flash.events.Event;
	
	public class AddSourceEvent extends Event
	{
		/***********
		 * name:    AddSourceEvent
		 * data:    Jun 5, 2015
		 * author:  jim
		 * des:     添加金币或者筹码事件
		 ***********/
		public static var ADD:String = "AddSourceEvent_ADD";
		
		public var displayState:String;
		public var addChip:Boolean = false;
		
		public function AddSourceEvent(addchip:Boolean =false,dis:String = "")
		{
			super(ADD, bubbles, cancelable);
			
			displayState = dis;
			addChip  = addchip;
		}
		
		override public function clone():Event
		{
			var event:AddSourceEvent = new AddSourceEvent();
			event.displayState = displayState;
			event.addChip      = addChip;
			return event;
		}
	}
}