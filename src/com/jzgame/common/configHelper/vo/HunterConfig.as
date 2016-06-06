package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.vo.HunterConfigVO;
	
	import flash.utils.Dictionary;
	
	public class HunterConfig implements IConfigHelper
	{
		/***********
		 * name:    HunterConfig
		 * data:    Sep 25, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _dic:Dictionary = new Dictionary;
		public function HunterConfig()
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
			var vo:HunterConfigVO;
			for(var i:String in value)
			{
				vo = new HunterConfigVO;
				for(var m:String in value[i])
				{
					if(vo.hasOwnProperty(m))
					{
						vo[m] = value[i][m];
					}
					
					if(value[i].cash)
					{
						for(var j:String in value[i].cash)
						{
							vo.cash = j + ":" + value[i].cash[j];
						}
					}
				}
				_dic[i] = vo;
			}
		}
		
		public function getItemById(id:String):HunterConfigVO
		{
			return _dic[id];
		}
	}
}