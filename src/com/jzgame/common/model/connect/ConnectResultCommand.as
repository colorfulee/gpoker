package com.jzgame.common.model.connect
{
import com.jzgame.common.services.socket.SocketServiceEvent;
import com.jzgame.common.utils.SignalCenter;

import flash.events.IEventDispatcher;

import feathers.controls.Alert;
import feathers.data.ListCollection;

import robotlegs.bender.bundles.mvcs.Command;

/**
 * socket连接状态返回后触发 
 * @author Rakuten
 * 
 */
public class ConnectResultCommand extends Command
{
    public function ConnectResultCommand()
    {
        super();
    }
	
	[Inject]
	public var eventDispatcher:IEventDispatcher;
	
	[Inject]
	public var event:SocketServiceEvent;
	
	override public function execute():void
	{
		switch (event.type)
		{
			case SocketServiceEvent.SOCKET_CONNECTED:
			{
				SignalCenter.onConnectComplete.dispatch();
//				eventDispatcher.dispatchEvent(new StateEvent(StateEvent.ACTION, StateMachineConst.ACTION_LINKED));
				break;
			}
			case SocketServiceEvent.SOCKET_CLOSE:
			{
//				Alert.show("connect close!","bad",new ListCollection(
//					[
//						{ label: "OK"}
//					]));
//				eventDispatcher.dispatchEvent(new StateEvent(StateEvent.ACTION, StateMachineConst.ACTION_CLOSE));
				break;
			}
			case SocketServiceEvent.SOCKET_ERROR:
			{
				Alert.show("connect error!","error",new ListCollection(
					[
						{ label: "OK"}
					]));
//				eventDispatcher.dispatchEvent(new StateEvent(StateEvent.ACTION, StateMachineConst.ACTION_ERROR));
				break;
			}
		}
	}
}
}
