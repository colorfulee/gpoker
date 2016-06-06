package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.util.ItemStringUtil;
	import com.jzgame.vo.configs.PlayerLevelVO;
	
	import flash.utils.Dictionary;
	
	public class PlayerLevel implements IConfigHelper
	{
		/*auther     :jim
		* file       :PlayerLevel.as
		* date       :Feb 2, 2015
		* description:玩家等级对应称号经验
		*/
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = [];
//		<id>22</id>
//			<level>22</level>
//			<title>World-class Player</title>
//			<exp>326416</exp>
//			<bonus>3003:2,4002:5</bonus>
		public function PlayerLevel()
		{
		}
		
		public function setData(xml:XML):void
		{
			var cvo:PlayerLevelVO;
			for(var j:String in xml.base)
			{
				cvo = new PlayerLevelVO;
				cvo.id    = String(xml.base[j].id);
				cvo.level = uint(xml.base[j].level);
				cvo.bonus = String(xml.base[j].bonus);
				cvo.title = String(xml.base[j].title);
				cvo.exp   = Number(xml.base[j].exp);
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
			var cvo:PlayerLevelVO;
			for(var j:String in value)
			{
				cvo = new PlayerLevelVO;
				cvo.id    = String(value[j].id);
				cvo.level = uint(value[j].level);
				var arr:Array = [];
				for(var m:String in value[j].bonus)
				{
					arr.push(m+":"+value[j].bonus[m]);
				}
				cvo.bonus= arr.join(",");
				cvo.title = String(value[j].title);
				cvo.exp   = Number(value[j].exp);
				_dic[cvo.id] = cvo;
				_list.push(cvo);
			}
		}
		/**
		 * 根据经验值获得等级 
		 * @param exp
		 * @return 
		 * 
		 */		
		public function getLevelByExp(exp:Number):uint
		{
			var level:uint = 1;
			var cvo:PlayerLevelVO;
			for (var i:String in _list)
			{
				cvo = _list[i];
				if(cvo.exp <= exp)
				{
					level = cvo.level;
				}else
				{
					return level;
				}
			}
			return 1;
		}
		/**
		 * 根据经验值获得称号
		 * @param exp
		 * @return 
		 * 
		 */		
		public function getTitleByExp(exp:Number):String
		{
			var level:String = "";
			var cvo:PlayerLevelVO;
			for (var i:String in _list)
			{
				cvo = _list[i];
				if(cvo.exp <= exp)
				{
					level = cvo.title;
				}
			}
			return level;
		}
		/**
		 * 根據等級獲取稱號 
		 * @param level
		 * @return 
		 * 
		 */		
		public function getTitleByLevel(level:Number):String
		{
			var title:String = "";
			var cvo:PlayerLevelVO;
			for (var i:String in _list)
			{
				cvo = _list[i];
				if(cvo.level == level)
				{
					title = cvo.title;
					return title;
				}
			}
			return title;
		}
		/**
		 * 根据等级获取经验
		 * @param level
		 * @return 
		 * 
		 */		
		public function getExpByLevel(level:uint):Number
		{
			if(_dic.hasOwnProperty(level.toString()))
			{
				return _dic[level].exp;
			}
			return 0;
		}
		
		/**
		 * 
		 * @param level
		 * @return 
		 * 
		 */		
		public function getBonusByLevel(level:String):String
		{
			var cvo:PlayerLevelVO = _dic[level];
			if(cvo.bonus)
			{
				return ItemStringUtil.getItemString(cvo.bonus);
			}
			
			return "";
		}
	}
}