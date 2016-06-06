package com.jzgame.events.communication
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 11, 2013 10:31:27 AM 
	 * @description:
	 */ 
	import com.jzgame.enmu.NetEventType;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class NetSendEvent extends Event
	{
		public var messageType:uint;
		public var content:ByteArray;
		
		public function NetSendEvent(msgType:uint, content_:ByteArray)
		{
			messageType = msgType;
			content = content_;
			super(NetEventType.SEND, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new NetSendEvent(messageType,content);
		}
	}
}