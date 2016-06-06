package com.jzgame.view.windows
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.Style;
	import com.jzgame.enmu.AssetsName;
	import com.spellife.display.ImageButton;
	import com.spellife.display.ImageSelectBox;
	import com.spellife.display.PopUpWindow;
	import com.spellife.display.S9ImageButton;
	import com.spellife.display.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	
	public class PopUpGameCoinPayWindow extends PopUpWindow
	{
		public var closeBtn:ImageButton;
		public var reduceBtn:SimpleButton;
		public var increaseBtn:SimpleButton;
		private var _chipIcon:Bitmap = new Bitmap;
		//		
		public var title:SLLabel = new SLLabel;
		public var continuLabel:SLLabel = new SLLabel;
		public var remain:SLLabel = new SLLabel;
		public var remainClip:SLLabel = new SLLabel;
		public var minBuy:SLLabel = new SLLabel;
		public var maxBuy:SLLabel = new SLLabel;
		public var myMoney:SLLabel = new SLLabel;
		public var chipInputField:SLLabel = new SLLabel;
		//购买筹码
		public var buyIn:ImageButton;
		//复选框
		public var select:ImageSelectBox;
		
		public var minBuyBtn:S9ImageButton;
		public var maxBuyBtn:S9ImageButton;
		public function PopUpGameCoinPayWindow()
		{
			super();
		}
		
		override protected function initilze():void
		{
			title.mouseEnabled = false;
			title.setSize(430,40);
			title.setLocation(0,11);
			addChild(title);
			remain.setLocation(50,100);
			remain.setSize(150,50);
			addChild(remain);
			
			remainClip.setLocation(222,105);
			remainClip.setSize(150,30);
			addChild(remainClip);
			
			minBuy.setLocation(50,200);
			minBuy.autoTextSzie = true;
			addChild(minBuy);
			maxBuy.setLocation(50,150);
			maxBuy.autoTextSzie = true;
			addChild(maxBuy);
			myMoney.setLocation(225,112);
			myMoney.setSize(200,30);
			addChild(myMoney);
			
			continuLabel.setLocation(51,273);
			continuLabel.setSize(200,30);
			addChild(continuLabel);
			
			chipInputField.setLocation(52,319);
			chipInputField.setSize(160,30);
			addChild(chipInputField);
			
			minBuyBtn = Style.getInstance().imageNormalButton;
			minBuyBtn.setScaleX(150 / minBuyBtn.width);
			minBuyBtn.setLocation(222,155);
			addChild(minBuyBtn);
			
			maxBuyBtn = Style.getInstance().imageNormalButton;
			maxBuyBtn.setScaleX(150 / maxBuyBtn.width);
			maxBuyBtn.setLocation(222,198);
			addChild(maxBuyBtn);
			
			_chipIcon.bitmapData = ResManager.getBitmapDataByName(AssetsName.ASSET_20000_CLIP_ICON);
			_chipIcon.x = 210;
			_chipIcon.y = 102;
			addChild(_chipIcon);
			
			buyIn = Style.getInstance().imageRectNormalButton;
			buyIn.label = ( HtmlTransCenter.getHtmlStr(LangManager.getText("300310"),"ffe6b1",16,HtmlTransCenter.Arial()) );
			buyIn.x = 296;
			buyIn.y = 312;
			addChild(buyIn);
			
			select = new ImageSelectBox(ResManager.getBitmapDataByName(AssetsName.ASSET_20000_SELECT_ARROW),ResManager.getBitmapDataByName("20001_autoSelectBg"));
			select.x = 23;
			select.y = 276;
			select.selected = true;
			addChild(select);
			
			closeBtn = Style.getInstance().closeButton;
			closeBtn.x = 389;
			closeBtn.y = 14;
			addChild(closeBtn);
			
			setClose(closeBtn);
			setClose(minBuyBtn);
			setClose(maxBuyBtn);
			setClose(buyIn);
		}
		
		override public function show(...rests):void
		{
			super.show(rests);
			
			this.y -= 150;
		}
		
		override public function dispose():void
		{
			select.dispose();
		}
	}
}
import com.jzgame.view.windows;

