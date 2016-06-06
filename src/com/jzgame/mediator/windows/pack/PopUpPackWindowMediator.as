package com.jzgame.mediator.windows.pack
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.common.vo.PackageItemConfigVO;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.PackageModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.pack.PopUpPackWindow;
	import com.jzgame.vo.PackageGiftVO;
	import com.jzgame.vo.PackageItemVO;
	import com.jzgame.vo.configs.GiftConfigVO;
	import com.jzgame.vo.configs.VipConfigVO;
	import com.spellife.display.PopUpWindowManager;
	
	import flash.events.Event;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class PopUpPackWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpPackWindowMediator
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpPackWindow;
		
		[Inject]
		public var packageModel:PackageModel;
		[Inject]
		public var gameModel:GameModel;
		public function PopUpPackWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(EventType.UPDATE_PACK_INFO,refreshPackage);
			addContextListener(MessageType.MESSAGE_PACKAGE_USE, useSuccess,HttpResponseEvent);
			SignalCenter.onShowPackItemInfoTriggered.add(showPackItemDetailHandler);
			SignalCenter.onUsePackItem.add(useHandler);
				
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
			removeContextListener(MessageType.MESSAGE_PACKAGE_USE, useSuccess,HttpResponseEvent);
			removeContextListener(EventType.UPDATE_PACK_INFO,refreshPackage);
			SignalCenter.onShowPackItemInfoTriggered.remove(showPackItemDetailHandler);
			SignalCenter.onUsePackItem.remove(useHandler);
		}
		private function startNet(e:starling.events.Event):void
		{
			HttpSendProxy.sendPackageRequest(gameModel.tipUserId.toString());
		}
		/**
		 * 购买成功回调 
		 * @param e
		 * 
		 */		
		private function useSuccess(e:HttpResponseEvent):void
		{
			if(e.result)
			{
				var tips:String = LangManager.getText("500208");
				Alert.show(tips,"",new ListCollection([{label:"ok"}]));
			}
		}
		/**
		 * 强刷当前页 
		 * @param e
		 * 
		 */		
		private function refreshPackage(e:flash.events.Event):void
		{
			view.setList(packageModel.itemList);
		}
		
		private function showPackItemDetailHandler(id:String,num:Number,isMine:Boolean):void
		{
			PopUpWindowManager.centerPopUpWindow(WindowFactory.addPopUpWindow(WindowFactory.PACK_DETAIL_WINDOW,null,id,num,isMine) as DisplayObject);
		}
		private function useHandler(id:String):void
		{
			var type:String = "normal";
			switch(Configure.getItemType(id))
			{
				case Configure.ITEM:
					var item:PackageItemVO = packageModel.getItemById(id);
					if(item.acNum > 0)
					{
						type = "achievement";
					}
					break;
				case Configure.GIFT:
					var gift:PackageGiftVO = packageModel.getGiftById(id);
					if(gift.acNum > 0)
					{
						type = "achievement";
					}
					var itemVO:GiftConfigVO = Configure.giftConfig.getItemById(id);
					break;
				case Configure.PACK:
					var p:PackageItemVO = packageModel.getItemById(id);
					if(p.acNum > 0)
					{
						type = "achievement";
					}
					var packitem:PackageItemConfigVO = Configure.packItemConfig.getItemById(id);
					break;
				case Configure.VIP:
					var vip:PackageItemVO = packageModel.getItemById(id);
					if(vip.acNum > 0)
					{
						type = "achievement";
					}
					var vitemVO:VipConfigVO = Configure.vipConfig.getItemById(id);
					break;
			}
			
			HttpSendProxy.sendUseItem(id,type);
		}
	}
}