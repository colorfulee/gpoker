package com.jzgame.vo.game
{
	import com.spellife.vo.ValueObject;
	
	public class MessageAlertVO extends ValueObject
	{
		/*auther     :jim
		* file       :MessageAlertVO.as
		* date       :Apr 8, 2015
		* description:
		*/
		
//		"uid":1001,       // uid
//		"fb_id":"xxxxx",  // facebook ID
//		"name":"xxx",     // Player name
//		"say":"xxx"       // 说的话

		public var title:String;
		public var uid:String;
		public var fb_id:String;
		public var name:String = "";
		public var say:String;
		public var flag:uint;
		public function MessageAlertVO(t:String,value:Object,f:uint)
		{
			super();
			
			title = t;
			flag  = f;
			
			if(value)
			{
				for(var i:String in value)
				{
					this[i] = value[i];
				}
			}
		}
	}
}