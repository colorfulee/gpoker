package com.jzgame.mediator.windows
{
	import com.jzgame.common.model.SocketSendProxy;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.enmu.SystemColor;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.NumUtil;
	import com.jzgame.view.windows.PopUpGameCoinPayWindow;
	import com.netease.protobuf.Int64;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextFormatAlign;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class PopUpGameCoinPayWindowMediator extends Mediator
	{
		[Inject]
		public var view:PopUpGameCoinPayWindow;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var userModel:UserModel;
		
		private var plus:Number = 0;
		
		public function PopUpGameCoinPayWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.chipInputField.restrict="0-9";
			view.chipInputField.mouseEnabled = true;
			
			view.chipInputField.htmlText = HtmlTransCenter.getHtmlStr(NumUtil.n2c(gameModel.tableBaseInfoVO.maxBuy / 2),SystemColor.STR_ROOM_LIST_ITEM_TEXT,16,HtmlTransCenter.Arial(),TextFormatAlign.CENTER);
			view.maxBuy.htmlText = HtmlTransCenter.getHtmlStr(LangManager.getText("202312"),SystemColor.STR_GUIDE_TEXT,18); 
			view.minBuy.htmlText =  HtmlTransCenter.getHtmlStr(LangManager.getText("202313"),SystemColor.STR_GUIDE_TEXT,18); 
			view.title.htmlText =  HtmlTransCenter.getHtmlStr(LangManager.getText("202314"),SystemColor.STR_TITLE,26,HtmlTransCenter.Arial(),TextFormatAlign.CENTER); 
			view.remain.htmlText =  HtmlTransCenter.getHtmlStr(LangManager.getText("202315"),SystemColor.STR_GUIDE_TEXT,18); 
			view.remainClip.htmlText = HtmlTransCenter.getHtmlStr(NumUtil.n2c(userModel.myInfo.uMoney.toNumber()),SystemColor.STR_OWN_MONEY,16,HtmlTransCenter.Arial(),TextFormatAlign.CENTER); 
			view.continuLabel.htmlText = HtmlTransCenter.getHtmlStr(LangManager.getText("202316"),SystemColor.STR_GUIDE_TEXT,16); 
			
			view.minBuyBtn.label = HtmlTransCenter.getHtmlStr(NumUtil.n2c(gameModel.tableBaseInfoVO.minBuy),SystemColor.STR_EXP,16);
			view.minBuyBtn.labelTarget.filters = [new DropShadowFilter(1,45,0x96321d,1,1,1)];
			view.minBuyBtn.labelTarget.y +=1;
			view.maxBuyBtn.label = HtmlTransCenter.getHtmlStr(NumUtil.n2c(gameModel.tableBaseInfoVO.maxBuy),SystemColor.STR_EXP,16);
			view.maxBuyBtn.labelTarget.y +=1;
			view.maxBuyBtn.labelTarget.filters = [new DropShadowFilter(1,45,0x96321d,1,1,1)];
			
			eventMap.mapListener(view.buyIn, MouseEvent.CLICK, buyClipHandler);
			eventMap.mapListener(view.increaseBtn, MouseEvent.CLICK,increaseHandler);
			eventMap.mapListener(view.reduceBtn, MouseEvent.CLICK,reduceHandler);
			
			eventMap.mapListener(view.minBuyBtn, MouseEvent.CLICK,minHandler);
			eventMap.mapListener(view.maxBuyBtn, MouseEvent.CLICK,maxHandler);
		}
		
		override public function destroy():void
		{
			eventMap.unmapListener(view.minBuyBtn, MouseEvent.CLICK,minHandler);
			eventMap.unmapListener(view.maxBuyBtn, MouseEvent.CLICK,maxHandler);
			eventMap.unmapListener(view.increaseBtn, MouseEvent.CLICK,increaseHandler);
			eventMap.unmapListener(view.reduceBtn, MouseEvent.CLICK,reduceHandler);
			eventMap.unmapListener(view.buyIn, MouseEvent.CLICK, buyClipHandler);
			
			view.dispose();
		}
		
		private function buyClipHandler(e:MouseEvent):void
		{
			checkValid();
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function minHandler(e:MouseEvent):void
		{
			var chip:Number = gameModel.tableBaseInfoVO.minBuy;
			chip = Math.min(chip,userModel.myInfo.uMoney.toNumber());
			SocketSendProxy.sitDown(userModel.myInfo.uSeatIndex,new Int64(chip),view.select.selected);
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function maxHandler(e:MouseEvent):void
		{
			var chip:Number = gameModel.tableBaseInfoVO.maxBuy;
			chip = Math.min(chip,userModel.myInfo.uMoney.toNumber());
			SocketSendProxy.sitDown(userModel.myInfo.uSeatIndex,new Int64(chip),view.select.selected);
		}
		/**
		 * 检测 
		 * 
		 */		
		private function checkValid():void
		{
			var count:Number = gameModel.tableBaseInfoVO.maxBuy / 2 + plus * gameModel.tableBaseInfoVO.minBuy;
			count = Math.min(count,userModel.myInfo.uMoney.toNumber());
			
			SocketSendProxy.sitDown(userModel.myInfo.uSeatIndex,new Int64(count),view.select.selected);
			
			gameModel.autoBuy = view.select.selected;
		}
		/**
		 * 增加自带筹码 
		 * @param e
		 * 
		 */		
		private function increaseHandler(e:MouseEvent):void
		{
			plus++;
			var count:Number = gameModel.tableBaseInfoVO.maxBuy / 2 + plus * gameModel.tableBaseInfoVO.minBuy;
			
			if(count > userModel.myInfo.uMoney.toNumber())
			{
				count = userModel.myInfo.uMoney.toNumber();
				plus --;
			}
			if(count > gameModel.tableBaseInfoVO.maxBuy)
			{
				plus --;
				count = gameModel.tableBaseInfoVO.maxBuy;
			}
			
			view.chipInputField.htmlText = HtmlTransCenter.getHtmlStr(NumUtil.n2c(count),SystemColor.STR_ROOM_LIST_ITEM_TEXT,16,"",TextFormatAlign.CENTER);
		}
		/**
		 * 减少自带筹码 
		 * @param e
		 * 
		 */		
		private function reduceHandler(e:MouseEvent):void
		{
			plus--;
			var count:Number = gameModel.tableBaseInfoVO.maxBuy / 2 + plus * gameModel.tableBaseInfoVO.minBuy;
			if(count < gameModel.tableBaseInfoVO.minBuy)
			{
				count = gameModel.tableBaseInfoVO.minBuy;
				plus ++;
			}
			view.chipInputField.htmlText = HtmlTransCenter.getHtmlStr(NumUtil.n2c(count),SystemColor.STR_ROOM_LIST_ITEM_TEXT,16,"",TextFormatAlign.CENTER);
		}
	}
}
import com.jzgame.mediator.windows;

