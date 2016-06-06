package com.jzgame.common.vo
{
	import com.spellife.interfaces.vo.IValueObject;
	import com.spellife.vo.ValueObject;
	
	import flash.events.Event;
	
	public class MessageCenterVO extends ValueObject
	{
		/*auther     :jim
		* file       :MessageCenterVO.as
		* date       :Dec 2, 2014
		* description:
		*/
		
		
//		"type": 901,
		//					"uid": "1002",
		//					"source_uid": "1001",
		//					"data": {
		//						"fb_id": "765749800139421",
		//						"fb_first_name": "继明 李"
		//					},
		//					"time": 1417163993,
		//					"status": 1
		//发送的玩家
		public var fromUid:String;
		//消息类型
		public var type:uint;
		//消息的排名
		public var index:String;
		//如果是礼物,礼物的物品id
		public var itemId:String;
		//礼物的个数
		public var itemNum:uint;
		//收到的玩家
		public var uid:String;
		//消息id
		private var _id:String;
		//消息发送时间
		public var happenTime:Number;
		//消息是否处理过。。默认是1，已经处理，已读--> 2, 删除，skip--> 3 
		private var _status:uint;
		//如果是添加好友
		///好友名字
		public var friendName:String;
		///好友FBid
		public var friendFBID:String;
//		#type = 5   mtt退赛
//		ext = ['match_id':xxxx]
//			#ty[e = 6   邀请好友
//				ext = ['fb_id'=>xxx, 'fb_first_name':xxx, 'fb_last_name':xxx]
//				#type = 7  点赞

		public var dataType:uint;
		public var text:String;
		public var bonus:String;
		//额外数据,只为909服务
		public var ext:Object;
		
		public var fb_id:String;
		public var name:String;
		public var tableId:String;
		public var tableName:String;
		//自己名字
		public var myName:String;
		
		public static var READ:uint = 2;
		public static var NORMAL:uint = 1;
		public static var REMOVE:uint = 3;
		

		public function MessageCenterVO()
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

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}
		
		override public function clone():IValueObject
		{
			var mvo:MessageCenterVO = new MessageCenterVO();
			mvo.fromUid = this.fromUid;
			mvo.type = type;
			mvo.index = index;
			mvo.itemId = itemId;
			mvo.itemNum = itemNum;
			mvo.uid = uid;
			mvo.id = _id;
			mvo.happenTime = happenTime;
			mvo.status = _status;
			mvo.friendName = friendName;
			mvo.friendFBID = friendFBID;
			mvo.dataType = dataType;
			mvo.text = text;
			mvo.bonus = bonus;
			mvo.ext = ext;
			mvo.fb_id = fb_id;
			mvo.name = name;
			mvo.tableId = tableId;
			mvo.tableName = tableName;
			mvo.myName = myName;
			
			return mvo;
		}

	}
}