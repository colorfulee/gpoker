package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class SlotAlertVO extends ValueObject
	{
		/*auther     :jim
		* file       :SlotAlertVO.as
		* date       :Apr 11, 2015
		* description:
		*/
//		"uid":1001,           // uid
//		"fb_id":"xxxx",       // facebook ID
//		"cards":[x,x,x,x,x],  // 5张牌的ID
//		"table":10101,        // 牌桌ID
//		"name":"xxx"         // Player_name

		public var uid:String = "";
		public var fb_id:String = "";
		public var cards:Array = [];
		public var table:uint = 0;
		public var name:String = "";
		public function SlotAlertVO(value:Object = null)
		{
			super();
			
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