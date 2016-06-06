package com.jzgame.common.model.achiement
{
import flash.events.Event;
/**
 * 
 * @author Rakuten
 * 
 */
public class AchiementProxyEvent extends Event
{
	static public const INIT_ACHIEMENT_LIST:String = "initAchiementList";
    public function AchiementProxyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
    {
        super(type, bubbles, cancelable);
    }
	
	override public function clone():Event
	{
		var cloneEvent:AchiementProxyEvent = 
			new AchiementProxyEvent(type, bubbles, cancelable);
		return cloneEvent;
	}
}
}
