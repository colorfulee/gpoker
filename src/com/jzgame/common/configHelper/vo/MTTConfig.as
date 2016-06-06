package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.vo.MTTConfigVO;
	
	import flash.utils.Dictionary;
	
	public class MTTConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :MTTConfig.as
		* date       :Apr 21, 2015
		* description:MTT 
		*/
		private var _dic:Dictionary = new Dictionary;
		public function MTTConfig()
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
				var mtt:MTTConfigVO = new MTTConfigVO;
				var source:Object = value[index];
				mtt.name = source.name;
				mtt.icon = source.icon;
				mtt.type = source.type;
				mtt.id = source.id;
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
		
		public function getItemById(index:String):MTTConfigVO
		{
			return _dic[index];
		}
	}
}