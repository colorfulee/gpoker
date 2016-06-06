package com.jzgame.enmu
{
	public class PlayState
	{
		/*auther     :jim
		* file       :PlayState.as
		* date       :Aug 26, 2014
		* description:
		*/
	
		/**
		 *等待,弃牌,加注,过牌,all in,大盲,小盲,操作中 
		 */		
		public static var WAITING:uint = 1;//等待
		public static var FOLD:uint = 2;//弃牌
		public static var BET:uint = 3;//加注
		public static var BIG_BLINDS:uint = 4;//大盲
		public static var SMALL_BLINDS:uint = 5;//小盲
		public static var ALL_IN:uint = 6;//弃牌
		public static var OPERATING:uint = 7;//操作中
	}
}