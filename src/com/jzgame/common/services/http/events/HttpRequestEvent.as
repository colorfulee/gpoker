package com.jzgame.common.services.http.events
{
import com.jzgame.common.services.http.HttpRequest;
import com.jzgame.common.services.http.IHttpRequest;

import flash.events.Event;
/**
 * 
 * @author Rakuten
 * 
 */
public class HttpRequestEvent extends Event
{
    static public const HTTP_REQUEST:String = "httpRequest";

    public function HttpRequestEvent(vo:HttpRequest)
    {
        super(HTTP_REQUEST, bubbles, cancelable);
		
		data = vo;
    }

    public var data:IHttpRequest;
	
	override public function clone():Event
	{
		var cloneEvent:HttpRequestEvent = new HttpRequestEvent(data as HttpRequest);
		return cloneEvent;
	}
}
}
