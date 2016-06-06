package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.vo.MTTConfigVO;
	import com.jzgame.common.vo.PackageItemConfigVO;
	
	import flash.utils.Dictionary;
	
	public class PackageItemConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :PackageItemConfig.as
		* date       :Apr 21, 2015
		* description:礼包 
		*/
		private var _dic:Dictionary = new Dictionary;
		public function PackageItemConfig()
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
				var pack:PackageItemConfigVO = new PackageItemConfigVO;
				var source:Object = value[index];
				pack.name = source.name;
				pack.desc = source.desc;
				pack.auto_use = source.auto_use;
				pack.img = source.img;
				pack.id = source.id;
				for(var uu:String in source.bonus)
				{
					var arr:Array = [];
					arr.push(uu+":"+source.bonus[uu]);
				}
				pack.bonus.push(arr.join(","));
				_dic[index] = pack;
			}
		}
		
		public function getItemById(index:String):PackageItemConfigVO
		{
			return _dic[index];
		}
	}
}