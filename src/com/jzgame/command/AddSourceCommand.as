package com.jzgame.command
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.events.AddSourceEvent;
	import com.jzgame.util.ExternalCenter;
	import com.jzgame.util.WindowFactory;
	
	import flash.display.StageDisplayState;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class AddSourceCommand extends Command
	{
		/***********
		 * name:   AddSourceCommand
		 * data:   Jun 5, 2015
		 * author: jim
		 * des:    添加金币或者钱币
		 ***********/
		[Inject]
		public var event:AddSourceEvent;
		
		public function AddSourceCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if(event.displayState == StageDisplayState.FULL_SCREEN || event.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE)
			{
				WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("402204"));
			}else
			{
				ExternalCenter.addChip(event.addChip);
			}
		}
	}
}