package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.configs.BackgroundVO;
	
	public class BackGroundConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :BackGroundConfig.as
		* date       :Feb 2, 2015
		* description:桌子背景配置
		*/
		private var _list:Array = [];
		public function BackGroundConfig()
		{
		}
		
		public function setData(xml:XML):void
		{
//			<id>1002</id>
//				<name>bg2</name>
//				<cost_chip>1000</cost_chip>
//				<index>0</index>
//				<is_new>0</is_new>
//				<is_hot>0</is_hot>
			for(var j:String in xml.base)
			{
				var vo:BackgroundVO = new BackgroundVO;
				vo.id = String(xml.base[j].id);
				vo.name = String(xml.base[j].name);
				vo.img = String(xml.base[j].img);
				vo.desc = String(xml.base[j].desc);
				vo.index = Number(xml.base[j].index);
				vo.is_new = Number(xml.base[j].is_new) == 1;
				vo.is_hot = Number(xml.base[j].num) == 1;
				_list.push( vo );
			}
		}
		
		public function setDataVO(value:Object):void
		{
		}
		
		public function setJsonData(value:Object):void
		{
		}
		
		public function getList():Array
		{
			return _list;
		}
	}
}