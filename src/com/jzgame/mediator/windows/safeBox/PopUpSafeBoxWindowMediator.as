package com.jzgame.mediator.windows.safeBox
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.model.BuffModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.safeBox.PopUpSafeBoxWindow;
	import com.jzgame.view.windows.safeBox.SafeBoxGetView;
	import com.jzgame.view.windows.safeBox.SafeBoxSaveView;
	import com.jzgame.view.windows.safeBox.SafeInfoView;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class PopUpSafeBoxWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpSafeBoxWindowMediator
		 * data:    Jan 5, 2016
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpSafeBoxWindow;
		[Inject]
		public var buffModel:BuffModel;
		[Inject]
		public var userModel:UserModel;
		public function PopUpSafeBoxWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.tabBar.addEventListener(Event.CHANGE, updateTabBarIndex);
			view.sure.addEventListener(Event.TRIGGERED, suerHandler);
			
			view.tabBar.selectedIndex = 0;
		}
		
		override public function destroy():void
		{
			view.sure.removeEventListener(Event.TRIGGERED, suerHandler);
			view.tabBar.removeEventListener(Event.CHANGE, updateTabBarIndex);
		}
		
		private function updateTabBarIndex(e:Event):void
		{
			if(view.container.numChildren > 0)
			{
				view.container.getChildAt(0).removeFromParent(true);
			}
			switch(view.tabBar.selectedIndex)
			{
				case 0:
					var saveView:SafeBoxSaveView = new SafeBoxSaveView;
					saveView.x = 45;
					saveView.y = 145;
					view.container.addChild(saveView);
					break;
				case 1:
					var getView:SafeBoxGetView = new SafeBoxGetView;
					getView.x = 45;
					getView.y = 145;
					view.container.addChild(getView);
					break;
				case 2:
					var infoView:SafeInfoView = new SafeInfoView;
					infoView.x = 45;
					infoView.y = 145;
					view.container.addChild(infoView);
					break;
			}
		}
		/**
		 * 确定 
		 * @param e
		 * 
		 */		
		private function suerHandler(e:Event):void
		{
			switch(view.tabBar.selectedIndex)
			{
				case 0:
					var saveView:SafeBoxSaveView = view.container.getChildAt(0) as SafeBoxSaveView;
					var money:Number = saveView.getMoney();
//					if(view.getSaveMoney > userModel.myInfo.uMoney.toNumber())
//					{
//						WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("402358"));
//						return;
//					}
					
					if(money == 0)
					{
						WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("402360"));
						return;
					}
					
					if(!buffModel.isVIP())
					{
						WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("402362"));
						return;
					}
					
					HttpSendProxy.sendSafeBoxSaveRequest(userModel.safePassward,money);
					view.closeWindow();
					break;
				case 1:
					var getView:SafeBoxGetView = view.container.getChildAt(0) as SafeBoxGetView;
					var getmoney:Number = getView.getMoney();
					if(getmoney > userModel.myInfo.chip_box)
					{
						WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("402357"));
						return;
					}
					
					if(getmoney == 0)
					{
						WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("402360"));
						return;
					}
					
					HttpSendProxy.sendSafeBoxGetBackRequest(userModel.safePassward,getmoney);
					view.closeWindow();
					break;
				case 2:
					var infoView:SafeInfoView = view.container.getChildAt(0) as SafeInfoView;
					var old:String = infoView.getOldPsd1();
					var old2:String = infoView.getOldPsd2();
					var n:String = infoView.getNewPsd();
					infoView.error = '';
					if(old != old2 )
					{
						infoView.error = LangManager.getText("500254");
//						WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("500255"));
						return ;
					}
					
					if(old != userModel.safePassward )
					{
						infoView.error = LangManager.getText("500254");
//						WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("500255"));
						return ;
					}
//					
//					if(old == n )
//					{
//						WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("500254"));
//						return ;
//					}
					
					if(n.length<6)
					{
						infoView.error = LangManager.getText("500256");
//						WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("500254"));
						return ;
					}
					
					HttpSendProxy.sendSafeBoxResetPsdRequest(userModel.safePassward,n);
					view.closeWindow();
					break;
			}
		}
	}
}