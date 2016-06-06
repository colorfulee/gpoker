package com.jzgame.command
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.MTTAttendModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class MTTListUpdateCommand extends Command
	{
		/*auther     :jim
		* file       :MTTListUpdateCommand.as
		* date       :Apr 21, 2015
		* description:
		*/
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var attendModel:MTTAttendModel;
		[Inject]
		public var gameModel:GameModel;
		public function MTTListUpdateCommand()
		{
			super();
		}
		/**
		 * 更新mtt列表状态 
		 * @param e
		 * 
		 */	
		override public function execute():void
		{
			if(event.result)
			{
				Tracer.info("MTTListUpdateCommand::::");
				attendModel.updateMTTList(event.result);
			}
		}
	}
}