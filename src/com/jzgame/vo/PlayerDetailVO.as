package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class PlayerDetailVO extends ValueObject
	{
		/*auther     :jim
		* file       :PlayerDetailVO.as
		* date       :Jan 16, 2015
		* description:个人详细信息vo
		*/
		public var uid:String;
		public var level:uint;
		public var title:String = "";
		//玩家姓名
		public var name:String;
		public var chip:Number = 0;
		public var achievement_num:uint;
		public var level_rank:uint;
		public var chip_rank:uint;
		public var achievement_rank:uint;
		//最多拥有的筹码
		public var chip_max:uint;
		//玩家金币
		public var coin:Number = 0;
		//最大赢得筹码
		public var max_win:uint = 0;
		//分数
		public var score:Number = 0;
		//fb id
		public var fb_id:String = "";
		//最好的手牌
		public var max_card:String = "";
		public var rounds:String = "";
		public var champions:String = "";
		public var friends_total:uint;
		public var vip_level:Number = 0;
		public var first_login:Number = 0;
		public var last_login:Number = 0;
		public var play_num:Number = 0;//玩的总局数
		public var failed_num:Number = 0;//输得总局数
		public var invite_total:Number = 0; //FB邀请好友数量
		public var accept_gift_num:Number = 0; //接收礼物数量
		public var send_gift_num:Number = 0;//送出礼物数量
		public var winning:Number = 0;//胜利场次

		public var recent_gift:Vector.<int> = new Vector.<int>;
		public var recent_achievement:Vector.<int> = new Vector.<int>;
		
//		"uid": "369",
//		"level": 2,
//		"title": "",
//		"chip": 191206,
//		"achievement_num": 3,
//		"level_rank": 0,
//		"chip_rank": 0,
//		"achievement_rank": 0,
//		"chip_max": 0,
//		"max_win": 0,
//		"max_card": 0,
//		"rounds": "0/110",
//		"champions": "0/0",
//		"friends_total": 1,
//		"first_login": 1416812437,
//		"last_login": "1420799425",
//		"recent_gift": [804001, 804002],
//		"recent_achievement": [
//			"709001",
//			"705002",
//			"705001"
//		]

		public function PlayerDetailVO()
		{
			super();
		}
	}
}