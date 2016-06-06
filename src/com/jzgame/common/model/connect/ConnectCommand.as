package com.jzgame.common.model.connect
{
import com.jzgame.common.services.SocketService;

import flash.events.IEventDispatcher;

import robotlegs.bender.bundles.mvcs.Command;

/**
 * 需要连接Socket时触发
 * @author Rakuten
 * 
 */
public class ConnectCommand extends Command
{
    public function ConnectCommand()
    {
        super();
    }
	
	[Inject]
	public var eventDispatcher:IEventDispatcher;
	
	[Inject]
	public var ip:String;
	[Inject]
	public var port:uint;
	
	[Inject]
	public var socketService:SocketService;
	
	override public function execute():void
	{
		socketService.connect(ip, port);
	}
}
}
