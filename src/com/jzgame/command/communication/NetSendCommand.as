package com.jzgame.command.communication
{
	import com.jzgame.common.services.SocketService;
	import com.jzgame.common.services.protobuff.ProtocalMessage;
	import com.jzgame.common.services.socket.NetPackageUnit;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.events.communication.NetSendEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.UserModel;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;

	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 11, 2013 10:30:07 AM 
	 * @description:
	 */ 
	public class NetSendCommand extends Command
	{
		[Inject]
		public var server:SocketService;
		[Inject]
		public var event:NetSendEvent;
		
		[Inject]
		public var userModel:UserModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		public function NetSendCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if(gameModel.guide) return;
			
			var packetUnit:NetPackageUnit = new NetPackageUnit();
			
			switch(event.messageType)
			{
				case 0:
					packetUnit.getReady();
					server.send(packetUnit);
					break;
				default:
					packetUnit.msgCmd = event.messageType;
					
					var simMessage:ProtocalMessage = new ProtocalMessage();
					simMessage.version = 1;
					simMessage.id = event.messageType;
					simMessage.errorcode = 2;
					simMessage.content = event.content;
					simMessage.writeTo(packetUnit);
					packetUnit.getReady();
					var debugStr:String = userModel.myInfo.uNickName+"向服务器发送数据:"+packetUnit.msgCmd;
					Tracer.debug(debugStr);
					server.send(packetUnit);
					break;
			}
		}
	}
}