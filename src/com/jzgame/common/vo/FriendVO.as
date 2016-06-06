package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class FriendVO extends ValueObject
	{
		/*auther     :jim
		* file       :FriendVO.as
		* date       :Sep 12, 2014
		* description:
		*/
		
		public var name:String;
		public var winning:String;
		public var location:String;
		public var chip:String;
		public var fb_id:String;
		//最近登录时间
		public var last_login_time:String;
		public function FriendVO()
		{
			super();
		}
	}
}