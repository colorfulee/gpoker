package com.jzgame.vo.room
{
	import com.spellife.vo.ValueObject;
	
	import flash.events.Event;
	
	public class MTTTableListInfo extends ValueObject
	{
		/*auther     :jim
		* file       :MTTTableListInfo.as
		* date       :Feb 28, 2015
		* description:mtt vo
		*/
		
		//"rewards": "50$ + 750score",
		//						"img": "",
		//						"requirement": "",
		//						"kick_of_time": "8:00",
		//						"competitors": 22,
		//						"status": 0
		
		public var rewards:String = "";
		public var img:String = "";
		public var requirement:Number = 0;
		public var kick:String = "";
		public var competitor:Number = 0;
		private var _status:uint = 0;
		public var id:Number;
		public var match_id:String;
		public var ip:String;
		public var port:uint;
		public var mtt_id:String;
		public var players_left:String;
		//报名消耗分数
		public var costScore:Number = 0;
		//报名消耗钱
		public var costChip:Number = 0;
		//我的状态，在mtt中状态，是报名或者没报名
		private var _myStatus:uint = 0;
		//参加人数
		public var initial_players:uint = 0;
		//剩余人数
		public var count:uint = 0;
		//开局时间
		public var start_time:Number;
		//结束时间
		public var end_time:String;
		//结果
		public var result:Object;
//		"result": {
//			"r": {
//				"1": {
//					"u": 1001,
//					"n": "Player 1001",
//					"f": "012345678901001",
//					"cb": 500000000,
//					"sb": 750,
//					"s": 0
//				},
//				"2": {
//					"u": 1006,
//					"n": "Player 1006",
//					"f": "012345678901006",
//					"cb": 200000000,
//					"sb": 500,
//					"s": 0
//				},
//				"3": {
//					"u": 1005,
//					"n": "Player 1005",
//					"f": "012345678901005",
//					"cb": 150000000,
//					"sb": 250,
//					"s": 0
//				},
//				"4": {
//					"u": 1002,
//					"n": "Player 1002",
//					"f": "012345678901002",
//					"cb": 100000000,
//					"sb": 100,
//					"s": 0
//				}
//			}
//		},
//		"start_time": "1426071546",
//		"end_time": "1426071600",
//		"players_left": "0",
//		"initial_players": "4",
//		"count": "9",

//		"match_id": "19",
//		"mtt_id": "3001",
//		"desc": "$ 1 Billion + VIP 30days",
//		"icon": "icon_huodong_1",
//		"cost_score": 1000,
//		"cost_chip": 50000000,
//		"status": "1",
//		"start_time": "1427798400",
//		"end_time": "0",
//		"players_left": "0",
//		"initial_players": "0",
//		"count": 0,
//		"ip": "192.168.1.52:9088"

		public function MTTTableListInfo()
		{
			super();
		}

		public function get status():uint
		{
			return _status;
		}

		public function set status(value:uint):void
		{
			_status = value;
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function get myStatus():uint
		{
			return _myStatus;
		}

		public function set myStatus(value:uint):void
		{
			_myStatus = value;
			dispatchEvent(new Event(Event.CHANGE));
		}

	}
}