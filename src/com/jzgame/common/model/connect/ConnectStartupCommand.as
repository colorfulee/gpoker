package com.jzgame.common.model.connect
{
import com.jzgame.common.services.socket.SocketServiceEvent;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
/**
 * 
 * @author Rakuten
 * 
 */
public class ConnectStartupCommand extends Command
{
    public function ConnectStartupCommand()
    {
        super();
    }
	
	[Inject]
	public var commandMap:IEventCommandMap;
	
	override public function execute():void
	{
		commandMap.map(ConnectEvent.CONNECT).toCommand(ConnectCommand);
		
		commandMap.map(SocketServiceEvent.SOCKET_CONNECTED).toCommand(ConnectResultCommand);
		commandMap.map(SocketServiceEvent.SOCKET_CLOSE).toCommand(ConnectResultCommand);
		commandMap.map(SocketServiceEvent.SOCKET_ERROR).toCommand(ConnectResultCommand);
		
	}
}
}
