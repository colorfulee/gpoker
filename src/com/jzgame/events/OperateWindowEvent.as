package com.jzgame.events
{
	import flash.events.Event;
	
	public class OperateWindowEvent extends Event
	{
		public var operateType:String;
		public var windowName:String;
		
		public static var SHOW:String = "SHOW";
		public static var HIDE:String = "HIDE";
		
		public function OperateWindowEvent(name:String,type_:String)
		{
			super(type_);
			
			operateType = type_;
			windowName  = name;
		}
		
		override public function clone():Event
		{
			return new OperateWindowEvent(windowName,operateType);
		}
	}
}