package com.jzgame.common.services.socket
{
import flash.events.Event;
/**
 * 
 * @author Rakuten
 * 
 */
public class SocketServiceEvent extends Event
{
	public static var SOCKET_CLOSE:String = "SOCKET_CLOSE";
	public static var SOCKET_CONNECTED:String = "SOCKET_CONNECTED";
	public static var SOCKET_RECEIVED:String = "SOCKET_RECEIVED";
	public static var SOCKET_ERROR:String = "SOCKET_ERROR";
//	public static var SOCKET_GET_SOMETHING:String = "SOCKET_GET_SOMETHING";
	
    public function SocketServiceEvent(type:String, data_:Object = null)
    {
        super(type);
		data = data_;
    }
    public var data:Object;

    override public function clone():Event
    {
        return new SocketServiceEvent(type, data);
    }
}
}
