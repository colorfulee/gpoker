package com.jzgame.mediator.windows.userInfo
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.common.model.gameFriends.GameFriendsProxy;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.InterEventUtil;
	import com.jzgame.enmu.SystemColor;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.NumUtil;
	import com.jzgame.view.windows.userInfo.PlayerInfoInGameView;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.events.Event;
	import flash.text.TextFormatAlign;
	
	import feathers.data.ListCollection;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class PopUpPlayerInfoInGameViewMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpPlayerInfoInGameViewMediator
		 * data:    Dec 17, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PlayerInfoInGameView;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var friends:GameFriendsProxy;
		public function PopUpPlayerInfoInGameViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(EventType.UPDATE_USER_SUMMARY,updateInfo);
			view.addFriend.addEventListener(starling.events.Event.TRIGGERED, addFriendHandler);
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
			view.addFriend.removeEventListener(starling.events.Event.TRIGGERED, addFriendHandler);
			removeContextListener(EventType.UPDATE_USER_SUMMARY,updateInfo);
			view.removeEventListener(starling.events.Event.COMPLETE, startNet);
		}
		
		private function startNet(e:starling.events.Event):void
		{
			HttpSendProxy.getPlayerSummary(view.userId.toString());
		}
		
		/**
		 * 更新信息
		 * @param e
		 * 
		 */		
		private function updateInfo(e:flash.events.Event):void
		{
			initInfo();
		}
		
		/**
		 * 初始化个人信息 
		 * 
		 */		
		private function initInfo():void
		{
			view.userName.text = userModel.playerDetail.name;
			view.moneyLable.text = LangManager.getText("500001",NumUtil.n2c(userModel.playerDetail.chip));
			view.face.setData(userModel.playerDetail.fb_id);
			
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
			
			var total:Number = userModel.playerDetail.rounds.split(AssetsCenter.LEFT)[1];
			var rounds:Number = userModel.playerDetail.rounds.split(AssetsCenter.LEFT)[0];
			
			view.maxChip.text = LangManager.getText("300837") + ":" +userModel.playerDetail.chip_max.toString();
			view.maxWin.text = LangManager.getText("300838")+ ":" + String(userModel.playerDetail.max_win);
			view.maxRound.text = LangManager.getText("300901")+ ":" + total;
			view.winRate.text = LangManager.getText("300841")+ ":" +(Math.floor(rounds * 100 / total) + "%");
			view.maxHandList.dataProvider = new ListCollection(userModel.playerDetail.max_card.split(","));
			view.maxHand.text = LangManager.getText('300839');
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
			
			if(friends.getUserById(userModel.playerDetail.uid))
			{
				view.addFriend.label = LangManager.getText('500232');
			}else
			{
				view.addFriend.label = LangManager.getText('500231');
			}
		}
		/**
		 * 添加好友 
		 * @param e
		 */		
		private function addFriendHandler(e:starling.events.Event):void
		{
			if(friends.getUserById(userModel.playerDetail.uid))
			{
				HttpSendProxy.deleteFriend(view.userId);
			}else
			{
				HttpSendProxy.addFriend(view.userId);
				NetSendProxy.interEvent(InterEventUtil.ADD_FRIEND,userModel.myInfo.uSeatIndex,view.seat);
			}
			view.closeWindow();
		}
	}
}