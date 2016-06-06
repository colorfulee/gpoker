package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class ShopGiftVO extends ValueObject
	{
		/*auther     :jim
		* file       :ShopGiftVO.as
		* date       :Jan 4, 2015
		* description:
		*/
		public var id:String;
		public var itemId:String;
		public var chip:uint ;
		public var initNum:uint ;
		public var coin:uint ;
		public var index:uint;
		public var isHot:Boolean;
		public var isNew:Boolean;
		public var time:Number;
		public function ShopGiftVO()
		{
			super();
		}
	}
}