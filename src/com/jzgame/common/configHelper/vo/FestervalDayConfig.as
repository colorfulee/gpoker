package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.vo.FestervalDayVO;
	
	import flash.utils.Dictionary;
	
	public class FestervalDayConfig implements IConfigHelper
	{
		/***********
		 * name:    FestervalDayConfig
		 * data:    Sep 25, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _dic:Dictionary = new Dictionary;
		public function FestervalDayConfig()
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
			var vo:FestervalDayVO;
			for(var i:String in value)
			{
				vo = new FestervalDayVO;
				for(var m:String in value[i])
				{
					if(vo.hasOwnProperty(m))
					{
						vo[m] = value[i][m];
					}
				}
				_dic[i] = vo;
			}
		}
		
		public function getItemById(id:String):FestervalDayVO
		{
			return _dic[id];
		}
	}
}