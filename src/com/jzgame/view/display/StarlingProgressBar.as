package com.jzgame.view.display
{
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class StarlingProgressBar extends SLUIComponent
	{
		/*auther     :jim
		* file       :ProgressBar.as
		* date       :Nov 12, 2014
		* description:
		*/
		
		protected var _progressBg:Image;
		protected var _progress:Image;
		protected var _progressContainer:Sprite = new Sprite;
		//移动类型
		//0为移动图片
		//1为移动mask
		private var _type:uint = 0;
		public static var MOVE_MASK:uint = 1;
		
		protected var _barRect:Rectangle = new Rectangle;
		
		public function StarlingProgressBar(progress:Texture = null,progressBg:Texture = null)
		{
			super();
			
			_progressBg = new Image(progressBg);
			addChild(_progressBg);
			
			_progress = new Image(progress);
			_progressContainer.addChild(_progress);
			addChild(_progressContainer);
		}
		/**
		 * 设置类型  
		 * 0为移动图片
		 * 1为移动mask
		 * @param value
		 * 
		 */
		public function set type(value:uint):void
		{
			_type = value;
		}

		private function init():void
		{
			_progressContainer.clipRect = new Rectangle(_barRect.x,_barRect.y,_barRect.width,_barRect.height);
		}
		
		public function set value(progress:Number):void
		{
			progress = Math.min(1,progress);
			progress = Math.max(0,progress);
			if(_type == 0)
			{
				_progress.x = _barRect.x + (progress-1)* ( _barRect.width );
			}else
			{
				_progressContainer.clipRect = new Rectangle(_barRect.x,_barRect.y,progress*_barRect.width,_barRect.height);
				trace(_progressContainer.clipRect);
			}
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get value():Number
		{
			var pro:Number;
			if(_type == 0)
			{
				pro = 1 + _progress.x / _progress.width;
			}else
			{
				pro = _progressContainer.clipRect.width / _barRect.width;
			}
			return pro
		}
		
		public function setProgressImage(progress:Texture = null):void
		{
			_progress.texture = progress;
		}
		
		public function setProgressBgImage(progressBg:Texture = null):void
		{
			_progressBg.texture = progressBg;
		}
		/**
		 * 设置区域 
		 * @param rect
		 * 
		 */		
		public function setBarRect(rect:Rectangle):void
		{
			_barRect = rect;
			
			init();
		}
	}
}