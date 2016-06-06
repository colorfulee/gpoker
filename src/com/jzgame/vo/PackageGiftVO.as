package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class PackageGiftVO extends ValueObject
	{
		/*auther     :jim
		* file       :PackageGiftVO.as
		* date       :Jan 6, 2015
		* description:
		*/
		//自己购买个数包括别人赠送
		public var num:uint = 0;
		//成就获得的个数
		public var acNum:uint = 0;
		//
		public var id:String = "";
		//时间
		public var time:Number = 0;
		
		public function PackageGiftVO()
		{
			super();
		}
		
		public function get allNum():Number
		{
			return num + acNum;
		}
	}
}