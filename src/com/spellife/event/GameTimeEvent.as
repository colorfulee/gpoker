package com.spellife.event
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author XXL
	 */
	public class GameTimeEvent extends Event
	{
		public static const ONE_SECOND:int = 1000;
		
		public static const TICK:String = "TICK";
		public static const FRAME:String = "FRAME";
		public static const SECOND:String = "SECOND";
		public static const FORBIDDEN:String = "FORBIDDEN";
		
		public var interval:int;
		
		public function GameTimeEvent(type:String, interval:int) 
		{
			super(type);
			this.interval = interval;
		}
		
		override public function clone():Event
		{
			return new GameTimeEvent(this.type,this.interval);
		}
	}

}