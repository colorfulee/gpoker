package com.jzgame.view.windows.task
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.display.TabBarListItem;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PopUpTaskWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    PopUpTaskWindow
		 * data:    Nov 27, 2015
		 * author:  jim
		 * des:
		 ***********/
		protected var _title:Image;
		
		public var sign:Button;
		public var tabBar:List;
		private var _infoBack:Scale9Image;
		private var _list:List;
		public function PopUpTaskWindow()
		{
			super();
			
			this.name = WindowFactory.MISSION_WINDOW;
		}
		
		override protected function init():void
		{
			super.init();
			
			_title = new Image(ResManager.defaultAssets.getTexture("mission_txt_mission"));
			_title.x = 35;
			_title.y = 10;
			addChild(_title);
			
			tabBar = new List();
			tabBar.x = 25;
			tabBar.y = 120;
			tabBar.itemRendererType = TabBarListItem;
			tabBar.dataProvider = new ListCollection(
				[
					{ label: LangManager.getText('500101')}
				]);
			addChild(tabBar);
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 675;
			_infoBack.height = 512;
			_infoBack.x = 240;
			_infoBack.y = 100;
			addChild(_infoBack);
			
			tabBar.selectedIndex= 0;
			
			_list = new List;
			_list.itemRendererType = TaskListItem;
			_list.width  = 648;
			_list.height = 502;
			_list.x = 255;
			_list.y = 106;
			addChild(_list);
			var layout:VerticalLayout = new VerticalLayout();
			//			layout.gap = 95;
			_list.minimumDragDistance = 0.1;
			layout.useVirtualLayout = true;
			_list.itemRendererProperties.height = 121;
			_list.snapScrollPositionsToPixels = false;
			//			layout.afterVirtualizedItemCount = 5;
			_list.layout = layout;
			
//			_list.verticalScrollBarFactory = function():IScrollBar
//			{
//				_listBar = new SimpleScrollBar();
//				_listBar.customThumbStyleName = StyleProvider.CUSTOM_SIMPLEBAR_IN_MAIL;
//				_listBar.direction = SimpleScrollBar.DIRECTION_VERTICAL;
//				return _listBar;
//			}
			
			sign = new Button();
			sign.styleProvider = null;
			sign.defaultSkin = new Image(ResManager.defaultAssets.getTexture('mission_btn_signin1'));
			sign.downSkin = new Image(ResManager.defaultAssets.getTexture('mission_btn_signin1'));
			sign.defaultIcon = new Image(ResManager.defaultAssets.getTexture('mission_txt_signin1'));
			sign.downIcon = new Image(ResManager.defaultAssets.getTexture('mission_txt_signin2'));
			sign.x = 670;
			sign.y = 30;
			addChild(sign);
		}
		
		public function setList(data:Array):void
		{
			_list.dataProvider = new ListCollection(data);
		}
		/**
		 * 析构 
		 * 
		 */		
		override public function dispose():void
		{
			super.dispose();
			
			_title = null;
			sign = null;
			tabBar = null;
			_infoBack = null;
			_list = null;
		}
	}
}