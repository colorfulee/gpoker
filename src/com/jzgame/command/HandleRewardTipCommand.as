package com.jzgame.command
{
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindowManager;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandleRewardTipCommand extends Command
	{
		/*auther     :jim
		* file       :HandleRewardTipCommand.as
		* date       :May 7, 2015
		* description:处理序列
		*/
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var eventDis:IEventDispatcher;
		
		public function HandleRewardTipCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if(userModel.rewardsTips.length > 0)
			{
				if(PopUpWindowManager.getWindow(WindowFactory.REWARD_TIP_WINDOW)) return;
				
				var tips:String = userModel.rewardsTips.shift();
				
				WindowFactory.addPopUpWindow(WindowFactory.REWARD_TIP_WINDOW,null,tips,EventType.SHOW_REWARD_TIPS);
				
//				var flex:PopUpFlexTipWindow = new PopUpFlexTipWindow;
//				flex.setText(tips);
//				flex.addCallBack(EventType.SHOW_REWARD_TIPS);
//				PopUpWindowManager.addPopUpWindow(flex,WindowModel.popUpContainer);
			}
		}
	}
}