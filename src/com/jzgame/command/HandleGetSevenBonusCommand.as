package com.jzgame.command
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.model.DailyModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandleGetSevenBonusCommand extends Command
	{
		/***********
		 * name:    HandleGetSevenBonusCommand
		 * data:    Jul 24, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var dailyModel:DailyModel;
		[Inject]
		public var userModel:UserModel;
		public function HandleGetSevenBonusCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//如果存在奖励
			if(dailyModel.dailyBonus.length >0 || dailyModel.totalBonus.length > 0)
			{
				userModel.myInfo.todayLoginBonus = 2;
				WindowFactory.addPopUpWindow(WindowFactory.SEVEN_LOGIN_REWARD_WINDOW,null,dailyModel.dailyBonus,dailyModel.totalBonus);
			}
		}
	}
}