package com.jzgame.mediator.windows.pack
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.common.vo.PackageItemConfigVO;
	import com.jzgame.vo.PackageGiftVO;
	import com.jzgame.vo.PackageItemVO;
	import com.jzgame.vo.configs.GiftConfigVO;
	import com.jzgame.vo.configs.ItemConfigVO;
	import com.jzgame.vo.configs.VipConfigVO;
	import com.spellife.feathers.SLImageLoader;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.events.Event;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.events.Event;
	
	public class PackListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    StoreGiftListItem
		 * data:    Dec 3, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale3Image;
		private var _name:Label;
		private var _tu:SLImageLoader;
		private var _itemName:String;
		public function PackListItem()
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
			_back.height = 222;
			addChild(_back);
			
			_name = new Label;
			_name.setSize(170,30);
			_name.x = 5;
			_name.y = 155 + 30;
			_name.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,18,HtmlTransCenter.Arial(),TextFormatAlign.CENTER);
			addChild(_name);
			
			_tu = new SLImageLoader();
			_tu.source = ResManager.defaultAssets.getTexture("store_icon_hot");
			_tu.x = 40;
			_tu.y = 40;
			addChild(_tu);
			
			this.addEventListener(starling.events.Event.TRIGGERED, triggered);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!value)return;
			
			var vo:Object = (data);
			if(value is PackageGiftVO)
			{
				var itemVO:GiftConfigVO = Configure.giftConfig.getItemById(vo.id);
				_name.text = itemVO.name + "x" + PackageGiftVO(vo).allNum;
				_itemName = itemVO.name;
				_tu.source = ResManager.defaultAssets.getTexture("store_icon_hot");
				_tu.x = 40;
			}else if(value is PackageItemVO)
			{
				if(Configure.getItemType(value.id)==Configure.ITEM)
				{
					var iitemVO:ItemConfigVO = Configure.itemConfig.getItemById(vo.id);
					_tu.source = AssetsCenter.getImagePath(iitemVO.img);
					_name.text = iitemVO.name + "x" + PackageItemVO(vo).allNum;;
					_itemName = iitemVO.name;
					_tu.x = 25;
				}else if(Configure.getItemType(value.id)==Configure.PACK)
				{
					var packitem:PackageItemConfigVO = Configure.packItemConfig.getItemById(vo.id);
					_tu.source = AssetsCenter.getImagePath(packitem.img);
					_name.text = packitem.name + "x" + PackageItemVO(vo).allNum;;
					_itemName = packitem.name;
					_tu.x = 25;
				}
				else
				{
					var vitemVO:VipConfigVO = Configure.vipConfig.getItemById(vo.id);
					_tu.source = AssetsCenter.getImagePath(vitemVO.img);
					_name.text = vitemVO.name + "x" + PackageItemVO(vo).allNum;;
					_itemName = vitemVO.name;
					_tu.x = 25;
				}
			}
			data.addEventListener(flash.events.Event.CHANGE, updateNum);
		}
		/**
		 * 更新数字 
		 * @param e
		 * 
		 */		
		private function updateNum(e:flash.events.Event):void
		{
			_name.text = _itemName+"x"+(_data).allNum ;
		}
		/**
		 * 点击 
		 * @param e
		 * 
		 */		
		private function triggered(e:starling.events.Event):void
		{
			SignalCenter.onShowPackItemInfoTriggered.dispatch(String(_data.id),Number(_data.allNum),(_data).isMine);
		}
		
		override public function dispose():void
		{
			this.removeEventListener(starling.events.Event.TRIGGERED, triggered);
			if(_data)
			_data.removeEventListener(flash.events.Event.CHANGE, updateNum);
		}
	}
}