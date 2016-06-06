package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.vo.LanguageVO;
	
	import flash.utils.Dictionary;

	public class ErrorCode implements IConfigHelper
	{
		/*auther     :jim
		* file       :ErrorCode.as
		* date       :Nov 18, 2014
		* description:
		*/
		private var _dic:Dictionary = new Dictionary;
		public function ErrorCode()
		{
		}
		
		/**
		 * 
		 * @param xml
		 * 
		 */		
		public function setData(xml:XML):void
		{
			var cvo:LanguageVO;
			for(var j:String in xml.item)
			{
				cvo = new LanguageVO;
				cvo.id       = xml.item[j].@id;
				cvo.text     = xml.item[j];
				_dic[cvo.id] = cvo;
			}
		}
		
		/**
		 * 设置release配置 
		 * @param value
		 * 
		 */		
		public function setDataVO(value:Object):void
		{
			var obj:Object;
			var cvo:LanguageVO;
			
			for each(obj in value.source)
			{
				cvo = new LanguageVO;
				cvo.id       = obj.id;
				cvo.text     = obj.text;
				_dic[cvo.id] = cvo;
			}
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:LanguageVO;
			for(var j:String in value)
			{
				cvo = new LanguageVO;
				cvo.id       = value[j].@id;
				cvo.text     = value[j];
				_dic[cvo.id] = cvo;
			}
		}
		
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getText(id:String):String
		{
			return _dic[id].text;
		}
	}
}