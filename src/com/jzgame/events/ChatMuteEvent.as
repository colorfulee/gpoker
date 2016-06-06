package com.jzgame.events
{
	import flash.events.Event;
	
	public class ChatMuteEvent extends Event
	{
		/*auther     :jim
		* file       :ChatMuteEvent.as
		* date       :Apr 8, 2015
		* description:
		*/
		private var _id:String;
		private var _mute:Boolean;
		public static var CHANGE:String = "CHANGE";
		public function ChatMuteEvent(id:String, mute:Boolean)
		{
			super(CHANGE, bubbles, cancelable);
			
			
			_id = id;
			_mute = mute;
		}
		
		public function get id():String
		{
			return _id;
		}

		public function get mute():Boolean
		{
			return _mute;
		}

		override public function clone():Event
		{
			return new ChatMuteEvent(_id,_mute);
		}
	}
}