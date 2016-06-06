package com.jzgame.events
{
	import flash.events.Event;
	
	public class HandleJoinMTTEvent extends Event
	{
		/*auther     :jim
		* file       :HandleJoinMTTEvent.as
		* date       :Apr 22, 2015
		* description:
		*/
		public static var JOIN:String = "HandleJoinMTTEvent_JOIN";
		public var joinMatchId:String;
		public var targetUid:uint;
		public var obv:Boolean = false;
		public var joinType:uint = 11;
		public function HandleJoinMTTEvent(matchId:String="",ob:Boolean = false,targetId:uint = 0)
		{
			super(JOIN, bubbles, cancelable);
			joinMatchId = matchId;
			targetUid = targetId;
			obv = ob;
		}
		
		override public function clone():Event
		{
			return new HandleJoinMTTEvent(joinMatchId,obv,targetUid);
		}
	}
}