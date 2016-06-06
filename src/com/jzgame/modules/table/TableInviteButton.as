package com.jzgame.modules.table
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class TableInviteButton extends Sprite
	{
		/***********
		 * name:    TableInviteButton
		 * data:    Jan 11, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale9Image;
		private var _icon:Image;
		private var _title:SLLabel;
		public function TableInviteButton()
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
			
			_icon = new Image(ResManager.defaultAssets.getTexture('table_btn_invite'));
			_icon.x = 15;
			_icon.y = 20;
			addChild(_icon);
			
			_title = new SLLabel();
			_title.setSize(90,30);
			_title.textRendererProperties.textFormat = StyleProvider.getTF(0xffffff,15,'',TextFormatAlign.CENTER);
			_title.text = LangManager.getText('500260');
			addChild(_title);
			
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
				WindowFactory.addPopUpWindow(WindowFactory.FRIENDS_WINDOW,null,true);
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			this.removeEventListener(TouchEvent.TOUCH,touch);
		}
	}
}