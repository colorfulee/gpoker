package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.configs.ItemConfigVO;
	
	import flash.utils.Dictionary;

	public class ItemConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :ItemModel.as
		* date       :Dec 24, 2014
		* description:物品表
		*/
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = [];
		public function ItemConfig()
		{
		}
		
		/**
		 * 
		 * @param xml
		 * 
		 */
		public function setData(xml:XML):void
		{
			var cvo:ItemConfigVO;
			for(var j:String in xml.base)
			{
				cvo = new ItemConfigVO;
				cvo.id = String(xml.base[j].id);
				cvo.des = String(xml.base[j].desc);
				cvo.name = String(xml.base[j].name);
				cvo.img = String(xml.base[j].img);
				cvo.manual = uint(xml.base[j].manual);
				_dic[uint(xml.base[j].id)] = cvo;
				_list.push(cvo);
			}
		}
		
		public function setDataVO(value:Object):void
		{
			setJsonData(value);
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:ItemConfigVO;
			for(var j:String in value)
			{
				cvo = new ItemConfigVO;
				cvo.id = String(value[j].id);
				cvo.des = String(value[j].desc);
				cvo.name = String(value[j].name);
				cvo.img = String(value[j].img);
				cvo.manual = uint(value[j].manual);
				_dic[cvo.id] = cvo;
			}
		}
		
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemById(id:String):ItemConfigVO
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
		
		private function filterRose(item:ItemConfigVO,index:int,arr:Array):Boolean
		{
			if(Math.floor(Number(item.id) / 1000) == 2)
			{
				return true;
			}
			return false;
		}
	}
}