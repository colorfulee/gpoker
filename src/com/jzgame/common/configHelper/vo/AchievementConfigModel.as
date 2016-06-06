package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.vo.AchievementConfigVO;
	import com.jzgame.common.vo.AchievementVO;
	import com.jzgame.vo.PlayerDetailVO;
	
	import flash.utils.Dictionary;

	public class AchievementConfigModel implements IConfigHelper
	{
		/*auther     :jim
		* file       :AchievementConfigModel.as
		* date       :Dec 22, 2014
		* description:
		*/
		private var _dic:Dictionary = new Dictionary;
		private var _list:Array = new Array;
		public function AchievementConfigModel()
		{
		}
		
		/**
		 * 
		 * @param xml
		 * 
		 */
		public function setData(xml:XML):void
		{
			var cvo:AchievementConfigVO;
			for(var j:String in xml.base)
			{
				cvo = new AchievementVO;
				cvo.id = String(xml.base[j].id);
				cvo.level = String(xml.base[j].level);
				cvo.bonus = String(xml.base[j].bonus);
				cvo.desc = String(xml.base[j].desc);
				cvo.name = String(xml.base[j].name);
				cvo.firstlabel = String(xml.base[j].firstlabel);
				cvo.secondlabel = String(xml.base[j].secondlabel);
				cvo.point = String(xml.base[j].point);
				cvo.type = String(xml.base[j].type);
				cvo.achi_desc = String(xml.base[j].achi_desc);
				cvo.img = String(xml.base[j].img);
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
			var cvo:AchievementConfigVO;
			for(var j:String in value)
			{
				cvo = new AchievementVO;
				cvo.id = String(value[j].id);
				cvo.level = String(value[j].level);
				var arr:Array = [];
				for(var m:String in value[j].bonus)
				{
					arr.push(m+":"+value[j].bonus[m]);
				}
				cvo.bonus= arr.join(AssetsCenter.COMMA);
				
				cvo.desc = String(value[j].desc);
				cvo.name = String(value[j].name);
				cvo.firstlabel = String(value[j].firstlabel);
				cvo.secondlabel = String(value[j].secondlabel);
				cvo.point = String(value[j].point);
				cvo.type = String(value[j].type);
				cvo.achi_desc = String(value[j].achi_desc);
				cvo.img = String(value[j].img);
				_dic[uint(value[j].id)] = cvo;
				
				_list.push(cvo);
			}
		}
		private var _first:uint = 0;
		private var _second:uint = 0;
		
		private function typeFilter(ele:AchievementVO,index:uint, arr:Array):Boolean
		{
			if(_second == 0)
			{
				return ele.firstlabel == _first.toString();
			}
			return (ele.firstlabel == _first.toString() && _second.toString() == ele.secondlabel);
		}
		/**
		 * 更新当前
		 * @param value
		 * 
		 */		
		public function updateCurrent(value:PlayerDetailVO,isMine:Boolean):void
		{
			for(var i:String in _list)
			{
				
				//				5 筹码总数达到XXX 6 玩的总局数达到XXX 7 胜利的总局数达到XXX 8 失败的总局数达到XXX 9 游戏内好友数量达到XXX 10 FB邀请好友数量达到XXX 11 送出礼物的次数达到XXX 12 收到礼物的次数达到XXX 
				var vo:AchievementVO = _list[i];
				vo.isMine = isMine;
				switch(uint(vo.type))
				{
					case 2:
						vo.current = value.level;
						break;
					case 5:
						vo.current = value.chip;
						break;
					case 6:
						vo.current = Number(value.rounds.split(AssetsCenter.LEFT)[1]);
						break;
					case 7:
						vo.current = value.winning;
						break;
					case 8:
						vo.current = value.failed_num;
						break;
					case 9:
						vo.current = value.friends_total;
						break;
					case 10:
						vo.current = value.invite_total;
						break;
					case 11:
						vo.current = value.send_gift_num;
						break;
					case 12:
						vo.current = value.accept_gift_num;
						break;
				}
			}
		}
		/**
		 * 查找列表根据标签
		 * @return 
		 * 
		 */		
		public function getList(first:uint,second:uint):Array
		{
			if(first == 0 && second == 0)
			{
				return _list;
			}
			_first = first;
			_second = second;
			return _list.filter(typeFilter);
//			return _list;
		}
		/**
		 * 获取长度 
		 * @return 
		 * 
		 */		
		public function getLength(first:uint,second:uint):uint
		{
			return getList(first,second).length;
		}
		
		/**
		 * 根据成就id获取成就信息
		 * @param id
		 * @return 
		 * 
		 */		
		public function getAchievementById(id:String):AchievementVO
		{
			return _dic[id];
		}
		
		/**
		 * 获取最近完成的列表
		 * @return 
		 * 
		 */		
		public function getRecentThreeAchievements():Array
		{
			var temp:Array = _list.concat();
			var list:Array = temp.filter(typeRecentFilter);
			list.sortOn("finish_time",Array.DESCENDING);
			var recent:Array = list.splice(0,5);
			return recent;
		}
		
		private function typeRecentFilter(ele:AchievementVO,index:uint, arr:Array):Boolean
		{
			return (Number(ele.status) >= 1);
		}
	}
}