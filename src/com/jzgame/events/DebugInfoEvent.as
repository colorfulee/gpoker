package com.jzgame.events
{
	import com.jzgame.enmu.EventType;
	
	import flash.events.Event;
	
	public class DebugInfoEvent extends Event
	{
		/*auther     :jim
		* file       :DebugInfoEvent.as
		* date       :Nov 4, 2014
		* description:
		*/
		//内容
		public var text:String ;
		//类型
		public var debugType:String;
		//显示颜色
		public var showColor:uint;
		public function DebugInfoEvent(info:String,type:String,color:uint = 0xffffff)
		{
			super(EventType.DEBUG_INFO, bubbles, cancelable);
			
			text = info;
			debugType = type;
			showColor = color;
		}
		
		override public function clone():Event
		{
			return new DebugInfoEvent(text,debugType,showColor);
		}
	}
}