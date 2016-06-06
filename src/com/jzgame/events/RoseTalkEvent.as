package com.jzgame.events
{
	import com.jzgame.enmu.EventType;
	
	import flash.events.Event;
	
	public class RoseTalkEvent extends Event
	{
		/***********
		 * name:    RoseTalkEvent
		 * data:    Jul 22, 2015
		 * author:  jim
		 * des:
		 ***********/
		
		public var talkType:uint = 1;
		public var uName:String = "";
		public var cardWinType:uint = 0;
		public function RoseTalkEvent(ttype:uint,userName:String = "",cardType:uint = 0)
		{
			super(EventType.ROSE_CHECK_TALK, bubbles, cancelable);
			talkType = ttype;
			uName = userName;
			cardWinType = cardType;
		}
		
		override public function clone():Event
		{
			return new RoseTalkEvent(talkType,uName,cardWinType);
		}
	}
}