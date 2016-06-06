package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.configs.VipConfigVO;
	
	import flash.utils.Dictionary;
	
	public class VipConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :VipConfig.as
		* date       :Jan 14, 2015
		* description:vip 表
		*/
		private var _dic:Dictionary = new Dictionary;
		public function VipConfig()
		{
		}
		
		/**
		 * 
		 * @param xml
		 * 
		 */
		public function setData(xml:XML):void
		{
			//		<id>7001</id>
			//			<name>VIP Metal</name>
			//			<desc>1. valid in 30 days &lt;br&gt; 2.valid in 30 days&lt;/br&gt;</desc>
			//			<img>item_VIPMetal.png</img>
			//			<type>0</type>
			//			<effect>0</effect>
			//			<time>2592000</time>
			//			<expired>0</expired>
			var cvo:VipConfigVO;
			for(var j:String in xml.base)
			{
				cvo = new VipConfigVO;
				cvo.id = String(xml.base[j].id);
				cvo.effect = Number(xml.base[j].effect) == 1;
				cvo.time = Number(xml.base[j].time);
				cvo.desc = String(xml.base[j].desc);
				cvo.name = String(xml.base[j].name);
				cvo.img = String(xml.base[j].img);
				cvo.expired = Number(xml.base[j].expired) == 1;
				_dic[uint(xml.base[j].id)] = cvo;
			}
		}
		
		public function setDataVO(value:Object):void
		{
			setJsonData(value);
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:VipConfigVO;
			for(var j:String in value)
			{
				cvo = new VipConfigVO;
				
				cvo.id = String(value[j].id);
				cvo.desc = String(value[j].desc);
				cvo.index = int(value[j].index);
				cvo.name = String(value[j].name);
				cvo.img = String(value[j].img);
				_dic[cvo.id] = cvo;
			}
			
			
		}
		
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemById(id:String):VipConfigVO
		{
			return _dic[id];
		}
	}
}