package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class ChatMessageVO extends ValueObject
	{
		/*auther     :jim
		* file       :ChatMessageVO.as
		* date       :Nov 21, 2014
		* description:
		*/
		public static var CHAT_ANIM:String = "CHAT_ANIM_";
		public var uid:uint;
		public var name:String;
		public var content:String;
		//是否是动画表情
		public var anim:uint = 0;
		public var type:uint;
		public function ChatMessageVO()
		{
			super();
		}
	}
}