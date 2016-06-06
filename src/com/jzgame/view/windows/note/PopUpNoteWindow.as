package com.jzgame.view.windows.note
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.display.TabBarListItem;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PopUpNoteWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    PopUpNoteWindow
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _topTitle:Image;
		public var tabBar:List;
		private var _tlBack:Image;
		private var _trBack:Image;
		private var _infoBack:Scale9Image;
		private var _infoBottomBack:Scale3Image;
		private var _itemList:List;
		public var text:SLLabel;
		public var attend:Button;
		public function PopUpNoteWindow()
		{
			super();
			
			mName = WindowFactory.NOTE_WINDOW;
		}
		
		override protected function init():void
		{
			super.init();
			
			_topTitle = new Image(ResManager.defaultAssets.getTexture("activity_txt_title"));
			_topTitle.x = 35;
			_topTitle.y = 10;
			addChild(_topTitle);
			
			tabBar = new List();
			tabBar.x = 35;
			tabBar.y = 100;
			tabBar.itemRendererProperties.height = 72;
			tabBar.itemRendererType = TabBarListItem;
//			tabBar.dataProvider = new ListCollection(
//				[
//					{ label: LangManager.getText("300704") }
//				]);
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
			_infoBack.height = 445;
			_infoBack.x = 248;
			_infoBack.y = 100;
			addChild(_infoBack);
			
			var sinfo3:Scale3Textures = new Scale3Textures(ResManager.defaultAssets.getTexture("S9_activity_bg_timeline"),20,20);
			_infoBottomBack = new Scale3Image(sinfo3);
			_infoBottomBack.width  = 672;
			_infoBottomBack.x = 248;
			_infoBottomBack.y = 535;
			addChild(_infoBottomBack);
			
			attend = new Button();
			attend.defaultIcon = new Image(ResManager.defaultAssets.getTexture("activity_txt_joy1"));
			attend.downIcon = new Image(ResManager.defaultAssets.getTexture("activity_txt_joy2"));
			attend.x = 741;
			attend.y = 545;
			addChild(attend);
			
			text = new SLLabel();
			text.setSize(336,368);
			text.setLocation(255,255);
			text.wordWrap = true;
			text.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,24);
			addChild(text);
			
			_tlBack = new Image(ResManager.defaultAssets.getTexture("activity_bg_pattern"));
			_tlBack.x = 420 + 270;
			_tlBack.y = 110;
			addChild(_tlBack);
			
			_trBack = new Image(ResManager.defaultAssets.getTexture("activity_bg_pattern"));
			_trBack.scaleX = -1;
			_trBack.x = 253 + 250;
			_trBack.y = 110;
			addChild(_trBack);
		}
	}
}