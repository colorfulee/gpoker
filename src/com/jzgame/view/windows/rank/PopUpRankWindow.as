package com.jzgame.view.windows.rank
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.view.display.TabBarListItem;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	import com.jzgame.vo.RankMyInfoVO;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.List;
	import feathers.controls.Radio;
	import feathers.core.ToggleGroup;
	import feathers.data.ListCollection;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PopUpRankWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    PopUpRankWindow
		 * data:    Dec 7, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var radioGroup:ToggleGroup;
		public var tabBar:List;
		private var _itemList:List;
		private var _topTitle:Image;
		private var _titleBack:Scale3Image;
		private var _infoBack:Scale9Image;
		private var _myInfoBack:Scale3Image;
		
		private var _title1:SLLabel = new SLLabel;
		private var _title2:SLLabel = new SLLabel;
		private var _title3:SLLabel = new SLLabel;
		private var _my:MyRankListItem;
		public function PopUpRankWindow()
		{
			super();
			
		}
		
		override protected function init():void
		{
			super.init();
			
			_topTitle = new Image(ResManager.defaultAssets.getTexture("rank_txt_title"));
			_topTitle.x = 35;
			_topTitle.y = 10;
			addChild(_topTitle);
			
			tabBar = new List();
			tabBar.x = 25;
			tabBar.y = 100;
			tabBar.itemRendererProperties.height = 72;
			tabBar.itemRendererType = TabBarListItem;
			tabBar.dataProvider = new ListCollection(
				[
					{ label: LangManager.getText("500204") },
					{ label: LangManager.getText("500205") },
					{ label: LangManager.getText("500206") }
				]);
			addChild(tabBar);
			
			var tabBarLayout:VerticalLayout = new VerticalLayout();
			tabBarLayout.gap = 15;
			tabBar.minimumDragDistance = 0.1;
			tabBarLayout.useVirtualLayout = true;
			tabBar.layout = tabBarLayout;
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 672;
			_infoBack.height = 490;
			_infoBack.x = 248;
			_infoBack.y = 100;
			addChild(_infoBack);
			
			var sinfo3:Scale3Textures = new Scale3Textures(ResManager.defaultAssets.getTexture("s9_rank_bg_title"),20,5);
			_titleBack = new Scale3Image(sinfo3);
			_titleBack.x = 248;
			_titleBack.y = 100;
			_titleBack.width = 672;
			addChild(_titleBack);
			
			_itemList = new List;
			_itemList.itemRendererType = RankListItem;
			_itemList.width  = 672;
			_itemList.height = 385;
			_itemList.x = 248;
			_itemList.y = 150;
			addChild(_itemList);
			var layout:VerticalLayout = new VerticalLayout();
			_itemList.minimumDragDistance = 0.1;
			layout.useVirtualLayout = true;
			layout.gap = 1;
			_itemList.itemRendererProperties.height = 76;
			_itemList.snapScrollPositionsToPixels = false;
			_itemList.layout = layout;
			
			
			var mysinfo3:Scale3Textures = new Scale3Textures(ResManager.defaultAssets.getTexture("s9_rank_bg_myself"),20,5);
			_myInfoBack = new Scale3Image(mysinfo3);
			_myInfoBack.x = 248;
			_myInfoBack.y = 527;
			_myInfoBack.width = 672;
			addChild(_myInfoBack);
			
			radioGroup = new ToggleGroup();
			
			var radio1:Radio = new Radio();
			radio1.label = LangManager.getText("301011");
			radio1.toggleGroup = radioGroup;
			radio1.x = 589;
			radio1.y = 40;
			this.addChild( radio1 );
			
			var radio2:Radio = new Radio();
			radio2.label = LangManager.getText("301012");
			radio2.toggleGroup = radioGroup;
			radio2.x = 689;
			radio2.y = 40;
			this.addChild( radio2 );
			
			_title1.setSize(150,30);
			_title1.textRendererProperties.textFormat = StyleProvider.getTF(0xb81662,22,"",TextFormatAlign.CENTER);
			_title1.text = LangManager.getText("301008");
			_title1.setLocation(225,105);
			addChild(_title1);
			
			_title2.setSize(150,30);
			_title2.textRendererProperties.textFormat = StyleProvider.getTF(0xb81662,22,"",TextFormatAlign.CENTER);
			_title2.setLocation(400,105);
			_title2.text = LangManager.getText("301009");
			addChild(_title2);
			
			_title3.setSize(150,30);
			_title3.textRendererProperties.textFormat = StyleProvider.getTF(0xb81662,22,"",TextFormatAlign.CENTER);
			_title3.setLocation(670,105);
			_title3.text = LangManager.getText("301010");
			addChild(_title3);
			
			_my = new MyRankListItem;
			_my.x = 248;
			_my.y = 440 + 95;
			addChild(_my);
		}
		
		public function setList(arr:Array):void
		{
			_itemList.dataProvider = new ListCollection(arr);
		}
		
		public function setMyInfo(data:RankMyInfoVO):void
		{
			_my.data = data;
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			radioGroup = null;
			tabBar = null;
			_itemList = null;
			_titleBack = null;
			_infoBack = null;
		}
	}
}