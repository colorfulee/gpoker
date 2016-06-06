package com.jzgame.view.windows.store
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.display.TabBarListItem;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.IScrollBar;
	import feathers.controls.List;
	import feathers.controls.SimpleScrollBar;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PopUpStoreWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    PopUpStoreWindow
		 * data:    Dec 2, 2015
		 * author:  jim
		 * des:
		 ***********/
		protected var _title:Image;
		protected var _titleText:Image;
		
		public var tabList:List;
		private var _itemList:List;
		private var _listBar:SimpleScrollBar;
		private var _infoBack:Scale9Image;
		public function PopUpStoreWindow()
		{
			super();
			this.mName = WindowFactory.STORE_WINDOW;
		}
		
		override protected function init():void
		{
			super.init();
			
			hasDefaultTitleBack = false;
			
			_title = new Image(ResManager.defaultAssets.getTexture("store_bg_title"));
			_title.x = 3;
			_title.y = 5;
			addChild(_title);
			
			_titleText = new Image(ResManager.defaultAssets.getTexture("store_txt_store"));
			_titleText.x = 30;
			_titleText.y = 10;
			addChild(_titleText);
			
			tabList = new List;
			tabList.itemRendererType = TabBarListItem;
			tabList.x = 25;
			tabList.y = 92;
			addChild(tabList);
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 15;
			tabList.minimumDragDistance = 0.1;
			layout.useVirtualLayout = true;
			tabList.itemRendererProperties.height = 69;
			tabList.layout = layout;
			tabList.dataProvider = new ListCollection([{label:LangManager.getText("500102")},
				{label:LangManager.getText("500103")},{label:LangManager.getText("500104")}]);
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 672;
			_infoBack.height = 509;
			_infoBack.x = 240;
			_infoBack.y = 100;
			addChild(_infoBack);
			
			_itemList = new List();
			_itemList.width = 665;
			_itemList.height = 490;
			_itemList.itemRendererProperties.width = 172;
			_itemList.itemRendererProperties.height = 217;
			var itemLayout:TiledRowsLayout = new TiledRowsLayout();
			itemLayout.requestedColumnCount = 3 ;
			itemLayout.requestedRowCount = 0;
			itemLayout.verticalGap = 15;
			itemLayout.useVirtualLayout = true;
			_itemList.layout = itemLayout;
			_itemList.snapScrollPositionsToPixels = false;
			_itemList.verticalScrollBarFactory = function():IScrollBar
			{
				_listBar = new SimpleScrollBar();
				_listBar.customThumbStyleName = StyleProvider.CUSTOM_SIMPLEBAR_IN_MAIL;
				_listBar.direction = SimpleScrollBar.DIRECTION_VERTICAL;
				return _listBar;
			}
			
			_itemList.x = 240;
			_itemList.y = 100 + 20;
			addChild(_itemList);
			_itemList.itemRendererType = StoreGiftListItem;
		}
		
		public function setData(arr:Array):void
		{
			_itemList.dataProvider = new ListCollection(arr);
		}
	}
}