package com.jzgame.model
{
	import com.jzgame.vo.room.RingRoomInfoVO;
	import com.jzgame.vo.room.RoomBaseInfoVO;
	
	import flash.utils.Dictionary;

	public class RoomModel
	{
		public var newBiLimit:Number = 0;
		public var fishLimit:Number = 80000;
		public var sharkLimit:Number = 400000;
		public var masterLimit:Number = 2000000;
		//自动进入房间的房型,0为随机,1为5人桌,2为9人桌子
		public var autoJoinTableRoomRoleNum:uint = 0;
		//是否在本次显示中略过
		public var skipNewerGuide:Boolean = false;
		
		private var all:Array = [];
		public var tablePageSize:uint = 17;
		public var tableStart:uint = 0;
		
		public var selectedRow:int = -1;
		
		public var onePage:uint = 17;
		public var onePageFriend:uint  = 8;
		
		//all in 玩法列表
		public var allinList:Array = [];
		//sit go玩法
		public var tournamentSG:Array = [];
		
		public var newBi:Array = [];
		public var fish:Array = [];
		public var shark:Array = [];
		public var master:Array = [];
		public var fast:Array = [];
		
		public var current:Array = [];
//		[Inject]
//		public var language:LanguageModel;
		
		public function RoomModel()
		{
//			table.romeID = 1;
//			var t:TableListInfo;
//			for(var i:uint = 0; i<30 ; i++)
//			{
//				t = new TableListInfo;
//				t.iD = 10001 + i;
//				t.blinds = 10;
//				t.maxBuy = 20;
//				t.minBuy = 10;
//				t.maxRole = (i % 2 == 0) ? 5:9;
//				t.online = 5;
////				table.tableInfo.push(t);
//			}
////			t.tableName = "长江一号";
//			var t2:TableListInfo = new TableListInfo;
//			t2.iD = 10102;
//			t2.blinds = 20;
//			t2.maxBuy = 40;
//			t2.minBuy = 20;
//			t2.maxRole = 9;
//			t2.online = 5;
////			t2.tableName = "长江二号";
//			table.tableInfo.push(t2);
//			
//			t2 = new TableListInfo;
//			t2.iD = 10101;
//			t2.blinds = 20;
//			t2.maxBuy = 40;
//			t2.minBuy = 20;
//			t2.maxRole = 5;
//			t2.online = 5;
////			t2.tableName = "长江二号";
//			table.tableInfo.push(t2);
//			
//			var t3:TableListInfo = new TableListInfo;
//			t3.iD = 10103;
//			t3.blinds = 20;
//			t3.maxBuy = 500;
//			t3.minBuy = 500;
//			t3.maxRole = 2;
//			t3.online = 1;
//			table.tableInfo.push(t3);
		}
//		/**
//		 * 清空房间 
//		 * 
//		 */		
//		public function clearRoom():void
//		{
//			all.splice(0,all.length);
//		}
		/**
		 * 获取当前页面房间列表 
		 * @return 
		 * 
		 */		
		public function getCurrentTable():Array
		{
			return current;
		}
		/**
		 * 搜索只为ring game 服务 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getSpecialRoom(id:String):Array
		{
			_searchId = id;
			var temp:Array = [];
			current = temp.concat(newBi).concat(fish).concat(shark).concat(master).concat(fast);
			return current.filter(roomFilter);
		}
		/**
		 * 获取房间名字
		 * @param id
		 * @return 
		 * 
		 */		
		public function getTableName(id:String):String
		{
			_searchId = id;
			var temp:Array = [];
			temp = temp.concat(newBi).concat(fish).concat(shark).concat(master);
			var result:Array = temp.filter(roomFilter);
			if(result.length > 0)
			{
				return RoomBaseInfoVO(result[0]).tableName;
			}
			return "";
		}
		
		/**
		 * 过滤满的或者空的房间
		 * @param em
		 * @param full
		 * @return 
		 * 
		 */		
		public function getEmFullFilterRoom(em:Boolean,full:Boolean,data:Array = null):Array
		{
			var list:Array = data;
			if(!list)
			{
				list = current.concat();
			}
			
			if(em)
			{
				list = list.filter(roomEmptyFilter);
			}
			
			if(full)
			{
				list = list.filter(roomFullFilter);
			}
			return list;
		}
		
		private var _searchId:String;
		private function roomFilter(element:RoomBaseInfoVO,index:uint,arr:Array):Boolean
		{
			return element.id == uint(_searchId);
		}
		
		private function roomEmptyFilter(element:RoomBaseInfoVO,index:uint,arr:Array):Boolean
		{
			return element.online != 0;
		}
		
		private function roomFullFilter(element:RoomBaseInfoVO,index:uint,arr:Array):Boolean
		{
			return element.maxRole != element.online;
		}
		/**
		 * 获取桌子信息
		 * @param row
		 * @return 
		 * 
		 */		
		public function getTableInfoByRow(row:uint):RoomBaseInfoVO
		{
			return all[row-1];
		}
		public var mobile:Dictionary = new Dictionary;
		/**
		 * 初始化手机端数据 
		 * 
		 */		
		public function getMobileList(index:uint):Array
		{
			var temp:Array = [];
			var line:Number = 0;
			var lineto:Number = 0;
			switch(index)
			{
				case 0:
					line = 0;
					lineto = 400000;
					break;
				case 1:
					line = 8000000;
					lineto = 40000000;
					break;
				case 2:
					line = 80000000;
					lineto = Number.MAX_VALUE;
					break;
			}
			
			for(var i:String in mobile)
			{
				if(Number(i)>line && Number(i) <=lineto)
				{
					temp.push(mobile[i]);
				}
			}
			
			return temp;
		}
	}
}