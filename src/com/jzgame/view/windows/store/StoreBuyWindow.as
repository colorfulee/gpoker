package com.jzgame.view.windows.store
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.AssetsName;
	import com.jzgame.model.UserProxy;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.vo.configs.GiftConfigVO;
	import com.jzgame.vo.configs.ItemConfigVO;
	import com.jzgame.vo.configs.ShopGiftVO;
	import com.jzgame.vo.configs.ShopItemConfigVO;
	import com.jzgame.vo.configs.ShopVipConfigVO;
	import com.jzgame.vo.configs.VipConfigVO;
	import com.spellife.display.PopUpWindow;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.NumericStepper;
	import feathers.controls.ScrollText;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class StoreBuyWindow extends PopUpWindow
	{
		/***********
		 * name:    StoreBuyWindow
		 * data:    Dec 3, 2015
		 * author:  jim
		 * des:
		 ***********/
		protected var _back:Scale9Image;
		protected var _close:Button;
		
		private var _name:Label;
		private var _ownNum:Label;
		private var _tu:ImageLoader;
		private var _desc:ScrollText;
		private var _price:Label;
		private var _priceIcon:Image;
		private var _descBack:Scale9Image;
		private var _buy:Button ;
		private var _numStepper:NumericStepper;
		
		private var _data:Object;
		public function StoreBuyWindow()
		{
			super();
			this.mName = WindowFactory.STORE_BUY_WINDOW;
			init();
		}
		
		protected function init():void
		{
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup")
				,new Rectangle(20,20,1,1));
			_back = new Scale9Image(s9);
			_back.x = 3;
			_back.y = 10;
			_back.width  = 691;
			_back.height = 559;
			addChild(_back);
			
			_close = StyleProvider.closeButton;
			_close.x = 685 - 27;
			_close.y = 0;
			addChild(_close);
			
			setClose(_close);
			
			_name = new Label;
			_name.textRendererProperties.textFormat = StyleProvider.getTF(0xffffff,22);
			_name.setSize(400,40);
			_name.x = 180;
			_name.y = 50;
			addChild(_name);
			
			_tu = new ImageLoader();
			_tu.x = 27;
			_tu.y = 45;
			addChild(_tu);
			
			_ownNum = new Label;
			//是否是html
			_ownNum.textRendererProperties.isHTML = true;
			_ownNum.textRendererProperties.textFormat = StyleProvider.getTF(0xffffff,22);
			_ownNum.setSize(400,40);
			_ownNum.x = 180;
			_ownNum.y = 100;
			addChild(_ownNum);
			
			_descBack = StyleProvider.commonRoundBack;
			_descBack.width = 641;
			_descBack.height = 214;
			_descBack.x = 28;
			_descBack.y = 176;
			addChild(_descBack);
			
			_desc = new ScrollText;
			_desc.isHTML = true;
			_desc.textFormat = StyleProvider.getTF(0x948aa6,22);
//			_desc.textRendererProperties.textFormat = StyleProvider.getTF(0x948aa6,22);
			_desc.setSize(641,214);
			_desc.x = 30;
			_desc.y = 176;
			addChild(_desc);
			
			_price = new Label;
			_price.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,22);
			_price.setSize(400,40);
			_price.x = 105;
			_price.y = 420;
			addChild(_price);
			
			_buy = new Button();
			_buy.x = 292;
			_buy.y = 488;
			_buy.label = LangManager.getText("500106");
			addChild(_buy);
			
			_numStepper = new NumericStepper();
//			_numStepper.styleProvider = null;
			_numStepper.step = 1;
			_numStepper.customDecrementButtonStyleName = StyleProvider.CUSTOM_DECC_IN_NUM_STEPPER;
			_numStepper.customIncrementButtonStyleName = StyleProvider.CUSTOM_INC_IN_NUM_STEPPER;
			_numStepper.customTextInputStyleName = StyleProvider.CUSTOM_TEXT_INPUT_IN_NUM_STEPPER;
			_numStepper.textInputGap = 6;
			_numStepper.minimum = 1;
			_numStepper.maximum = 10;
			_numStepper.x = 310;
			_numStepper.y = 406;
//			_numStepper.decrementButtonLabel = "-";
//			_numStepper.incrementButtonLabel = "+";
			addChild(_numStepper);
			
			_numStepper.addEventListener( Event.CHANGE, stepper_changeHandler );
		}
		/**
		 * 显示 
		 * @param rests
		 * 
		 */		
		override public function show(...rests):void
		{
			super.show(rests);
			
			_data = rests[0];
			var own:Number    = rests[1];
			var mychip:Number = rests[2];
			var mycoin:Number = rests[3];
			if(_data is ShopGiftVO)
			{
				var vo:ShopGiftVO = _data as ShopGiftVO;
				var itemVO:GiftConfigVO = Configure.giftConfig.getItemById(vo.itemId);
				_desc.text = itemVO.desc;
				_name.text = itemVO.name;
				_tu.source = ResManager.defaultAssets.getTexture("store_icon_hot");
			}else if(_data is ShopItemConfigVO)
			{
				var voo:ShopItemConfigVO = _data as ShopItemConfigVO;
				var iitemVO:ItemConfigVO = Configure.itemConfig.getItemById(voo.itemId);
				_desc.text = iitemVO.des;
				_name.text = iitemVO.name;
				_tu.source = AssetsCenter.getImagePath(iitemVO.img);
			}else if(_data is ShopVipConfigVO)
			{
				var vooo:ShopVipConfigVO = _data as ShopVipConfigVO;
				var iiitemVO:VipConfigVO = Configure.vipConfig.getItemById(vooo.itemId);
				_desc.text = iiitemVO.desc;
				_name.text = iiitemVO.name;
				_tu.source = AssetsCenter.getImagePath(iiitemVO.img);
			}
			
			_ownNum.text = HtmlTransCenter.getFontStr(LangManager.getText("500105"),"b3a7db",20) + HtmlTransCenter.getFontStr(own.toString(),"84c368",20);
			if(_data.chip>0)
			{
				_numStepper.maximum = Math.floor(mychip / _data.chip);
				_price.text = _data.chip.toString();
				_priceIcon = new Image(ResManager.defaultAssets.getTexture(AssetsName.ASSET_20000_CLIP_ICON));
			}else
			{
				_numStepper.maximum = Math.floor(mycoin / _data.coin);
				_priceIcon = new Image(ResManager.defaultAssets.getTexture(AssetsName.ASSET_20000_GOLD_ICON));
				_price.text = _data.coin.toString();
			}
			_priceIcon.x = 78;
			_priceIcon.y = 424;
			addChild(_priceIcon);
			
			_buy.addEventListener(Event.TRIGGERED, buyHandler);
		}
		/**
		 * 购买 
		 * @param e
		 */		
		private function buyHandler(e:Event):void
		{
			if(_data.chip>0)
			{
				if(UserProxy.checkValid(_data.chip,UserProxy.CHIP))
				{
					this.closeWindow();
					HttpSendProxy.sendBuyRequest(_data.id,_numStepper.value,UserProxy.CHIP);
				}
			}else
			{
				if(UserProxy.checkValid(_data.coin,UserProxy.GOLD))
				{
					this.closeWindow();
					HttpSendProxy.sendBuyRequest(_data.id,_numStepper.value,UserProxy.GOLD);
				}
			}
//			SignalCenter.onShopItemBuyTriggered.dispatch();
		}
		
		private function stepper_changeHandler( event:Event ):void
		{
			var stepper:NumericStepper = NumericStepper( event.currentTarget );
			trace( "stepper.value changed:", stepper.value);
		}
		
		override public function dispose():void
		{
			_buy.removeEventListener(Event.TRIGGERED, buyHandler);
			_priceIcon.dispose();
			_priceIcon = null;
			trace(name,"dispose");
		}
	}
}