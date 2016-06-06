package com.jzgame.command
{
	import com.jzgame.common.model.message.MessageProxy;
	import com.jzgame.common.services.http.HttpResponse;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.vo.MessageCenterVO;
	import com.jzgame.util.WindowFactory;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandleProcessMessageCommand extends Command
	{
		/*auther     :jim
		* file       :HandleProcessMessageCommand.as
		* date       :Apr 15, 2015
		* description:
		*/
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		[Inject]
		public var messageProxy:MessageProxy;
		public function HandleProcessMessageCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			WindowFactory.hideCommuWindow();
			
			var responseData:HttpResponse = event.data as HttpResponse;
			var error:uint = responseData["e"];
			if(error > 0)
			{
				return;
			}
			//需要同步的值
			if(responseData.hasOwnProperty("s"))
			{
				var message:Object = responseData["s"]["message"];
				var vo:MessageCenterVO;
				var json:Object;
				var voArr:Array = [];
				for(var uuid:String in message)
				{
					json = message[uuid];
					vo = messageProxy.getMessageById(uuid);
					
					if(vo && vo.status != json.status)
					{
						vo.status = json.status;
					}
				}
				
				messageProxy.updateNotify();
			}
		}
	}
}