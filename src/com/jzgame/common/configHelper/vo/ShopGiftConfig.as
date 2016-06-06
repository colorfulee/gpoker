package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.configs.ShopGiftVO;
	
	import flash.utils.Dictionary;

	public class ShopGiftConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :ShopModel.as
		* date       :Jan 4, 2015
		* description:
		*/
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = new Array;
		public function ShopGiftConfig()
		{
		}
		
		/**
		 * 
		 * @param xml
		 * 
		 */
		public function setData(xml:XML):void
		{
			var cvo:ShopGiftVO;
			for(var j:String in xml.base)
			{
				cvo = new ShopGiftVO;
				cvo.id = String(xml.base[j].shop_gift_id);
				cvo.itemId = String(xml.base[j].gift_id);
				cvo.initNum = Number(xml.base[j].gift_num);
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
			var cvo:ShopGiftVO;
			for(var j:String in value)
			{
				cvo = new ShopGiftVO;
				cvo.id = String(value[j].shop_gift_id);
				cvo.itemId = String(value[j].gift_id);
				cvo.initNum = Number(value[j].gift_num);
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
		 *  过滤金币
		 * @param element
		 * @param index
		 * @param arr
		 * @return 
		 * 
		 */		
		private function coinFilter(element:ShopGiftVO,index:uint,arr:Array):Boolean
		{
			return element.coin > 0;
		}
		/**
		 * 过滤筹码 
		 * @param element
		 * @param index
		 * @param arr
		 * @return 
		 * 
		 */		
		private function chipFilter(element:ShopGiftVO,index:uint,arr:Array):Boolean
		{
			return element.chip > 0;
		}
		
		private var _filterType:uint;
		/**
		 * 获取类型 
		 * @param type
		 * @return 
		 * 
		 */		
		public function getTyeList(type:uint,chipF:Boolean,coinF:Boolean):Array
		{
			var tempList:Array;
			
			if(type == 0) 
			{
				tempList = getList();
			}else
			{
				_filterType = type;
				tempList = _list.filter(typeFilter);
			}
			
			if(chipF)
			{
				tempList = tempList.filter(chipFilter);
			}
			if(coinF)
			{
				tempList = tempList.filter(coinFilter);
			}
			
			return tempList;
		}
		/**
		 * 类型过滤 
		 * @param ele
		 * @param index
		 * @param arr
		 * @return 
		 * 
		 */		
		private function typeFilter(ele:ShopGiftVO,index:uint,arr:Array):Boolean
		{
			return Configure.giftConfig.getItemById(ele.itemId).type == _filterType
		}
		/**
		 *  
		 * @return 
		 * 
		 */		
		public function getList():Array
		{
			return _list;
		}
		
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getShopById(id:String):ShopGiftVO
		{
			return _dic[id];
		}
	}
}