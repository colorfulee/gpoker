package com.jzgame.util
{
	import com.jzgame.enmu.ReleaseUtil;
	
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class NumUtil
	{
		/*auther     :jim
		* file       :NumUtil.as
		* date       :Apr 14, 2015
		* description:
		*/
		public function NumUtil()
		{
		}
		/**
		 * 其他超過一萬(五位數)一律用K顯示, 超過一百萬就用M.
		 * @param num
		 * @return 
		 * 
		 */		
		public static function n2kb(num:Number):String
		{
			var numStr:String = String(num);
			var result:String = "";
//			1000000
			if(numStr.length > 6)
			{
				result = numStr.substr(0,numStr.length - 6) + "M";
			}else if(numStr.length > 3)
			{
				result = numStr.substr(0,numStr.length - 3) + "K";
			}else
			{
				result = numStr;
			}
			return result;
		}
		
		/**
		 * 數字(每三位數)需要加上逗號
		 * @param num
		 * @return 
		 * 
		 */	
		public static function n2c(num:Number):String
		{
			var numStr:String = String(num);
			var result:String = "";
			if(numStr.length > 3)
			{
				var temp:Array = [];
				numStr.substr();
				var dot:uint = Math.floor( numStr.length / 3 );
				var first:uint = numStr.length % 3;
				if(first > 0)
				{
					temp.push(numStr.substr(0,first));
				}
				for(var index:uint = 0; index<dot;index++)
				{
					temp.push(numStr.substr(first + index * 3,3));
				}
				result = temp.join(",");
			}else
			{
				result = numStr;
			}
			return result;
		}
		/**
		 * 數字(每三位數)需要加上逗號 超过8位数
		 * @param num
		 * @return 
		 * 
		 */
		public static function n2ck(num:Number):String
		{
			var numStr:String = String(num);
			var result:String = "";
			if(numStr.length > 8)
			{
				result = n2c(Number(numStr.substr(0,numStr.length - 3)))+ "K";
				return result;
			}else
			{
				return n2c(num);
			}
		}
		/**
		 * 数字显示百万级别 
		 * @param num
		 * @return 
		 * 
		 */		
		public static function n2M(num:Number):String
		{
			var numStr:String = String(num);
			var temp:String = numStr.substr(0,numStr.length - 6) + "M";
			
			return temp;
		}
		/**
		 * 根据缩放平移坐标 
		 * @param p
		 * @return 
		 * 
		 */		
		public static function transPoint(p:Point):Point
		{
			var mouseXY:Point = p;
			var ma:Matrix = new Matrix;
			ma.scale(1/ReleaseUtil.SCALEX,1/ReleaseUtil.SCALEY);
			mouseXY = ma.transformPoint(mouseXY);
			
			return mouseXY;
		}
		
	}
}