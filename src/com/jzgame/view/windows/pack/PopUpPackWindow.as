package com.jzgame.view.windows.pack
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.mediator.windows.pack.PackListItem;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.display.TabBarListItem;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PopUpPackWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    PopUpPackWindow
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _topTitle:Image;
		public var tabBar:List;
		private var _infoBack:Scale9Image;
		private var _itemList:List;
		public function PopUpPackWindow()
		{
			super();
			
			mName = WindowFactory.PACK_WINDOW;
		}
		
		override protected function init():void
		{
			super.init();
			_topTitle = new Image(ResManager.defaultAssets.getTexture("items_txt_items"));
			_topTitle.x = 35;
			_topTitle.y = 10;
			addChild(_topTitle);
			
			tabBar = new List();
			tabBar.x = 35;
			tabBar.y = 100;
			tabBar.itemRendererProperties.height = 72;
			tabBar.itemRendererType = TabBarListItem;
			tabBar.dataProvider = new ListCollection(
				[
					{ label: LangManager.getText("300704") }
				]);
			addChild(tabBar);
			
			tabBar.selectedIndex = 0;
			
			var tabBarLayout:VerticalLayout = new VerticalLayout();
			tabBarLayout.gap = 15;
			tabBar.minimumDragDistance = 0.1;
			tabBarLayout.useVirtualLayout = true;
			tabBar.layout = tabBarLayout;
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 672;
			_infoBack.height = 508;
			_infoBack.x = 248;
			_infoBack.y = 100;
			addChild(_infoBack);
			
			_itemList = new List;
			_itemList.width  = 662;
			_itemList.height = 475 + 18;
			_itemList.x = 275 - 30;
			_itemList.y = 110;
			addChild(_itemList);
			
			var itemLayout:TiledRowsLayout = new TiledRowsLayout();
			itemLayout.requestedColumnCount = 3 ;
			itemLayout.requestedRowCount = 0;
			//不设置的话，会导致宽高选择大的。间距出问题
			itemLayout.useSquareTiles = false;
			itemLayout.horizontalGap = 35;
			itemLayout.verticalGap = 15;
//			itemLayout.useVirtualLayout = true;
			_itemList.layout = itemLayout;
			
			_itemList.snapScrollPositionsToPixels = false;
			_itemList.itemRendererType = PackListItem;
			_itemList.itemRendererProperties.width = 174;
			_itemList.itemRendererProperties.height = 222;
//			_itemList.snapScrollPositionsToPixels = false;
		}
		
		public function setList(arr:Array):void
		{
			_itemList.dataProvider = new ListCollection(arr);
		}
	}
}