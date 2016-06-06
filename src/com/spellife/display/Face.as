package com.spellife.display
{
	import com.jzgame.common.utils.AssetsCenter;
	
	import flash.display.Bitmap;
	import flash.events.IOErrorEvent;
	import flash.utils.setTimeout;
	
	import feathers.controls.ImageLoader;
	
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * the container for face shown
	 * @author apple
	 * 
	 */	
	public class Face extends Sprite
	{
		//安全沙箱问题。所以只能用代理loader
		private var _mask:Shape;
		private var _delay:Number = 1000;
		private var _index:int = 0;
		private var _image:ImageLoader;
		private var _bitmap:Bitmap = new Bitmap;
		/**
		 * 
		 * @param url 路径
		 * @param width 宽度
		 * @param height 高度
		 * 
		 */		
		public function Face(width_:Number=106,height_:Number=106)
		{
			_image = new ImageLoader();
			this.addChild( _image );
			
			_mask = new Shape();
			_mask.graphics.beginFill(0);
			_mask.graphics.drawRect(0,0,width_,height_);
			_mask.graphics.endFill();
			addChild(_mask);
			
			this.mask = _mask;
		}
		
		public function get maskShape():Shape
		{
			return _mask;
		}
		/**
		 * 设置头像路径 
		 * @param value
		 * 
		 */		
		public function set faceUrl(value:String):void
		{
			_image.addEventListener( Event.COMPLETE, update );
			_image.addEventListener(starling.events.Event.IO_ERROR,ioErrorHandler);
			if(value=="")
			{
				_image.source = AssetsCenter.getCommonFace();
			}else
			{
				_image.source = value;
			}
		}
		
		private function ioErrorHandler(e:starling.events.Event):void
		{
			trace(e);
			_image.source = AssetsCenter.getCommonFace();
//			setTimeout(ioUpdateFace,_delay);
			return;
		}
		/**
		 * 
		 * 
		 */		
		private function ioUpdateFace():void
		{
			_index ++;
			
			if(_index >= 5)
			{
				return;
			}
			_image.addEventListener( Event.COMPLETE, update );
			_image.source = AssetsCenter.getCommonFace();
		}
		/**
		 * 更新图片 
		 * @param e
		 * 
		 */		
		private function update(e:Event):void
		{
			_image.removeEventListener( Event.COMPLETE, update );
			setTimeout(updatePos,10);
		}
		private function updatePos():void
		{
			_image.x = Math.floor((width - _image.width) * 0.5);
			_image.y = Math.floor((height - _image.height) * 0.5);
		}
		/**
		 * 销毁 
		 * 
		 */		
		override public function dispose():void
		{
			super.dispose();
			_image.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			_image.removeEventListener( Event.COMPLETE, update );
			_image = null;
		}
	}
}