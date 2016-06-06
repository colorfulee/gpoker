package com.jzgame.view.windows.safeBox
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.NumUtil;
	import com.spellife.util.HtmlTransCenter;
	
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	public class SafeBoxPinTipView extends Sprite
	{
		/***********
		 * name:    SafeBoxPinTipView
		 * data:    Jan 7, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale3Image;
		private var _arrow:Image;
		private var _text:TextField;
		public function SafeBoxPinTipView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_back = new Scale3Image(new Scale3Textures(ResManager.defaultAssets.getTexture('s9_details_bg_tips1'),20,5));
			_back.x = -_back.width * 0.5;
			addChild(_back);
			
			_arrow = new Image(ResManager.defaultAssets.getTexture('details_bg_tips2'));
			_arrow.x = -_arrow.width * 0.5;
			_arrow.y = _back.height - 5;
			addChild(_arrow);
			
			_text = new TextField(100,30,"",HtmlTransCenter.Arial(),18,0xdadada);
			_text.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			addChild(_text);
		}
		
		public function set text(value:Number):void
		{
			_text.text = NumUtil.n2c(value);
			_text.x = -_text.width * 0.5;
			_text.y = 10;
			_back.width = _text.width + 30;
			_back.x = -_back.width * 0.5;
		}
	}
}