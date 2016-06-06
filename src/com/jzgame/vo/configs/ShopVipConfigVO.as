package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class ShopVipConfigVO extends ValueObject
	{
		/*auther     :jim
		* file       :ShopVipConfigVO.as
		* date       :Jan 14, 2015
		* description:
		*/
		
//		<shop_item_id>807001</shop_item_id>
//			<item_id>7001</item_id>
//			<num>1</num>
//			<cost_chip>0</cost_chip>
//			<cost_coin>50</cost_coin>
//			<index>0</index>
//			<for_sale>0</for_sale>
//			<is_hot>0</is_hot>
//			<is_new>0</is_new>

		public var id:String;
		public var itemId:String;
		public var initNum:uint;
		public var chip:Number;
		public var coin:Number;
		public var index:Number;
		public var forSale:Boolean;
		public var isHot:Boolean;
		public var isNew:Boolean;
		
		public function ShopVipConfigVO()
		{
			super();
		}
	}
}