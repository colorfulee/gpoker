package com.jzgame.command
{
	import com.jzgame.common.model.achiement.AchiementProxy;
	import com.jzgame.common.utils.ConfigSO;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.util.WindowFactory;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class AchievementCommand extends Command
	{
		/*auther     :jim
		* file       :AchievementCommand.as
		* date       :Dec 9, 2014
		* description:成就命令
		*/
		
		[Inject]
		public var achiementProxy:AchiementProxy;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		public function AchievementCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			Tracer.info("AchievementCommand execute!",achiementProxy.length);
			//			var vo:uint = gameModel.achiementTipList[0];
			if(achiementProxy.length > 0)
			{
				if(!ConfigSO.getInstance().muteBottomHint)
				{
					WindowFactory.addPopUpWindow(WindowFactory.MISSION_COMPLETE_WINDOW);
				}
			}
			//			vo = 702001;
			//			if(vo / 100000 == 9)
			//			{//任务
			//				var taskVO:TaskConfigVO = taskModel.getTaskById(vo.toString());
			//			}else
			//			{//成就
			//				var achievementVO:AchievementVO = achievementModel.getAchievementById(vo.toString());
			//			}
		}
	}
}