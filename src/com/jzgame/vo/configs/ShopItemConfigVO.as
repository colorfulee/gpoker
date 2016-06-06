package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class ShopItemConfigVO extends ValueObject
	{
		/*auther     :jim
		* file       :ShopItemConfigVO.as
		* date       :Jan 4, 2015
		* description:
		*/
		public var id:String;
		public var itemId:String;
		public var chip:uint ;
		public var name:String ;
		public var img:String ;
		public var initNum:uint ;
		public var coin:uint ;
		public var desc:String="";
		public var index:uint;
		public var isHot:Boolean;
		public var isNew:Boolean;
		
		public function ShopItemConfigVO()
		{
			super();
		}
	}
}