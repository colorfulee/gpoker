package com.jzgame.command.safeBox
{
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.util.WindowFactory;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class SafeBoxMoneyChangeCommand extends Command
	{
		/***********
		 * name:    SafeBoxMoneyChangeCommand
		 * data:    Aug 12, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var event:HttpResponseEvent;
		
		public function SafeBoxMoneyChangeCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			switch(event.request.name)
			{
				case MessageType.SAFE_BOX_GET_BACK:
					WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("500258",event.request.data[1]));
					break;
				case MessageType.SAFE_BOX_SAVE:
					WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("500259",event.request.data[1]));
					break;
				case MessageType.SAFE_BOX_RESET_PWD:
					WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText('500257'));
					break;
			}
		}
	}
}