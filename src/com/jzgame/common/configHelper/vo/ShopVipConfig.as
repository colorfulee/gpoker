package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.configs.ShopVipConfigVO;
	
	import flash.utils.Dictionary;
	
	public class ShopVipConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :ShopVipConfig.as
		* date       :Jan 14, 2015
		* description:
		*/
		
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = new Array;
		public function ShopVipConfig()
		{
		}
		
		public function setData(xml:XML):void
		{
			var cvo:ShopVipConfigVO;
			for(var j:String in xml.base)
			{
				cvo = new ShopVipConfigVO;
				cvo.id = String(xml.base[j].shop_item_id);
				cvo.itemId = String(xml.base[j].item_id);
				cvo.initNum = Number(xml.base[j].num);
				cvo.chip = Number(xml.base[j].cost_chip);
				cvo.coin = Number(xml.base[j].cost_coin);
				cvo.index = Number(xml.base[j].index);
				cvo.forSale = Number(xml.base[j].for_sale) == 1;
				cvo.isHot = Number(xml.base[j].is_hot) == 1;
				cvo.isNew = Number(xml.base[j].is_new) == 1;
				_dic[uint(xml.base[j].id)] = cvo;
				_list.push(cvo);
			}
			
			_list.sortOn("index",Array.NUMERIC);
		}
		/**
		 * 设置release 
		 * @param value
		 * 
		 */		
		public function setDataVO(value:Object):void
		{
			setJsonData(value);
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:ShopVipConfigVO;
			for(var j:String in value)
			{
				cvo = new ShopVipConfigVO;
				cvo.id = String(value[j].shop_item_id);
				cvo.itemId = String(value[j].item_id);
				cvo.initNum = Number(value[j].num);
				cvo.chip = Number(value[j].cost_chip);
				cvo.coin = Number(value[j].cost_coin);
				cvo.index = Number(value[j].index);
				cvo.forSale = Number(value[j].for_sale) == 1;
				cvo.isHot = Number(value[j].is_hot) == 1;
				cvo.isNew = Number(value[j].is_new) == 1;
				_dic[cvo.id] = cvo;
				_list.push(cvo);
			}
			
			_list.sortOn("index",Array.NUMERIC);
		}
		
		public function getItemById(id:uint):ShopVipConfigVO
		{
			return _dic[id]
		}
		
		public function get list():Array
		{
			return _list;
		}
	}
}