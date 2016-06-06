package com.jzgame.command
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.events.OperateWindowEvent;
	import com.jzgame.model.WindowModel;
	import com.spellife.display.PopUpWindow;
	import com.spellife.display.PopUpWindowManager;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class OperateWindowCommand extends Command
	{
		[Inject]
		public var event:OperateWindowEvent;
		
		[Inject]
		public var model:WindowModel;
		
//		[Inject]
//		public var movieClip:MovieClipModel;
		
//		[Inject]
//		public var config:ConfigModel;
		
		public function OperateWindowCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var win:PopUpWindow = model.getWindow(event.windowName);

			if(!win)
			{
				win = model.createWindow(event.windowName);
				if (Configure.gameConfig.getSourceItemById(this.event.windowName))
				{
					var path:String =  model.findPathByName(event.windowName);
					win.bindView(ResManager.getMovieClipInLoaderInfoByName(model.findExportClassByName(this.event.windowName), path));
				}
				
				model.insert(event.windowName,win);
			}
			
			switch(event.operateType)
			{
				case OperateWindowEvent.HIDE:
					model.removeWindow(event.windowName);
					PopUpWindowManager.removePopUpWindow(win);
					break;
				case OperateWindowEvent.SHOW:
					PopUpWindowManager.addPopUpWindow(win,WindowModel.popUpContainer);
					break;
			}
		}
	}
}