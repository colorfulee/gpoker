package com.jzgame.mediator.windows.userInfo
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.achiement.AchiementProxy;
	import com.jzgame.common.model.gameFriends.GameFriendsProxy;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.vo.GameFriendVO;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.SystemColor;
	import com.jzgame.model.BuffModel;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.NumUtil;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.userInfo.MttInfoView;
	import com.jzgame.view.windows.userInfo.PopUpUserDetailWindow;
	import com.jzgame.view.windows.userInfo.RingInfoView;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.util.HtmlTransCenter;
	import com.spellife.util.TimerManager;
	
	import flash.events.Event;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	
	public class PopUpUserDetailWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpUserInfoWindowMediator
		 * data:    Dec 4, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpUserDetailWindow;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var buffModel:BuffModel;
		[Inject]
		public var gameFriendsProxy:GameFriendsProxy;
		[Inject]
		public var achie:AchiementProxy;
		public function PopUpUserDetailWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(EventType.UPDATE_USER_SUMMARY,updateInfo);
			addContextListener(EventType.UPDATE_ACHIE,updateAchievemnt);
			
			view.tabBar.addEventListener(starling.events.Event.CHANGE, updateView);
			view.vipBtn.addEventListener(starling.events.Event.TRIGGERED, gotoVip);
			view.recentAchie.addEventListener(starling.events.Event.TRIGGERED, achieveHandler);
			view.round.addEventListener(starling.events.Event.TRIGGERED, roundHandler);
			view.safeBox.addEventListener(starling.events.Event.TRIGGERED, safeHandler);
			view.viewPack.addEventListener(starling.events.Event.TRIGGERED, packHandler);
			
			
			if(view.motionEffect)
			{
				view.addEventListener(starling.events.Event.COMPLETE, startNet);
			}else
			{
				startNet(null);
			}
		}
		
		override public function destroy():void
		{
			removeContextListener(EventType.UPDATE_USER_SUMMARY,updateInfo);
			removeContextListener(EventType.UPDATE_ACHIE,updateAchievemnt);
			
			view.viewPack.removeEventListener(starling.events.Event.TRIGGERED, packHandler);
			view.safeBox.removeEventListener(starling.events.Event.TRIGGERED, safeHandler);
			view.tabBar.removeEventListener(starling.events.Event.CHANGE, updateView);
			view.recentAchie.removeEventListener(starling.events.Event.TRIGGERED, achieveHandler);
			view.round.removeEventListener(starling.events.Event.TRIGGERED, roundHandler);
			view.vipBtn.removeEventListener(starling.events.Event.TRIGGERED, gotoVip);
		}
		
		private function startNet(e:starling.events.Event):void
		{
			HttpSendProxy.getPlayerSummary(gameModel.tipUserId.toString());
		}
		/**
		 * 显示保险箱 
		 * @param e
		 * 
		 */		
		private function safeHandler(e:starling.events.Event):void
		{
			if(buffModel.isVIP())
			{
				//设置了密码
				if(userModel.myInfo.isset_box_pwd == 1)
				{
					WindowFactory.addPopUpWindow(WindowFactory.SAFE_BOX_LOGIN_WINDOW);
				}else
				{
					WindowFactory.addPopUpWindow(WindowFactory.SAFE_BOX_PASS_WINDOW);
					return;
				}
			}else
			{
				Alert.show((LangManager.getText("402354")),"error!",new ListCollection([{label:LangManager.getText('500243'),triggered:showStore}]))
//				WindowFactory.showAlert(LangManager.getText("402354"),Alert.OK + Alert.CANCEL,function ():void {WindowFactory.addPopUpWindow(WindowFactory.STORE_WINDOW,null,3)});
			}
		}
		/**
		 * 显示商店 
		 * 
		 */		
		private function showStore():void
		{
			WindowFactory.addPopUpWindow(WindowFactory.STORE_WINDOW);
		}
		/**
		 * 显示背包 
		 * @param e
		 * 
		 */		
		private function packHandler(e:starling.events.Event):void
		{
			WindowFactory.addPopUpWindow(WindowFactory.PACK_WINDOW);
		}
		/**
		 * 成就回调 
		 * @param e
		 * 
		 */		
		private function updateAchievemnt(e:flash.events.Event):void
		{
			initInfo();
		}
		/**
		 * 牌局回顾 
		 * @param e
		 * 
		 */		
		private function roundHandler(e:starling.events.Event):void
		{
			PopUpWindowManager.centerPopUpWindow(WindowFactory.addPopUpWindow(WindowFactory.ROUND_WINDOW) as DisplayObject);
		}
		/**
		 * 更新信息
		 * @param e
		 * 
		 */		
		private function updateInfo(e:flash.events.Event):void
		{
			//获取成就
			HttpSendProxy.sendAchieRequest(gameModel.tipUserId.toString());
		}
		/**
		 * 查看成就
		 * @param e
		 * 
		 */		
		private function achieveHandler(e:starling.events.Event):void
		{
			WindowFactory.addPopUpWindow(WindowFactory.ACHIEVE_WINDOW);
		}
		/**
		 * 初始化个人信息 
		 * 
		 */		
		private function initInfo():void
		{
			view.tabBar.selectedIndex = 0;
			
			view.userName.text = userModel.playerDetail.name;
			view.moneyLable.text = LangManager.getText("500001",NumUtil.n2c(userModel.playerDetail.chip));
			view.goldLable.text = LangManager.getText("500001",NumUtil.n2c(userModel.playerDetail.coin));
			view.face.setData(userModel.playerDetail.fb_id);
			
			view.playerId.text = LangManager.getText("300830") + userModel.playerDetail.uid;
			view.lv.text = LangManager.getText("500203") + userModel.playerDetail.level;
			
			var level:uint = Configure.playerLevel.getLevelByExp(userModel.myInfo.uPendingExp);
			var exp:Number = Configure.playerLevel.getExpByLevel(level);
			var nextExp:Number = Configure.playerLevel.getExpByLevel(level + 1);
			//到达顶级
			if(nextExp == 0)
			{
				view.expProgress.value = 1;
				view.exp.text = HtmlTransCenter.getHtmlStr(NumUtil.n2c(userModel.myInfo.uPendingExp)+"/"+NumUtil.n2c(userModel.myInfo.uPendingExp),SystemColor.STR_WHITE,16,TextFormatAlign.CENTER);
			}else
			{
				view.exp.text = HtmlTransCenter.getHtmlStr(NumUtil.n2c(userModel.myInfo.uPendingExp)+"/"+NumUtil.n2c(nextExp),SystemColor.STR_WHITE,16,"",TextFormatAlign.CENTER);
				view.expProgress.value = 1 - (nextExp - userModel.myInfo.uPendingExp) / (nextExp-exp);
			}
			view.recentAchie.dataProvider = new ListCollection(Configure.achievementConfig.getRecentThreeAchievements());
			//if is mine
			if(uint(userModel.playerDetail.uid) == userModel.myInfo.userId)
			{
				view.round.visible = true;	
				view.viewPack.visible = true;
				view.addFriend.visible = false;
				view.delFriend.visible = false;
			}else
			{
				view.round.visible = false;	
				view.viewPack.visible = false;	
				var temp:GameFriendVO = gameFriendsProxy.getUserById(userModel.playerDetail.uid);
				
				if(temp)
				{
					view.delFriend.visible = true;
					view.addFriend.visible = false;
				}else
				{
					view.delFriend.visible = false;
					view.addFriend.visible = true;
				}
			}
			
			var m:String = AssetsCenter.LEFT + Configure.achievementConfig.getLength(0,0);
			var mm:String = AssetsCenter.LEFT + Configure.achievementConfig.getLength(1,0);
			var mmm:String = AssetsCenter.LEFT + Configure.achievementConfig.getLength(2,0);
			var mmmm:String = AssetsCenter.LEFT + Configure.achievementConfig.getLength(3,0);
			var total:String = (achie.goldP+achie.silP+achie.treP ) + m;
			
			view.myAchie.text = HtmlTransCenter.getFontStr(LangManager.getText('500255'),'777a9d',18) + HtmlTransCenter.getFontStr(total,'804064',18);
			
//			view.score.text = userModel.playerDetail.score.toString();
//			
//			view.playerLogin.recentLogin.text = TimerManager.getTimerFormat(userModel.playerDetail.last_login);
//			view.playerLogin.firstLogin.text = TimerManager.getTimerFormat(userModel.playerDetail.first_login);
//			view.playerLogin.buddy.text = String(userModel.playerDetail.friends_total);
//			
//			view.playerScore.chip.text = userModel.playerDetail.chip_max.toString();;
//			view.playerScore.big.text = String(userModel.playerDetail.max_win);
//			
//			view.playerScore.best.text = CardInfoUtil.praseMaxCards(userModel.playerDetail.max_card);
//			view.playerScore.wins.text = String(userModel.playerDetail.rounds);
//			var total:Number = userModel.playerDetail.rounds.split(AssetsCenter.LEFT)[1];
//			var rounds:Number = userModel.playerDetail.rounds.split(AssetsCenter.LEFT)[0];
//			view.playerScore.winning.text = (Math.floor(rounds * 100 / total) + "%");
//			view.playerScore.champions.text = (userModel.playerDetail.champions);
//			
//			view.playerRankArea.title.text = "LV"+userModel.playerDetail.level+" "+ Configure.playerLevel.getTitleByExp(userModel.myInfo.uPendingExp);
//			view.playerRankArea.chip.text = LangManager.getText("300831")+" "+NumUtil.n2c(userModel.playerDetail.chip);
//			view.playerRankArea.achie.text = LangManager.getText("300832")+" "+(achie.goldP+achie.silP + achie.treP);
//			
//			view.playerRankArea.titleRank.text = LangManager.getText("300833")+" "+UserProxy.checkRank(userModel.playerDetail.level_rank);
//			view.playerRankArea.chipRank.text = LangManager.getText("300833")+" "+UserProxy.checkRank(userModel.playerDetail.chip_rank);
//			view.playerRankArea.achieRank.text = LangManager.getText("300833")+" "+UserProxy.checkRank(userModel.playerDetail.achievement_rank);
			
			if(userModel.playerDetail.vip_level > 0)
			{
				view.vipBtn.defaultSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_vip1"));
				view.vipBtn.downSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_vip2"));
				view.vipBtn.isEnabled = true;
			}else
			{
				view.vipBtn.disabledSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_vip_gray1"));
				view.vipBtn.isEnabled = false;
			}
			
			view.recentAchie.dataProvider = new ListCollection(Configure.achievementConfig.getRecentThreeAchievements());
		}
		/**
		 * 更新显示 
		 * @param e
		 * 
		 */		
		private function updateView(e:starling.events.Event):void
		{
			if(view.infoContainer.numChildren > 0)
			{
				var temp:DisplayObject = view.infoContainer.removeChildAt(0);
				temp.dispose();
			}
			
			switch(view.tabBar.selectedIndex)
			{
				case 0:
					var ring:RingInfoView = new RingInfoView;
					ring.x = 255;
					ring.y = 170;
					ring.max.text = LangManager.getText("300837") + ":" +userModel.playerDetail.chip_max.toString();
					ring.maxWin.text = LangManager.getText("300838")+ ":" + String(userModel.playerDetail.max_win);
					ring.win.text = LangManager.getText("300840")+ ":" +String(userModel.playerDetail.rounds);
					var total:Number = userModel.playerDetail.rounds.split(AssetsCenter.LEFT)[1];
					var rounds:Number = userModel.playerDetail.rounds.split(AssetsCenter.LEFT)[0];
					ring.winRate.text = LangManager.getText("300841")+ ":" +(Math.floor(rounds * 100 / total) + "%");
					ring.champ.text = LangManager.getText("300842") + ":"+(userModel.playerDetail.champions);
					ring.recentLogin.text = LangManager.getText("300844")+ ":" +TimerManager.getTimerFormat(userModel.playerDetail.last_login,'yy/mm/dd');
					ring.firstLogin.text = LangManager.getText("300845")+ ":" +TimerManager.getTimerFormat(userModel.playerDetail.first_login,'yy/mm/dd');
					ring.friends.text = LangManager.getText("300843")+ ":" + String(userModel.playerDetail.friends_total);
					ring.maxHandList.dataProvider = new ListCollection(userModel.playerDetail.max_card.split(","));
					view.infoContainer.addChild(ring);
					
					break;
				case 1:
					var mtt:MttInfoView = new MttInfoView;
					mtt.x = 255;
					mtt.y = 170;
					view.infoContainer.addChild(mtt);
					break;
			}
		}
		/**
		 * 跳转 
		 * @param e
		 * 
		 */		
		private function gotoVip(e:starling.events.Event):void
		{
			WindowFactory.addPopUpWindow(WindowFactory.STORE_WINDOW,null,3);
		}
	}
}