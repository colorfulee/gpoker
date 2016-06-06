package com.jzgame.model
{
	import com.jzgame.vo.RankListItemVO;
	import com.jzgame.vo.RankMyInfoVO;
	
	public class RankModel
	{
		/*auther     :jim
		* file       :RankModel.as
		* date       :Jan 21, 2015
		* description:
		*/
//		all代表所有的玩家排名
		private var _allAchieve:Array = [];
		private var _allLevel:Array = [];
		private var _allChip:Array = [];
		private var _friendChip:Array = [];
		private var _friendAchieve:Array = [];
		private var _friendLevel:Array = [];
		//我的成就排名信息
		public var myAchieveInfo:RankMyInfoVO;
		//我的筹码排名信息
		public var myChipInfo:RankMyInfoVO;
		//我的等级排名信息
		public var myLevelInfo:RankMyInfoVO;
		public var dailyStar1:Array =[];
		public var dailyStar2:Array = [];
		
		//神秘好礼礼券
		public var misteryTicket:Number = 0;
		//神秘好礼礼券排行
		public var misteryTicketRank:Number = 0;
		//总礼券
		public var misteryTotalTicket:Number = 0;
		public var misteryRankList:Array;
		public function RankModel()
		{
		}

		public function get friendLevel():Array
		{
			return _friendLevel;
		}

		public function get friendAchieve():Array
		{
			return _friendAchieve;
		}

		public function get friendChip():Array
		{
			return _friendChip;
		}

		/**
		 * 添加成就 
		 * @param vo
		 * 
		 */		
		public function addAllAchieveItem(vo:RankListItemVO):void
		{
			_allAchieve.push(vo);
		}
		
		public function addAllLevelItem(vo:RankListItemVO):void
		{
			_allLevel.push(vo);
		}
		
		public function addAllChipItem(vo:RankListItemVO):void
		{
			_allChip.push(vo);
		}
		/**
		 * 添加成就 
		 * @param vo
		 * 
		 */		
		public function addFriendAchieveItem(vo:RankListItemVO):void
		{
			_friendAchieve.push(vo);
		}
		
		public function addFriendLevelItem(vo:RankListItemVO):void
		{
			_friendLevel.push(vo);
		}
		
		public function addFriendChipItem(vo:RankListItemVO):void
		{
			_friendChip.push(vo);
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function getAllAchieve():Array
		{
			return _allAchieve.concat();
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function getAllLevel():Array
		{
			return _allLevel.concat();
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function getAllChip():Array
		{
			return _allChip.concat();
		}
		/**
		 * 清空 
		 * 
		 */		
		public function clear():void
		{
			_allAchieve.splice(0,_allAchieve.length);
			_allLevel.splice(0,_allLevel.length);
			_allChip.splice(0,_allChip.length);
			_friendChip.splice(0,_friendChip.length);
			_friendAchieve.splice(0,_friendAchieve.length);
			_friendLevel.splice(0,_friendLevel.length);
		}
	}
}