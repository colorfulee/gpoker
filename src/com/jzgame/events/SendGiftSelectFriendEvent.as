package com.jzgame.events
{
	import flash.events.Event;
	
	public class SendGiftSelectFriendEvent extends Event
	{
		/*auther     :jim
		* file       :SendGiftSelectFriendEvent.as
		* date       :Apr 3, 2015
		* description:
		*/
		public static var CHANGE:String  =  "CHANGE";
		private var _select:Boolean;
		private var _row:uint;
		private var _column:uint;
		public function SendGiftSelectFriendEvent(row:uint,column:uint,select:Boolean)
		{
			super(CHANGE, bubbles, cancelable);
			
			_row = row;
			_column = column;
			_select = select;
		}
		
		public function get select():Boolean
		{
			return _select;
		}

		public function get column():uint
		{
			return _column;
		}
		
		public function get row():uint
		{
			return _row;
		}

		override public function clone():Event
		{
			return new SendGiftSelectFriendEvent(_row,_column,_select);
		}
	}
}