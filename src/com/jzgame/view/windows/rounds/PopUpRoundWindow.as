package com.jzgame.view.windows.rounds
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.view.display.TabBarListItem;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PopUpRoundWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    PopUpRoundWindow
		 * data:    Dec 14, 2015
		 * author:  jim
		 * des:
		 ***********/
		
		protected var _title:Image;
		
		public var tabBar:List;
		private var _infoBack:Scale9Image;
		private var _list:List;
		public function PopUpRoundWindow()
		{
			super();
		}
		
		override protected function init():void
		{
			super.init();
			
			_title = new Image(ResManager.defaultAssets.getTexture("recording_txt_recording"));
			_title.x = 35;
			_title.y = 10;
			addChild(_title);
			
			tabBar = new List();
			tabBar.x = 25;
			tabBar.y = 100;
			tabBar.itemRendererType = TabBarListItem;
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 15;
			tabBar.minimumDragDistance = 0.1;
			layout.useVirtualLayout = true;
			tabBar.itemRendererProperties.height = 69;
			tabBar.layout = layout;
			tabBar.dataProvider = new ListCollection(
				[
					{ label: LangManager.getText('500222')},{label: LangManager.getText('500223')}
				]);
			addChild(tabBar);
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 674;
			_infoBack.height = 510;
			_infoBack.x = 240;
			_infoBack.y = 100;
			addChild(_infoBack);
			
			_list = new List;
			_list.itemRendererType = RoundListItem;
			_list.width  = 648;
			_list.height = 502;
			_list.x = 260;
			_list.y = 106;
			addChild(_list);
			var listLayout:VerticalLayout = new VerticalLayout();
			listLayout.gap = 15;
			_list.minimumDragDistance = 0.1;
			listLayout.useVirtualLayout = true;
			_list.itemRendererProperties.height = 80;
			_list.snapScrollPositionsToPixels = false;
			_list.layout = listLayout;
		}
		
		public function setList(data:Array):void
		{
			_list.dataProvider = new ListCollection(data);
		}
	}
}