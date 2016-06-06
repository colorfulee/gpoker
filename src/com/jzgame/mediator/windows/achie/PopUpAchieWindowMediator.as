package com.jzgame.mediator.windows.achie
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.achiement.AchiementProxy;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.UserModel;
	import com.jzgame.view.windows.achie.PopUpAchieWindow;
	
	import flash.events.Event;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class PopUpAchieWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpAchieWindowMediator
		 * data:    Dec 14, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpAchieWindow;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var achie:AchiementProxy;
		public function PopUpAchieWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.tabBar.addEventListener(starling.events.Event.CHANGE, tabBarChange);
//			HttpSendProxy.getPlayerSummary(userModel.myInfo.userId.toString());
			HttpSendProxy.sendAchieRequest(userModel.myInfo.userId.toString());
//			addContextListener(MessageType.PLAYER_SUMMARY,freshSummary,HttpResponseEvent);
			addContextListener(EventType.UPDATE_ACHIE,updateAchievemnt);
		}
		
		override public function destroy():void
		{
			view.tabBar.removeEventListener(starling.events.Event.CHANGE, tabBarChange);
			view.dispose();
		}
		
		private function tabBarChange(e:starling.events.Event):void
		{
			view.setList(Configure.achievementConfig.getList(view.tabBar.selectedIndex + 1,0));
		}
		
		private function updateAchievemnt(e:flash.events.Event):void
		{
			var m:String = AssetsCenter.LEFT + Configure.achievementConfig.getLength(0,0);
			var mm:String = AssetsCenter.LEFT + Configure.achievementConfig.getLength(1,0);
			var mmm:String = AssetsCenter.LEFT + Configure.achievementConfig.getLength(2,0);
			var mmmm:String = AssetsCenter.LEFT + Configure.achievementConfig.getLength(3,0);
			var total:String = (achie.goldP+achie.silP+achie.treP ) + m;
			
			view.tabBar.selectedIndex = 0;
			view.total.text = LangManager.getText('500247') + total;
//			view.title.updateProInfo(total,achie.first + mm,achie.second + mmm,achie.third + mmmm);
//			view.recentAchievementView.setRank(userModel.playerDetail.achievement_rank);
//			view.recentAchievementView.setList(Configure.achievementConfig.getRecentThreeAchievements());
//			view.recentAchievementView.setPrize(achie.goldP,achie.silP,achie.treP,Configure.achievementConfig.getLength(0,0));
//			
//			view.recentAchievementView.progress.setLabel(total);
		}
	}
}