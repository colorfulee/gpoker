package com.jzgame.view.windows
{
	import com.jzgame.common.utils.ResManager;
	import com.spellife.display.PopUpWindow;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PopUpDefaultWindow extends PopUpWindow
	{
		/***********
		 * name:    PopUpDefaultWindow
		 * data:    Nov 27, 2015
		 * author:  jim
		 * des:     包含背景关闭按钮的弹窗
		 ***********/
		protected var _back:Scale9Image;
		protected var _frame:Image;
		protected var _rightFrame:Image;
		protected var _titleBack:Image;
		protected var _close:Button;
		public function PopUpDefaultWindow()
		{
			super();
			_isSole = false;
			init();
		}
		
		protected function init():void
		{
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup")
				,new Rectangle(20,20,1,1));
			_back = new Scale9Image(s9);
			_back.x = 3;
			_back.y = 10;
			_back.width  = 953;
			_back.height = 620;
			addChild(_back);
			
			_frame = new Image(ResManager.defaultAssets.getTexture("common_bg_pattern"));
			_frame.x = 0;
			_frame.y = 110;
			addChild(_frame);
			
			_rightFrame = new Image(ResManager.defaultAssets.getTexture("common_bg_pattern"));
			_rightFrame.scaleX = -1;
			_rightFrame.scaleY = -1;
			_rightFrame.x = _rightFrame.width + 150;
			_rightFrame.y = _rightFrame.height;
			addChild(_rightFrame);
			
			_titleBack = new Image(ResManager.defaultAssets.getTexture("common_bg_title"));
			_titleBack.y = 6;
			addChild(_titleBack);
			
			_close = StyleProvider.closeButton;
			_close.x = 900 + 5;
			_close.y = 0;
			addChild(_close);
			
			setClose(_close);
		}
		
		public function set hasDefaultTitleBack(value:Boolean):void
		{
			if(value)
			{
				addChild(_titleBack);
			}else
			{
				removeChild(_titleBack);
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			_back.dispose();
			_frame.dispose();
			_rightFrame.dispose();
			_titleBack.dispose();
			_close.dispose();
		}
	}
}