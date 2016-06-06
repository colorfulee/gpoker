package com.jzgame.vo.room
{
	import com.spellife.interfaces.vo.IValueObject;
	
	public class RingRoomInfoVO implements IValueObject
	{
		/***********
		 * name:    RingRoomInfoVO
		 * data:    Dec 11, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var max:Number = 0;
		public var online:Number = 0;
		public var blinds:uint = 0;
		//房间id
		public var rooms:Array = [];
		public function RingRoomInfoVO()
		{
		}
		
		public function clone():IValueObject
		{
			return null;
		}
		
		public function toString():String
		{
			return null;
		}
	}
}