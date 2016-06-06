package com.jzgame.modules.table.ui
{
	import com.jzgame.common.utils.ResManager;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.List;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Sprite;
	
	public class TableToolView extends Sprite
	{
		/***********
		 * name:    TableToolView
		 * data:    Nov 23, 2015
		 * author:  jim
		 * des:     房间工具栏
		 ***********/
		private var _back:Scale9Image;
		public var toolList:List; 
		public function TableToolView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			var s9:Scale9Textures = new Scale9Textures(ResManager.tableAssets.getTexture("s9_table_bg_menu"),
				new Rectangle(20,20,1,1));
			_back = new Scale9Image(s9);
			_back.width  = 133;
			_back.height = 180;
			addChild(_back);
			
			toolList = new List();
			toolList.width = 148;
			toolList.height = 200;
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 55;
			layout.paddingLeft = 3;
			layout.paddingTop = 5;
			toolList.layout = layout;
			toolList.itemRendererType = TableToolItem;
			addChild(toolList);
		}
	}
}