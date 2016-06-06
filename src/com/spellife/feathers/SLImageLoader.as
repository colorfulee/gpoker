package com.spellife.feathers
{
	import com.spellife.ui.ToolTipManager;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import feathers.controls.ImageLoader;
	
	import starling.events.Event;
	
	public class SLImageLoader extends ImageLoader
	{
		/***********
		 * name:    SLImageLoader
		 * data:    Nov 16, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _rect:Rectangle = new Rectangle;
		private var _targetWidth:Number = 0;
		private var _targetHeight:Number = 0;
		public function SLImageLoader(rect:Rectangle = null)
		{
			super();
			
			_rect = rect ? rect : new Rectangle();
		}
		
		private function update(e:flash.events.Event):void
		{
			if(_rect.x != 0 || _rect.y != 0)
			{
				centerBy(new Point(_rect.x,_rect.y));
			}
		}
		
		private function updateIO(e:flash.events.Event):void
		{
			trace(e);
		}
		
		/**
		 * @private
		 */
		override protected function loader_completeHandler(event:flash.events.Event):void
		{
			super.loader_completeHandler(event);
			
			_targetWidth  = event.target.content.width;
			_targetHeight = event.target.content.height;
			this.addEventListener(starling.events.Event.ENTER_FRAME, nextFrame);
		}
		
		private function nextFrame(e:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ENTER_FRAME, nextFrame);
			if(_rect.x != 0 || _rect.y != 0)
			{
				centerBy(new Point(_rect.x,_rect.y));
			}
		}
		
		/**
		 * 图片居中位置 
		 * @param p
		 * 
		 */		
		private function centerBy(p:Point):void
		{
			this.x = p.x + Math.floor( - _targetWidth  * 0.5);
			this.y = p.y + Math.floor( - _targetHeight * 0.5);
		}
		/**
		 * 设置提示 
		 * @param value
		 * 
		 */
		public function setToolTip(value:Object):void
		{
			ToolTipManager.removeToolTip(this);
			if(value)
				ToolTipManager.registeToolTip(this,value);
		}
	}
}