package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.vo.SevenLoginBonus;
	
	import flash.utils.Dictionary;
	
	public class SevenLoginBonusConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :MTTConfig.as
		* date       :Apr 21, 2015
		* description:MTT 
		*/
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = [];
		public function SevenLoginBonusConfig()
		{
		}
		
		public function setData(xml:XML):void
		{
		}
		
		public function setDataVO(value:Object):void
		{
		}
		
		public function setJsonData(value:Object):void
		{
			for(var index:String in value)
			{
				var vo:SevenLoginBonus = new SevenLoginBonus;
				var source:Object = value[index];
				vo.day = source.num;
				vo.id = source.id;
				var arr:Array = [];
				for(var uu:String in source.bonus)
				{
					arr.push(uu+":"+source.bonus[uu]);
				}
				vo.bonus.push(arr.join(","));
				_dic[index] = vo;
				
				_list.push(vo);
			}
		}
		
		public function getItemLists():Array
		{
			return _list;
		}
		
		public function getItemById(index:String):SevenLoginBonus
		{
			return _dic[index];
		}
	}
}