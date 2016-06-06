package com.jzgame.view.windows.ringGame
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.view.display.TabBarListItem;
	import com.spellife.display.PopUpWindow;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Canvas;
	import starling.display.Image;
	
	public class RingGameRoomWindow extends PopUpWindow
	{
		/***********
		 * name:    RingGameRoomWindow
		 * data:    Dec 11, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var tabBar:List;
		protected var _aback:Canvas;
		protected var _back:ImageLoader;
		protected var _close:Button;
		private var _infoTitleBack:Scale9Image;
		private var _infoBack:Scale9Image;
		
		private var _itemList:List;
		public var myChips:SLLabel;
		public var packBtn:Button;
		public var onLine:SLLabel;
		public function RingGameRoomWindow()
		{
			super();
			
			_isModal = false;
			
			init();
		}
		
		private function init():void
		{
			_aback = new Canvas();
			_aback.beginFill(0,0)
			_aback.drawRectangle(0,0,ReleaseUtil.STAGE_WIDTH,ReleaseUtil.STAGE_HEIGHT);
			_aback.endFill();
			addChild(_aback);
			
			_back = new ImageLoader();
			_back.source = AssetsCenter.getDyImagePath("MTT_bg_bg");
			_back.scaleX = 960 / 2048;
			_back.scaleY = 640 /1536;
			addChild(_back);
			
			_close = new Button();
			_close.styleProvider = null;
			_close.defaultSkin = new Image(ResManager.defaultAssets.getTexture("MTT_btn_back1"));
			_close.downSkin = new Image(ResManager.defaultAssets.getTexture("MTT_btn_back2"));
			_close.x = 13;
			_close.y = 13;
			addChild(_close);
			
			setClose(_close);
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 672;
			_infoBack.height = 474;
			_infoBack.x = 264;
			_infoBack.y = 104;
			addChild(_infoBack);
			
			var sinfot9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_RINGGAME_bg_top"),new Rectangle(20,20,1,1));
			_infoTitleBack = new Scale9Image(sinfot9);
			_infoTitleBack.width  = 672;
			_infoTitleBack.x = 264;
			_infoTitleBack.y = 104;
			addChild(_infoTitleBack);
			
			tabBar = new List();
			tabBar.x = 30;
			tabBar.y = 104;
			tabBar.itemRendererType = TabBarListItem;
			tabBar.dataProvider = new ListCollection(
				[
					{ label: LangManager.getText('500214')},
					{ label: LangManager.getText('500215')},
					{ label: LangManager.getText('500216')}
				]);
			addChild(tabBar);
			
			var tabBarLayout:VerticalLayout = new VerticalLayout();
			tabBarLayout.gap = 30;
			tabBar.minimumDragDistance = 0.1;
			tabBarLayout.useVirtualLayout = true;
			tabBar.layout = tabBarLayout;
			
			_itemList = new List();
			_itemList.width = 672;
			_itemList.height = 430;
			_itemList.itemRendererProperties.width = 172;
			_itemList.itemRendererProperties.height = 217;
			var itemLayout:TiledRowsLayout = new TiledRowsLayout();
			itemLayout.requestedColumnCount = 3 ;
			itemLayout.requestedRowCount = 0;
			itemLayout.verticalGap = 15;
			itemLayout.useVirtualLayout = true;
			_itemList.layout = itemLayout;
			_itemList.snapScrollPositionsToPixels = false;
			
			_itemList.x = 240;
			_itemList.y = 100 + 30;
			addChild(_itemList);
			_itemList.itemRendererType = RingGameListItem;
			
			
			myChips = new SLLabel();
			myChips.setSize(260,30);
			myChips.setLocation(640,600);
			myChips.textRendererProperties.isHTML = true;
			addChild(myChips);
			
			onLine = new SLLabel();
			onLine.setSize(672,30);
			onLine.setLocation(267,116);
			onLine.textRendererProperties.textFormat = StyleProvider.getTF(0x393740,16,'',TextFormatAlign.CENTER);
			onLine.text = LangManager.getText('500218') + ':0';
			addChild(onLine);
			
			packBtn = new Button();
			packBtn.styleProvider = null;
			packBtn.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_item1"));
			packBtn.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_item2"));
			packBtn.x = 870;
			packBtn.y = 25;
			addChild(packBtn);
		}
		
		public function setList(data:Array):void
		{
			_itemList.dataProvider = new ListCollection(data);
		}
		
//		override public function get width():Number
//		{
//			return 960;
//		}
//		override public function get height():Number
//		{
//			return 640;
//		}
	}
}