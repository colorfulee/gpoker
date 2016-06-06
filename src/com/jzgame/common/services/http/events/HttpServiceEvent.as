package com.jzgame.common.services.http.events
{
	import flash.events.Event;
	/**
	 * 
	 * @author Rakuten
	 * 
	 */	
	public class HttpServiceEvent extends Event
	{
		public function HttpServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}