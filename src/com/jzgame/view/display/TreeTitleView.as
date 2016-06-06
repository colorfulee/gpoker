package com.jzgame.view.display
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.SystemColor;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.display.Bitmap;
	
	import starling.display.Image;
	
	public class TreeTitleView extends SLUIComponent
	{
		/*auther     :jim
		* file       :TreeTitleView.as
		* date       :Mar 13, 2015
		* description:
		*/
		private var _leftIcon:Image;
		private var _rightIcon:Image;
		private var _label:SLLabel = new SLLabel;
		public function TreeTitleView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_leftIcon = new Image(ResManager.defaultAssets.getTexture("mission_bg_line"));
			_leftIcon.x = 0;
			_leftIcon.y = 6;
			addChild(_leftIcon);
			
			_rightIcon = new Image(ResManager.defaultAssets.getTexture("mission_bg_line"));
			_rightIcon.y = 6;
			_rightIcon.scaleX = -1;
			addChild(_rightIcon);
			
			_label.setLocation(_leftIcon.x + _leftIcon.width + 20,-2);
			_label.textRendererProperties = StyleProvider.getTF();
			_label.size = 18;
			_label.autoTextSzie = true;
			_label.color = SystemColor.TITLE_TEXT;
			_label.text = "";
			addChild(_label);
		}
		
		public function setLabel(text:String):void
		{
			_label.text = text;
			
			_rightIcon.x = _label.x + _label.width + 36;
		}
	}
}