package com.jzgame.view.display
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.i.IToolTip;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	public class DefaultDownToolTip extends SLUIComponent implements IToolTip
	{
		/*auther     :jim
		* file       :DefaultToolTip.as
		* date       :Apr 30, 2015
		* description:提示基础类
		*/
		protected var _tip:String;
		protected var _text:TextField;
		protected var _back:Scale9Image;
		protected var _arrow:Image;
		protected var _rect:Rectangle;
		public function DefaultDownToolTip(tip:String)
		{
			super();
			
			_tip = tip;
			
			var rect:Rectangle = new Rectangle(30,18,2,2);
			var scaleBack:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_tips2"),rect);
			_back = new Scale9Image(scaleBack);
			addChild(_back);
			
			_text = new TextField(100,100,_tip,HtmlTransCenter.Arial(),18,0xffffff);
			_text.x = 8;
			_text.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_text.isHtmlText = true;
			_text.x = - Math.floor(_text.width * .5);
			addChild(_text);
			
			_arrow = new Image(ResManager.defaultAssets.getTexture("common_bg_tips1"));
			_arrow.y = 5;
			addChild(_arrow);
			
			_back.width  = _text.width + 10;
			_back.height = _text.height + 15;
			_back.x = - Math.floor(_back.width * 0.5);
			_back.y = _arrow.height;
			_text.y = _arrow.height + 8;
			_arrow.x = -Math.floor(_arrow.texture.width * 0.5);
//			_arrow.y = _back.height + _arrow.height - 5;
		}
		/**
		 * 以为标准 
		 * @param rect
		 * 
		 */		
		public function setRect(rect:Rectangle):void
		{
			_rect = rect;
			this.x = Math.floor((rect.x + rect.width * 0.5) / ReleaseUtil.SCALEX);
			this.y = Math.floor((rect.y + rect.height) / ReleaseUtil.SCALEX);
			if(this.x < 0)
			{
				_arrow.x += this.x - Math.floor(_arrow.width * 0.5);
				this.x = 0;
			}
		}
		/**
		 * 以点为标准 
		 * @param p
		 * 
		 */		
		public function setPoint(p:Point):void
		{
			this.x = p.x - _arrow.x;
			this.y = p.y - _arrow.y;
		}
		
		public function move(p:Point):void
		{
			setPoint(p);
		}
	}
}