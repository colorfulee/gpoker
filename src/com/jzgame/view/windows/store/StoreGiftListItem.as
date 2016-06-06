package com.jzgame.view.windows.store
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.enmu.AssetsName;
	import com.jzgame.vo.configs.GiftConfigVO;
	import com.jzgame.vo.configs.ItemConfigVO;
	import com.jzgame.vo.configs.ShopGiftVO;
	import com.jzgame.vo.configs.ShopItemConfigVO;
	import com.jzgame.vo.configs.ShopVipConfigVO;
	import com.jzgame.vo.configs.VipConfigVO;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.text.TextFormatAlign;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class StoreGiftListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    StoreGiftListItem
		 * data:    Dec 3, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale3Image;
		private var _icon:Image;
		private var _price:Label;
		private var _name:Label;
		private var _tu:ImageLoader;
		public function StoreGiftListItem()
		{
			super();
		}
		
		override protected function initialize():void
		{
			hasLabelTextRenderer  =  false;
			
			var s3:Scale3Textures = new Scale3Textures(ResManager.defaultAssets.getTexture("s9_store_bg_item")
			,10,10);
			_back = new Scale3Image(s3);
			_back.width = 174;
			addChild(_back);
			
			_icon = new Image(ResManager.defaultAssets.getTexture(AssetsName.ASSET_20000_GOLD_ICON));
			_icon.x = 30;
			_icon.y = 185;
			addChild(_icon);
			
			_price = new Label;
			_price.setSize(90,30);
			_price.x = 70;
			_price.y = 185;
			_price.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,18,HtmlTransCenter.Arial());
			addChild(_price);
			
			_name = new Label;
			_name.setSize(170,30);
			_name.x = 5;
			_name.y = 155;
			_name.textRendererProperties.textFormat = StyleProvider.getTF(0x948aa6,20,HtmlTransCenter.Arial(),TextFormatAlign.CENTER);
			addChild(_name);
			
			_tu = new ImageLoader();
			_tu.source = ResManager.defaultAssets.getTexture("store_icon_hot");
			_tu.x = 40;
			_tu.y = 40;
			addChild(_tu);
			
			this.addEventListener(Event.TRIGGERED, triggered);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!value)return;
			
			var vo:Object = (data);
			if(value is ShopGiftVO)
			{
				var itemVO:GiftConfigVO = Configure.giftConfig.getItemById(vo.itemId);
				_name.text = itemVO.name;
				_tu.source = ResManager.defaultAssets.getTexture("store_icon_hot");
				_tu.x = 40;
			}else if(value is ShopVipConfigVO)
			{
				var vitemVO:VipConfigVO = Configure.vipConfig.getItemById(vo.itemId);
				_tu.source = AssetsCenter.getImagePath(vitemVO.img);
				_name.text = vitemVO.name;
				_tu.x = 25;
			}else if(value is ShopItemConfigVO)
			{
				var iitemVO:ItemConfigVO = Configure.itemConfig.getItemById(vo.itemId);
				_tu.source = AssetsCenter.getImagePath(iitemVO.img);
				_name.text = iitemVO.name;
				_tu.x = 25;
			}
			
			if(vo.coin >0)
			{
				_icon.texture = ResManager.defaultAssets.getTexture(AssetsName.ASSET_20000_GOLD_ICON);
				_price.text = vo.coin.toString();
			}else
			{
				_icon.texture = ResManager.defaultAssets.getTexture(AssetsName.ASSET_20000_CLIP_ICON);
				_price.text = vo.chip.toString();
			}
			addChild(_icon);
			
//			_mcAnim.bindId(("gift_"+itemVO.id));
		}
		
		private function triggered(e:Event):void
		{
//			var vo:ShopGiftVO = ShopGiftVO(data);
			SignalCenter.onShopItemTriggered.dispatch(uint(data.id));
		}
		
		override public function dispose():void
		{
			this.removeEventListener(Event.TRIGGERED, triggered);
		}
	}
}