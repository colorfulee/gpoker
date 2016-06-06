package com.jzgame.modules.userInfo
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.NumUtil;
	import com.jzgame.util.WindowFactory;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class UserInfoViewMediator extends StarlingMediator
	{
		/***********
		 * name:    UserInfoViewMediator
		 * data:    Nov 16, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:UserInfoView;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var gameModel:GameModel;
		public function UserInfoViewMediator()
		{
			super();
		}
		
		override public function destroy():void
		{
			view.face.removeEventListener(TouchEvent.TOUCH, showDetailHandler);
			SignalCenter.onUpdateUserInfo.remove(onUpdateUserInfo);
		}
		
		override public function initialize():void
		{
			view.userName.text = userModel.myInfo.uNickName;
			
			onUpdateUserInfo();
			
			SignalCenter.onUpdateUserInfo.add(onUpdateUserInfo);
			
			view.face.addEventListener(TouchEvent.TOUCH, showDetailHandler);
		}
		/**
		 * 更新个人信息 
		 * 
		 */
		private function onUpdateUserInfo():void
		{
			view.userName.text = userModel.myInfo.uNickName;
			view.moneyLable.text = LangManager.getText("500001",NumUtil.n2c(userModel.myInfo.uMoney.toNumber()));
			view.goldLable.text = LangManager.getText("500001",NumUtil.n2c(userModel.myInfo.uGold));
			view.setFace((userModel.myInfo.uFB_ID));
		}
		/**
		 * 显示个人详细信息 
		 * @param e
		 * 
		 */		
		private function showDetailHandler(e:TouchEvent):void
		{
			if(e.getTouch(view.face,TouchPhase.ENDED))
			{
				gameModel.tipUserId = userModel.myInfo.userId;
				WindowFactory.addPopUpWindow(WindowFactory.PLAYER_INFO_WINDOW);
			}
		}
	}
}