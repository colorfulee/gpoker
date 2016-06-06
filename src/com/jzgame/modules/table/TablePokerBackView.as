package com.jzgame.modules.table
{
	import com.jzgame.common.utils.ResManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class TablePokerBackView extends Sprite
	{
		/***********
		 * name:    TablePokerBackView
		 * data:    Nov 20, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Image;
		public function TablePokerBackView()
		{
			super();
			
			_back = new Image(ResManager.tableAssets.getTexture("cards-L_120"));
			_back.scale = .5;
			addChild(_back);
			
			this.pivotY = _back.height;
		}
	}
}