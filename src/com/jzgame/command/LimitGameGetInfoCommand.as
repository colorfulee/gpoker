package com.jzgame.command
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.util.WindowFactory;
	import com.spellife.util.TimerManager;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class LimitGameGetInfoCommand extends Command
	{
		/***********
		 * name:    HandleDailyBonusCommand
		 * data:    Jun 23, 2015
		 * author:  jim
		 * des:     日常奖励数据处理中心
		 ***********/
		[Inject]
		public var event:HttpResponseEvent;
		
		public function LimitGameGetInfoCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var result:Object = event.result;
			
			if(result)
			{
				var start_time:Number=Number(result["start_time"]);
				var end_time:Number=Number(result["end_time"]);
				 
				//trace("开始时间："+TimerManager.getGenTimerFormat(start_time)+"//"+"结束时间："+TimerManager.getGenTimerFormat(end_time));
				if(TimerManager.getCurrentSysTime()>=start_time && TimerManager.getCurrentSysTime()<=end_time)
				{
					WindowFactory.addPopUpWindow(WindowFactory.TIME_LIMIT_PLAY_WINDOW,null,result);
				}
				else
				{
					WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("402807"));
				}
			}
		}
	}
}