package com.jzgame.command.safeBox
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.util.WindowFactory;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class SafeBoxSetPassBackCommand extends Command
	{
		/***********
		 * name:    SafeBoxSetPassBackCommand
		 * data:    Jan 7, 2016
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var event:HttpResponseEvent;
		public function SafeBoxSetPassBackCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if(event.result)
			{
				WindowFactory.addPopUpWindow(WindowFactory.SAFE_BOX_WINDOW);
			}
		}
	}
}