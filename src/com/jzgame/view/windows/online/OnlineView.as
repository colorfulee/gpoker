package com.jzgame.view.windows.online
{
	import com.jzgame.common.utils.ResManager;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	
	public class OnlineView extends Sprite
	{
		/***********
		 * name:    OnlineView
		 * data:    Jan 8, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _icon:Image;
		public function OnlineView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_icon = new Image(ResManager.defaultAssets.getTexture('table_icon_box'));
			addChild(_icon);
			_icon.addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		private function touchHandler(e:TouchEvent):void
		{
			trace(e);
		}
	}
}