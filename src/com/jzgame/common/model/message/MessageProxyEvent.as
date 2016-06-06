package com.jzgame.common.model.message
{
import flash.events.Event;
/**
 * 
 * @author Rakuten
 * 
 */
public class MessageProxyEvent extends Event
{
	public static var UPDATE_MESSAGE:String = "updateMessage";
	public var message:Array;
    public function MessageProxyEvent(type:String, messageData:Array)
    {
        super(type, bubbles, cancelable);
		message = messageData;
    }

    override public function clone():Event
    {
        var cloneEvent:MessageProxyEvent = new MessageProxyEvent(type, message);
        return cloneEvent;
    }
}
}
