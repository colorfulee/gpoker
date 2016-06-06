package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.configs.ShopItemConfigVO;
	
	import flash.utils.Dictionary;

	public class ShopItemConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :ShopItemConfig.as
		* date       :Jan 8, 2015
		* description:
		*/
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = new Array;
		public function ShopItemConfig()
		{
		}
		
		public function setData(xml:XML):void
		{
			var cvo:ShopItemConfigVO;
			for(var j:String in xml.base)
			{
				cvo = new ShopItemConfigVO;
				cvo.id = String(xml.base[j].shop_item_id);
				cvo.itemId = String(xml.base[j].item_id);
				cvo.initNum = Number(xml.base[j].num);
				cvo.img = String(xml.base[j].img);
				cvo.name = String(xml.base[j].name);
				cvo.desc = String(xml.base[j].desc);
				cvo.chip = Number(xml.base[j].cost_chip);
				cvo.coin = Number(xml.base[j].cost_coin);
				cvo.index = Number(xml.base[j].index);
				cvo.isHot = Number(xml.base[j].is_hot) == 1;
				cvo.isNew = Number(xml.base[j].is_new) == 1;
				_dic[uint(xml.base[j].id)] = cvo;
				_list.push(cvo);
			}
			
			_list.sortOn("index",Array.NUMERIC);
		}
		
		public function setDataVO(value:Object):void
		{
			setJsonData(value);
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:ShopItemConfigVO;
			for(var j:String in value)
			{
				cvo = new ShopItemConfigVO;
				cvo.id = String(value[j].shop_item_id);
				cvo.itemId = String(value[j].item_id);
				cvo.img = String(value[j].img);
				cvo.name = String(value[j].name);
				cvo.desc = String(value[j].desc);
				cvo.initNum = Number(value[j].num);
				cvo.chip = Number(value[j].cost_chip);
				cvo.coin = Number(value[j].cost_coin);
				cvo.index = Number(value[j].index);
				cvo.isHot = Number(value[j].is_hot) == 1;
				cvo.isNew = Number(value[j].is_new) == 1;
				_dic[cvo.id] = cvo;
				_list.push(cvo);
			}
			
			_list.sortOn("index",Array.NUMERIC);
		}
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemByID(id:uint):ShopItemConfigVO
		{
			return _dic[id];
		}
		
		/**
		 * 获取荷官列表 
		 * @return 
		 * 
		 */		
		public function getRoseList():Array
		{
			return _list.filter(filterRose);
		}
		
		private function filterRose(item:ShopItemConfigVO,index:int,arr:Array):Boolean
		{
			if((item.id).substr(0,3) == "802")
			{
				return true;
			}
			return false;
		}
		/**
		 * 获取桌子背景列表 
		 * @return 
		 * 
		 */		
		public function getTableList():Array
		{
			return _list.filter(filterTable);
		}
		
		private function filterTable(item:ShopItemConfigVO,index:int,arr:Array):Boolean
		{
			if((item.id).substr(0,3) == "801")
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 获取item列表 
		 * @return 
		 * 
		 */		
		public function getItemList():Array
		{
			return _list.filter(filterItem);
		}
		
		private function filterItem(item:ShopItemConfigVO,index:int,arr:Array):Boolean
		{
			if((item.id).substr(0,3) == "804")
			{
				return true;
			}
			return false;
		}
	}
}