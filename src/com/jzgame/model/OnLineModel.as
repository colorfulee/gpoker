package com.jzgame.model
{
	import com.jzgame.common.model.gameFriends.GameFriendsProxy;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.vo.GameFriendVO;
	import com.jzgame.common.vo.OnlineVO;
	import com.spellife.util.RealGameTimer;
	
	import flash.events.IEventDispatcher;
	
	public class OnLineModel
	{
		/*auther     :jim
		* file       :OnLineModel.as
		* date       :Apr 20, 2015
		* description:
		*/
		private var _onLine:Array = [];
		private var _table:Array = [];
		private var _observe:Array = [];
		[Inject]
		public var gameProxy:GameFriendsProxy;
		[Inject]
		public var roomModel:RoomModel;
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		public var timer:RealGameTimer = new RealGameTimer(30000);
		public function OnLineModel()
		{
		}
		/**
		 * 更新数据 
		 * @param vo
		 * 
		 */
//		"online": {
//			"211": "ring:10501",
//			"275": "ring:10501"
//		},
//		"in_table": {
//			"211": "ring:10501",
//			"275": "ring:10501"
//		}
		public function updateInfo(vo:Object):void
		{
			_onLine.splice(0,_onLine.length);
			_table.splice(0,_table.length);
			var friends:Object = vo.online;
			var fr:OnlineVO;
			var gameVO:GameFriendVO;
			if(friends)
			{
				for(var i:String in friends)
				{
					fr = new OnlineVO;
					fr.userId = i;
					if(friends[i])
					{
						fr.tableId = friends[i].split(AssetsCenter.COLON)[1];
					}
					
					gameVO = gameProxy.getUserById(fr.userId);
					gameVO.status = fr.tableId == "" ? GameFriendVO.LOBBY:GameFriendVO.TABLE;
					gameVO.tableId = fr.tableId;
					gameVO.tableName = roomModel.getTableName(gameVO.tableId);
					
					_onLine.push(fr);
				}
			}
			
			friends = vo.in_table;
			if(friends)
			{
				for(var m:String in friends)
				{
					fr = new OnlineVO;
					fr.userId = m;
					if(friends[m])
					{
						fr.tableId = friends[m].split(AssetsCenter.COLON)[1];
					}
					gameVO = gameProxy.getUserById(fr.userId);
					gameVO.status = fr.tableId == "" ? GameFriendVO.LOBBY:GameFriendVO.TABLE;
					gameVO.tableId = fr.tableId;
					gameVO.tableName = roomModel.getTableName(gameVO.tableId);
					
					_table.push(fr);
				}
			}
		}
		/**
		 * 观众 
		 * @param players
		 * 
		 */		
		public function updateObserve(players:Array):void
		{
			_observe = players;
//			_observe.splice(0,_observe.length);
			
//			_observe.concat(players);
		}
		/**
		 * 获取群众 
		 * @return 
		 * 
		 */		
		public function get observe():Array
		{
			return _observe;
		}
		/**
		 * 获取在线列表 
		 * @return 
		 * 
		 */		
		public function get onLine():Array
		{
			var onlist:Array = [];
			var gameVO:GameFriendVO;
			var onVO:OnlineVO;
			for(var m:String in _onLine)
			{
				onVO = OnlineVO(_onLine[m]);
				gameVO = gameProxy.getUserById(onVO.userId);
				gameVO.status = onVO.tableId == "" ? GameFriendVO.LOBBY:GameFriendVO.TABLE;
				gameVO.tableId = onVO.tableId;
				gameVO.tableName = roomModel.getTableName(gameVO.tableId);
				onlist.push(gameVO);
			}
			return onlist;
		}
		/**
		 * 获取在房间列表 
		 * @return 
		 * 
		 */		
		public function get inTable():Array
		{
			var onlist:Array = [];
			var gameVO:GameFriendVO;
			var onVO:OnlineVO;
			for(var m:String in _table)
			{
				onVO = OnlineVO(_table[m]);
				gameVO = gameProxy.getUserById(onVO.userId);
				gameVO.status = onVO.tableId == "" ? GameFriendVO.LOBBY:GameFriendVO.TABLE;
				onlist.push(gameVO);
			}
			return onlist;
		}
	}
}