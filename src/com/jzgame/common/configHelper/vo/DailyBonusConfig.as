package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.DailyBonusItemVO;
	
	import flash.utils.Dictionary;
	
	public class DailyBonusConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :DailyBonusConfig.as
		* date       :Jan 23, 2015
		* description:日常任务配置
		*/
		
//		<id>10003</id>
//			<name>MTT模式*2</name>
//			<desc>在MTT模式中玩2盘</desc>
//			<num>2</num>
//			<type>3</type>
//			<bonus>101:1,4001:2</bonus>
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = [];
		public function DailyBonusConfig()
		{
		}
		
		public function get list():Array
		{
			return _list;
		}

		public function setData(xml:XML):void
		{
			for(var j:String in xml.base)
			{
				var vo:DailyBonusItemVO = new DailyBonusItemVO;
				vo.id = String(xml.base[j].id);
				vo.title = String(xml.base[j].name);
				vo.des = String(xml.base[j].desc);
				vo.target = Number(xml.base[j].num);
				_dic[vo.id] = vo;
				_list.push( vo );
			}
		}
		
		public function setDataVO(value:Object):void
		{
			setJsonData(value);
		}
		
		public function setJsonData(value:Object):void
		{
			for(var j:String in value)
			{
				var vo:DailyBonusItemVO = new DailyBonusItemVO;
				vo.id = String(value[j].id);
				vo.title = String(value[j].name);
				vo.des = String(value[j].desc);
				vo.target = Number(value[j].num);
				_dic[vo.id] = vo;
				_list.push( vo );
			}
		}
		/**
		 * 获取vo 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemById(id:String):DailyBonusItemVO
		{
			return _dic[id];
		}
	}
}