package com.jzgame.modules.table
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	
	import flash.geom.Rectangle;
	
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class SitDownButton extends Sprite
	{
		/***********
		 * name:    SitDownButton
		 * data:    Nov 18, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale9Image;
		private var _arrow:Image;
		private var _text:Image;
		public function SitDownButton()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			this.touchable = true;
			this.touchGroup = true;
			var s9:Scale9Textures = new Scale9Textures(ResManager.tableAssets.getTexture("s9_table_bg_menu"),new Rectangle(10,10,1,1));
			_back = new Scale9Image(s9);
			_back.width = 90;
			_back.height = 100;
			addChild(_back);
			
			_arrow = new Image(ResManager.tableAssets.getTexture("table_btn_sitdown"));
			_arrow.x = 16;
			_arrow.y = 30;
			addChild(_arrow);
			
//			_text = new Image(ResManager.tableAssets.getTexture("table_btn_sitdown"));
//			_text.x = 10;
//			_text.y = 10;
//			addChild(_text);
			
			this.addEventListener(TouchEvent.TOUCH,touch);
		}
		/**
		 * 点击 
		 * @param e
		 * 
		 */		
		private function touch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this,TouchPhase.ENDED);
			if(touch)
			{
				SignalCenter.onSitDownArrowTriggered.dispatch(this.name);
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			this.removeEventListener(TouchEvent.TOUCH,touch);
		}
	}
}