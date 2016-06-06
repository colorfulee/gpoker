package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;

	public class ActionVO extends ValueObject
	{
		/*auther     :jim
		* file       :ActionVO.as
		* date       :Aug 27, 2014
		* description:
		*/
		public var userID:uint;//玩家id
		public var seatID:uint;//玩家座位id
		public var state:uint;//玩家当前状态
		public var clip:Number;//产生变化的筹码
		public function ActionVO(id:uint,state_:uint=0,clip_:Number = 0,userId:uint = 0)
		{
			super();
			
			seatID = id;
			state = state_;
			clip = clip_;
			userID = userId;
		}
		/**
		 * 
		 * @param obj
		 * @return 
		 * 
		 */		
		public static function prase(obj:Object):ActionVO
		{
			var vo:ActionVO = new ActionVO(0);
			for(var ii:String in obj)
			{
				vo[ii] = obj[ii];
			}
			
			return vo;
		}
		
		
		override public function toString():String
		{
			return "桌位id:"+seatID+",状态:"+state+",筹码数:"+clip+"玩家id:"+userID;
		}
	}
}