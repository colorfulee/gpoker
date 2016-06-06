package com.spellife.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Mar 19, 2013 10:15:40 AM 
	 * @description:
	 */ 
	public class NumberContainer
	{
		private static var instance:NumberContainer;
		private var _source:Bitmap;
		private var _size:Point;
		
		public function bindBitmap(b:Bitmap,size:Point):void
		{
			_source = b;
			_size   = size;
		}
		
		public function getNumber(num:String):Bitmap
		{
			var length:uint = num.length;
			var bitmapData:BitmapData = new BitmapData(_size.x * length,_size.y * length, true, 0);
			var i:int = 0;
			var numValue:Number;
			var point:Point		= new Point();
			var rect:Rectangle	= new Rectangle();
			for(i=0; i<length; i++)
			{
				numValue	= (num.charAt(i) == '-') ? 10 : (num.charAt(i) == '+') ? 11 : int(num.charAt(i));
				rect.x		= numValue * _size.x;
				rect.y		= 0;
				rect.width	= _size.x;
				rect.height	= _size.y;
				point.x		= i * _size.x;
				point.y		= 0;
				bitmapData.copyPixels(_source.bitmapData, rect, point);
			}
			
			return new Bitmap(bitmapData);
		}
		
		
		public static function getInstance():NumberContainer
		{
			if(!instance) instance = new NumberContainer;
			return instance;
		}
	}
}