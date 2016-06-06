package com.jzgame.mediator.windows.store
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.PackageModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.store.PopUpStoreWindow;
	import com.jzgame.vo.PackageGiftVO;
	import com.jzgame.vo.PackageItemVO;
	import com.jzgame.vo.configs.ShopGiftVO;
	import com.jzgame.vo.configs.ShopItemConfigVO;
	import com.jzgame.vo.configs.ShopVipConfigVO;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.interfaces.display.IPopUpWindow;
	
	import flash.events.Event;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	public class PopUpStoreWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpStoreWindowMediator
		 * data:    Dec 2, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpStoreWindow;
		[Inject]
		public var pack:PackageModel;
		[Inject]
		public var userModel:UserModel;
		public function PopUpStoreWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(EventType.UPDATE_PACK_INFO,refreshPackage);
			SignalCenter.onShopItemTriggered.add(showDeatilHandler);
			view.tabList.addEventListener(starling.events.Event.CHANGE, updateList);
			addContextListener(MessageType.MESSAGE_SHOP_BUY, buySuccess,HttpResponseEvent);
			
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
			view.removeEventListener(starling.events.Event.COMPLETE, startNet);
			removeContextListener(MessageType.MESSAGE_SHOP_BUY, buySuccess,HttpResponseEvent);
			removeContextListener(EventType.UPDATE_PACK_INFO,refreshPackage);
			SignalCenter.onShopItemTriggered.remove(showDeatilHandler);
			view.tabList.removeEventListener(starling.events.Event.CHANGE, updateList);
		}
		
		private function startNet(e:starling.events.Event):void
		{
			HttpSendProxy.sendPackageRequest(userModel.myInfo.userId.toString());
		}
		/**
		 * 强刷当前页 
		 * @param e
		 * 
		 */		
		private function refreshPackage(e:flash.events.Event):void
		{
			view.tabList.selectedIndex = 0;
		}
		/**
		 * 购买成功回调 
		 * @param e
		 * 
		 */		
		private function buySuccess(e:HttpResponseEvent):void
		{
			if(e.result)
			{
				var buyItemId:String = e.request.data[0];
				var sureText:String ;
				var tips:String = LangManager.getText("300706");
				Alert.show(tips,"购买成功",new ListCollection([{label:"ok"}]));
				HttpSendProxy.sendPackageRequest(userModel.myInfo.userId.toString());
			}
//			if(Configure.getShopItemType(buyItemId) == Configure.SHOP_GIFT)
//			{
//				sureText = LangManager.getText("402940");
//				WindowFactory.addPopUpWindow(WindowFactory.ALERT,null,
//					tips,Alert.OK+Alert.CLOSE,alertGIFT,null,sureText);
//			}else
//			{
//				sureText = LangManager.getText("402941");
//				WindowFactory.addPopUpWindow(WindowFactory.ALERT,null,
//					tips,Alert.OK+Alert.CLOSE,alertVIP,null,sureText);
//			}
		}
		
		private function updateList():void
		{
			var list:Array = [];
			switch(view.tabList.selectedIndex)
			{
				case 0:
					list = Configure.shopItemConfig.getItemList();
					break;
				case 1:
					list = Configure.shopGiftConfig.getTyeList(
						0,false,
						false);
					break;
				case 2:
					list = Configure.shopVipConfig.list;
					break;
			}
			view.setData(list);
		}
		/**
		 * 显示购买界面 
		 * @param itemid
		 * 
		 */		
		private function showDeatilHandler(itemid:uint):void
		{
//			view.closeWindow();
			var win:IPopUpWindow;
			switch(view.tabList.selectedIndex)
			{
				case 0:
					var dataa:ShopItemConfigVO = Configure.shopItemConfig.getItemByID(itemid);
					var packkVO:PackageItemVO = pack.getItemById(dataa.itemId);
					win = WindowFactory.addPopUpWindow(WindowFactory.STORE_BUY_WINDOW,null,dataa,packkVO.num + packkVO.acNum,
						userModel.myInfo.uMoney.toNumber(),userModel.myInfo.uGold);
					break;
				case 1:
					var data:ShopGiftVO = Configure.shopGiftConfig.getShopById(itemid.toString());
					var packVO:PackageGiftVO = pack.getGiftById(data.itemId);
					win = WindowFactory.addPopUpWindow(WindowFactory.STORE_BUY_WINDOW,null,data,packVO.num + packVO.acNum,
						userModel.myInfo.uMoney.toNumber(),userModel.myInfo.uGold);
					break;
				case 2:
					var dataaa:ShopVipConfigVO = Configure.shopVipConfig.getItemById(itemid);
					var packkkVO:PackageItemVO = pack.getItemById(dataaa.itemId);
					win = WindowFactory.addPopUpWindow(WindowFactory.STORE_BUY_WINDOW,null,dataaa,packkkVO.num + packkkVO.acNum,
						userModel.myInfo.uMoney.toNumber(),userModel.myInfo.uGold);
					break;
			}
			if(win)
			PopUpWindowManager.centerPopUpWindow(win as DisplayObject);
		}
	}
}