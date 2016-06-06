package com.jzgame.view.windows.achie
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.display.TabBarListItem;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PopUpAchieWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    PopUpAchieWindow
		 * data:    Dec 14, 2015
		 * author:  jim
		 * des:     成就界面
		 ***********/
		protected var _title:Image;
		public var tabBar:List;
		private var _infoBack:Scale9Image;
		private var _list:List;
		public var total:SLLabel;
		public function PopUpAchieWindow()
		{
			super();
			
			_isSole = false;
			
			this.name = WindowFactory.ACHIEVE_WINDOW;
		}
		
		override protected function init():void
		{
			super.init();
			
			_title = new Image(ResManager.defaultAssets.getTexture("achievement_txt_title"));
			_title.x = 35;
			_title.y = 10;
			addChild(_title);
			tabBar = new List();
			tabBar.x = 25;
			tabBar.y = 120;
			tabBar.itemRendererProperties.height = 72;
			tabBar.itemRendererType = TabBarListItem;
			tabBar.dataProvider = new ListCollection(
				[
					{ label: LangManager.getText('500219')},{label: LangManager.getText('500220')},{label: LangManager.getText('500221')}
				]);
			addChild(tabBar);
			
			var tablayout:VerticalLayout = new VerticalLayout();
			tablayout.gap = 30;
			tabBar.layout = tablayout;
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 675;
			_infoBack.height = 512;
			_infoBack.x = 240;
			_infoBack.y = 100;
			addChild(_infoBack);
			
			_list = new List;
			_list.itemRendererType = AchieListItem;
			_list.width  = 688 + 80;
			_list.height = 502;
			_list.x = 145;
			_list.y = 106;
			addChild(_list);
			
			var layout:TiledRowsLayout = new TiledRowsLayout();
			layout.requestedColumnCount = 5 ;
			layout.requestedRowCount = 0;
			layout.verticalGap = 15;
			_list.minimumDragDistance = 0.1;
			layout.useVirtualLayout = true;
			_list.itemRendererProperties.height = 121;
			_list.snapScrollPositionsToPixels = false;
			_list.layout = layout;
			
			total = new SLLabel();
			total.setLocation(520,51);
			total.setSize(200,30);
			total.textRendererProperties.textFormat = StyleProvider.getTF(0x777a9d,20);
			addChild(total);
		}
		/**
		 * 设置数据 
		 * @param data
		 * 
		 */		
		public function setList(data:Array):void
		{
			_list.dataProvider = new ListCollection(data);
		}
	}
}