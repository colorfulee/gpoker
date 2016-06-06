package com.jzgame.common.model.connect
{
import flash.events.Event;

/**
 * 连接Socket服务器时的连接事件(非socket状态)
 * 在ConnectEvent.CONNECT事件被派发后，即开始连接Socket服务器
 * 然后，Socket会派发相应的事件
 *
 * @author austin
 *
 */
public class ConnectEvent extends Event
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     * 连接Socket服务器
     */
    static public const CONNECT:String = "connect";

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 构造一个<code>ConnectEvent</code>实例.
     *
     */
    public function ConnectEvent(type:String,
                                 bubbles:Boolean=false, 
                                 cancelable:Boolean=false)
    {
        super(type, bubbles, cancelable);
    }

    public var ip:String;
    public var port:uint;

    override public function clone():Event
    {
        var evt:ConnectEvent = new ConnectEvent(type, bubbles, cancelable);
        evt.ip = ip;
        evt.port = port;
        return evt;
    }
}
}
