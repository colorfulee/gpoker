package com.jzgame.model
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.configs.ShopGiftVO;
	
	import flash.utils.Dictionary;

	public class ShopGiftModel implements IConfigHelper
	{
		/*auther     :jim
		* file       :ShopGiftModel.as
		* date       :Jan 4, 2015
		* description:
		*/
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = new Array;
		public function ShopGiftModel()
		{
		}
		
		/**
		 * 
		 * @param xml
		 * 
		 */
		public function setData(xml:XML):void
		{
//			<shop_gift_id>803001</shop_gift_id>
//				<gift_id>3001</gift_id>
//				<gift_num>1</gift_num>
//				<cost_chip>100</cost_chip>
//				<cost_coin>0</cost_coin>
//				<index>0</index>
//				<is_hot>0</is_hot>
//				<is_new>0</is_new>
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
				cvo.time = Number(xml.base[j].time);
				
				_dic[uint(xml.base[j].id)] = cvo;
				_list.push(cvo);
			}
			
			_list.sortOn("index",Array.NUMERIC);
		}
	}
}