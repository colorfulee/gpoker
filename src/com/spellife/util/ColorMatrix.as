package com.spellife.util
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.filters.ColorMatrixFilter;
	
	public class ColorMatrix
	{
		public function ColorMatrix()
		{
		}
		/**
		 * 变灰态
		 * @param param1
		 * 
		 */
		public static function turnGray(display:Sprite) : void
		{
			var filters:Array = [0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0];
//			var gray:ColorMatrixFilter = new ColorMatrixFilter(filters);
			var filter:ColorMatrixFilter = new ColorMatrixFilter();
			filter.adjustSaturation(-1);
			display.filter = filter;
		}
		/**
		 * 变灰态
		 * @param param1
		 * 
		 */
		public static function turnLighter(display:DisplayObject,n:Number) : void
		{
//			var gray:ColorMatrixFilter = createBrightnessFilter(n);
//			display.filter = [gray];
		}
		
		/**
		 144:          * 亮度(N取值为-255到255)
		 145:          *
		 146:          * @param n
		 147:          * @return
		 148:          *
		 149:          */
//		public static function createBrightnessFilter(n:Number):ColorMatrixFilter
//		{
//			return new ColorMatrixFilter([1, 0, 0, 0, n, 0, 1, 0, 0, n, 0, 0, 1, 0, n, 0, 0, 0, 1, 0]);
//		}
		/**
		 * 回复正常
		 * @param param1
		 * 
		 */
		public static function turnNormal(display:DisplayObject) : void
		{
			display.filter = null;
		}
		/**
		 * 获取反向图片 
		 * @param bd
		 * @return 
		 * 
		 */		
//		public static function getRevertBitmapData(bd:BitmapData):BitmapData
//		{
//			var temp:BitmapData = new BitmapData(bd.width,bd.height,true,0);
//			var ma:Matrix = new Matrix;
//			ma.scale(1,-1);
//			ma.translate(0,bd.height);
//			temp.draw(bd,ma);
//			
//			return temp;
//		}
	}
}
