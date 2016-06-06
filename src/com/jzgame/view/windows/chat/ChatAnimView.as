package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.LangManager;
	
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledRowsLayout;
	
	import starling.display.Sprite;
	
	public class ChatAnimView extends Sprite
	{
		/***********
		 * name:    ChatAnimView
		 * data:    Jan 12, 2016
		 * author:  jim
		 * des:
		 ***********/
		public var tabBar:List;
		public var animList:List;
		public function ChatAnimView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			tabBar = new List();
			tabBar.itemRendererType = ChatAnimTabListItem;
			tabBar.itemRendererProperties.width = 123;
			var layout:HorizontalLayout = new HorizontalLayout();
			tabBar.layout = layout;
			addChild(tabBar);
			tabBar.x = 142;
			tabBar.y = 18;
			tabBar.dataProvider = new ListCollection([LangManager.getText('500262'),LangManager.getText('500263')]);
			
			animList = new List();
			animList.itemRendererType = ChatAnimListItem;
			animList.x = 100;
			animList.y = 65;
			animList.width  = 380;
			animList.height = 420;
			addChild(animList);
			
			var column:TiledRowsLayout = new TiledRowsLayout;
			column.requestedColumnCount = 3 ;
			column.requestedRowCount = 0;
			column.verticalGap = 15;
			animList.minimumDragDistance = 0.1;
//			column.useVirtualLayout = true;
			animList.itemRendererProperties.height = 121;
			animList.itemRendererProperties.width  = 100;
			animList.layout = column;
		}
	}
}