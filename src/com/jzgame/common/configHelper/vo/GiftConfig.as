package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.configs.GiftConfigVO;
	
	import flash.utils.Dictionary;
	
	public class GiftConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :GiftConfig.as
		* date       :Jan 12, 2015
		* description:
		*/
		private var _dic:Dictionary = new Dictionary;
		public function GiftConfig()
		{
		}
		
		public function setData(xml:XML):void
		{
			var cvo:GiftConfigVO;
			for(var j:String in xml.base)
			{
				cvo = new GiftConfigVO;
				cvo.id = String(xml.base[j].id);
				cvo.desc = String(xml.base[j].desc);
				cvo.name = String(xml.base[j].name);
				cvo.img = String(xml.base[j].img);
				cvo.time = Number(xml.base[j].time);
				cvo.type = uint(xml.base[j].type);
				cvo.expired = uint(xml.base[j].expired);
				_dic[uint(xml.base[j].id)] = cvo;
			}
		}
		
		public function setDataVO(value:Object):void
		{
			setJsonData(value);
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:GiftConfigVO;
			for(var j:String in value)
			{
				cvo = new GiftConfigVO;
				cvo.id = String(value[j].id);
				cvo.desc = String(value[j].desc);
				cvo.name = String(value[j].name);
				cvo.img = String(value[j].img);
				cvo.time = Number(value[j].time);
				cvo.type = uint(value[j].type);
				cvo.expired = uint(value[j].expired);
				_dic[uint(value[j].id)] = cvo;
			}
		}
		
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemById(id:String):GiftConfigVO
		{
			return _dic[id];
		}
	}
}