package com.jzgame.command
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.util.WindowFactory;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ShowPlayerDetailCommand extends Command
	{
		/***********
		 * name:    ShowPlayerDetailCommand
		 * data:    Jun 12, 2015
		 * author:  jim
		 * des:
		 ***********/
		
		[Inject]
		public var event:SimpleEvent;
		[Inject]
		public var gameModel:GameModel;
		
		public function ShowPlayerDetailCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			gameModel.tipUserId = uint(event.data);
			
			WindowFactory.addPopUpWindow(WindowFactory.PLAYER_INFO_WINDOW,null,1);
		}
	}
}