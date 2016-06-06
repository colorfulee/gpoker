package com.jzgame.command.safeBox
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class SafeBoxLoginCommand extends Command
	{
		/***********
		 * name:    SafeBoxLoginCommand
		 * data:    Aug 12, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var userModel:UserModel;
		public function SafeBoxLoginCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if(event.result)
			{
				//缓存密码
				userModel.safePassward = event.request.data[0];
				WindowFactory.addPopUpWindow(WindowFactory.SAFE_BOX_WINDOW);
			}else
			{
				WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("402359"));
			}
		}
	}
}