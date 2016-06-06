package com.jzgame.common.services.socket
{
import com.netease.protobuf.Message;

import flash.events.Event;
/**
 * 专用于转发收到的网络数据事件 
 * @author Rakuten
 * 
 */
public class SocketDataEvent extends Event
{
	static public const SLOT_MACHINE_RESPONSE:String = "slotMachineResponse"
		
    public function SocketDataEvent(type:String, data:Message)
    {
        super(type);
		this.data = data;
    }
	
	public var data:Message
	
	override public function clone():Event
	{
		var cloneEvent:SocketDataEvent = new SocketDataEvent(type, this.data);
		return cloneEvent;
	}
}
}
