package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.vo.SpeMTTConfigVO;
	
	import flash.utils.Dictionary;
	
	public class SpeMTTConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :SpeMTTConfig.as
		* date       :Apr 21, 2015
		* description:MTT 
		*/
		private var _dic:Dictionary = new Dictionary;
		public function SpeMTTConfig()
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
				var mtt:SpeMTTConfigVO = new SpeMTTConfigVO;
				var source:Object = value[index];
				mtt.name = source.name;
				mtt.icon = source.icon;
				mtt.type = source.type;
				mtt.id = source.id;
				mtt.reward = source.reward;
				for(var j:String in source.cost_item)
				{
					mtt.cost_item = j+":"+source.cost_item[j];
					break;
				}
				for(var uu:String in source.bonus)
				{
					var arr:Array = [];
					for(var m:String in source.bonus[uu])
					{
						arr.push(m+":"+source.bonus[uu][m]);
					}
					mtt.bonus.push(arr.join(","));
				}
				_dic[index] = mtt;
			}
		}
		
		public function getItemById(index:String):SpeMTTConfigVO
		{
			return _dic[index];
		}
	}
}