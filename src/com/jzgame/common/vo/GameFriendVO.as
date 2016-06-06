package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class GameFriendVO extends ValueObject
	{
		/*auther     :jim
		* file       :GameFriendVO.as
		* date       :Jan 14, 2015
		* description:
		*/
		public static var OFF_LINE:uint = 0;
		public static var LOBBY:uint = 1;
		public static var TABLE:uint = 2;
		
		public var name:String;
		public var winning:String;
		public var location:String;
		public var chip:Number;
		public var fb_id:String;
		public var id:String;
		public var status:uint = 0;
		
		public var showInvite:Boolean = false;
		//最后登录时间
		public var last_login_time:Number;
		
		public var tableName:String = "";
		public var tableId:String = "";
		public function GameFriendVO()
		{
			super();
		}
	}
}