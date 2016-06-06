package com.jzgame.common.model.message
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HttpReceivedMessageProcessCommand extends Command
	{
		/*auther     :jim
		* file       :HttpReceivedMessageProcessCommand.as
		* date       :Dec 4, 2014
		* description:
		*/
		[Inject]
		public var event:HttpResponseEvent;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		[Inject]
		public var messageProxy:MessageProxy;
		
		public function HttpReceivedMessageProcessCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var error:uint = event.data["e"];
			if(error > 0)
			{
				return;
			}
			var result:Object = event.data["r"];
			var uuidList:Array = event.request.data;
			
			for each(var msgId:String in uuidList)
			{
				messageProxy.removeMessage(msgId);
			}
			messageProxy.updateNotify();
		}
	}
}