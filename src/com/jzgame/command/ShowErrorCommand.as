package com.jzgame.command
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.model.WindowModel;
	import com.jzgame.util.WindowFactory;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ShowErrorCommand extends Command
	{
		/*auther     :jim
		* file       :ShowErrorCommand.as
		* date       :Nov 26, 2014
		* description:
		*/
		[Inject]
		public var model:WindowModel;
		[Inject]
		public var event:SimpleEvent;
		public function ShowErrorCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var text:String = "";
			if(event.data is Number)
			{
				var type:Number = Number(event.data);
				text = LangManager.getText(String(event.data))
			}else
			{
				text = String(event.data);
			}
			WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,text);
//			var flex:PopUpFlexTipWindow = new PopUpFlexTipWindow;
//			flex.setText(text);
//			PopUpWindowManager.addPopUpWindow(flex,WindowModel.popUpContainer);
		}
	}
}