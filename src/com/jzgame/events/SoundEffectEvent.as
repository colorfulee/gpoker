package com.jzgame.events
{
	import flash.events.Event;
	
	public class SoundEffectEvent extends Event
	{
		/*auther     :jim
		* file       :SoundEffectEvent.as
		* date       :Apr 7, 2015
		* description:
		*/
		public static var PLAY:String = "PLAY";
		
		private var _path:String;
		public function SoundEffectEvent(path:String)
		{
			super(PLAY, bubbles, cancelable);
			
			_path = path ;;
		}
		
		public function get path():String
		{
			return (_path);
		}

//		public function set path(value:String):void
//		{
//			_path = value;
//		}

		override public function clone():Event
		{
			return new SoundEffectEvent(_path);
		}
	}
}