package com.jzgame.util
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.vo.PackageItemConfigVO;
	import com.jzgame.vo.configs.GiftConfigVO;
	import com.jzgame.vo.configs.ItemConfigVO;
	import com.jzgame.vo.configs.VipConfigVO;

	public class ItemStringUtil
	{
		/*auther     :jim
		* file       :ItemStringUtil.as
		* date       :Apr 21, 2015
		* description:
		*/
		public static var CHIP:String = "101";
		public static var EXP:String = "103";
		public function ItemStringUtil()
		{
		}
		/**
		 * 
		 * @param value
		 * @return 
		 * 
		 */		
		public static function getBonusString(value:Object):String
		{
			var arr:Array = [];
			for(var m:String in value)
			{
				arr.push(m+":"+value[m]);
			}
			return arr.join(",");
		}
		/**
		 * 获取奖励的列表 
		 * @param str
		 * @return 
		 * 
		 */		
		public static function getItemString(str:String):String
		{
			var content:Array =[];
			var list:Array = str.split(AssetsCenter.COMMA);
			for each(var item:String in list)
			{
				var id:String = item.split(AssetsCenter.COLON)[0];
				var num:String = item.split(AssetsCenter.COLON)[1];
				var name:String = "";
				switch(Configure.getItemType(id))
				{
					case Configure.BASE:
					case Configure.ITEM:
						var itemPrize:ItemConfigVO = Configure.itemConfig.getItemById(id);
						name = itemPrize.name;
						break;
					case Configure.VIP:
						var vipitem:VipConfigVO = Configure.vipConfig.getItemById(id);
						name = vipitem.name;
						break;
					
					case Configure.GIFT:
						var giftitem:GiftConfigVO = Configure.giftConfig.getItemById(id);
						name = giftitem.name;
						break;
				}
				content.push( NumUtil.n2kb(Number(num)) +" "+ name );
			}
			return content.join("+");
		}
		/**
		 * 获取物品的描述 
		 * @param str
		 * @return 
		 * 
		 */		
		public static function getItemDes(item:String,item_num:String):String
		{
			var content:Array =[];
				var id:String = item;
				var num:String = item_num;
				var name:String = "";
				switch(Configure.getItemType(id))
				{
					case Configure.BASE:
					case Configure.ITEM:
						var itemPrize:ItemConfigVO = Configure.itemConfig.getItemById(id);
						name = itemPrize.name;
						break;
					case Configure.VIP:
						var vipitem:VipConfigVO = Configure.vipConfig.getItemById(id);
						name = vipitem.name;
						break;
					
					case Configure.GIFT:
						var giftitem:GiftConfigVO = Configure.giftConfig.getItemById(id);
						name = giftitem.name;
						break;
					case Configure.PACK:
						var pack:PackageItemConfigVO = Configure.packItemConfig.getItemById(id);
						name = pack.name;
						break;
				}
				content.push( name +"*"+NumUtil.n2kb(Number(num)));
			return content.join("+");
		}
		/**
		 * 获取物品的名称 
		 * @param str
		 * @return 
		 * 
		 */		
		public static function getItemDesName(item:String):String
		{
			var id:String = item;
			var name:String = "";
			switch(Configure.getItemType(id))
			{
				case Configure.BASE:
				case Configure.ITEM:
					var itemPrize:ItemConfigVO = Configure.itemConfig.getItemById(id);
					name = itemPrize.name;
					break;
				case Configure.VIP:
					var vipitem:VipConfigVO = Configure.vipConfig.getItemById(id);
					name = vipitem.name;
					break;
				
				case Configure.GIFT:
					var giftitem:GiftConfigVO = Configure.giftConfig.getItemById(id);
					name = giftitem.name;
					break;
				case Configure.PACK:
					var pack:PackageItemConfigVO = Configure.packItemConfig.getItemById(id);
					name = pack.name;
					break;
			}
			return name;
		}		
		/**
		* 获取描述
		* @param item
		* @return 
		* 
		*/		
		public static function getItemDesc(item:String):String
		{
			var id:String = item;
			var name:String = "";
			switch(Configure.getItemType(id))
			{
				case Configure.BASE:
				case Configure.ITEM:
					var itemPrize:ItemConfigVO = Configure.itemConfig.getItemById(id);
					name = itemPrize.des;
					break;
				case Configure.VIP:
					var vipitem:VipConfigVO = Configure.vipConfig.getItemById(id);
					name = vipitem.desc;
					break;
				
				case Configure.GIFT:
					var giftitem:GiftConfigVO = Configure.giftConfig.getItemById(id);
					name = giftitem.desc;
					break;
				case Configure.PACK:
					var pack:PackageItemConfigVO = Configure.packItemConfig.getItemById(id);
					name = pack.desc;
					break;
			}
			return name;
		}
		
		/**
		 * 获取物品的图片地址
		 * @param str
		 * @return 
		 * 
		 */		
		public static function getItemImage(item:String):String
		{
			var id:String = item;
			var name:String = "";
			switch(Configure.getItemType(id))
			{
				case Configure.BASE:
				case Configure.ITEM:
					var itemPrize:ItemConfigVO = Configure.itemConfig.getItemById(id);
					name = itemPrize.img;
					break;
				case Configure.VIP:
					var vipitem:VipConfigVO = Configure.vipConfig.getItemById(id);
					name = vipitem.img;
					break;
				
				case Configure.GIFT:
					var giftitem:GiftConfigVO = Configure.giftConfig.getItemById(id);
					name = giftitem.img;
					break;
				case Configure.PACK:
					var pack:PackageItemConfigVO = Configure.packItemConfig.getItemById(id);
					name = pack.img;
					break;
			}
			return name;
		}
	}
}