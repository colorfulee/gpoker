package com.jzgame.signals
{
	import org.osflash.signals.Signal;
	
	public class SignalJoinSocket extends Signal
	{
		/***********
		 * name:    SignalJoinTable
		 * data:    Nov 16, 2015
		 * author:  jim
		 * des:
		 ***********/
//		public var joinMatchId:String;
//		public var targetUid:uint;
//		public var obv:Boolean = false;
//		public var joinType:uint = 11;
		
		public function SignalJoinSocket()
		{
			//ip,端口
			super(String,uint);
		}
	}
}