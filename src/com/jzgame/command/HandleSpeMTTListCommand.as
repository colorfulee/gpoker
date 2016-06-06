package com.jzgame.command
{
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.model.SpeMTTAttendModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	
	public class HandleSpeMTTListCommand extends Command
	{
		/***********
		 * name:    HandleSpeMTTListCommand
		 * data:    Oct 30, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var attendModel:SpeMTTAttendModel;
		[Inject]
		public var event:HttpResponseEvent;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		public function HandleSpeMTTListCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			attendModel.updateSpeMTTList(event.result);
			
//			commandMap.unmap( MessageType.SPE_MTT_LIST, HttpResponseEvent).fromCommand(HandleSpeMTTListCommand);
		}
	}
}