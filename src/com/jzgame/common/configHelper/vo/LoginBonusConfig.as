package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.configs.LoginBonusVO;
	
	import flash.utils.Dictionary;
	
	public class LoginBonusConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :LoginBonusConfig.as
		* date       :Jan 26, 2015
		* description:每日奖励配置
		*/
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = [];
		public function LoginBonusConfig()
		{
		}
		
		public function setData(xml:XML):void
		{
			var cvo:LoginBonusVO;
			for(var j:String in xml.base)
			{
				cvo = new LoginBonusVO;
				cvo.num = Number(xml.base[j].num)
				cvo.id = String(xml.base[j].id);
				cvo.bonus= String(xml.base[j].bonus);
				_dic[uint(xml.base[j].id)] = cvo;
				_list.push(cvo);
			}
		}
		
		public function setDataVO(value:Object):void
		{
			setJsonData(value);
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:LoginBonusVO;
			for(var j:String in value)
			{
				cvo = new LoginBonusVO;
				cvo.num = Number(value[j].num)
				cvo.id = String(value[j].id);
				var arr:Array = [];
				for(var m:String in value[j].bonus)
				{
					arr.push(m+":"+value[j].bonus[m]);
				}
				cvo.bonus= arr.join(",");
				_dic[uint(value[j].id)] = cvo;
				_list.push(cvo);
			}
			
			_list.sortOn("num",Array.NUMERIC);
		}
		/**
		 * 获取列表 
		 * @return 
		 * 
		 */		
		public function getList():Array
		{
			return _list;
		}
	}
}