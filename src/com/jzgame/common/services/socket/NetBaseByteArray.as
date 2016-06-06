package com.jzgame.common.services.socket
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 9, 2013 5:27:45 PM 
	 * @description:
	 */ 
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class NetBaseByteArray extends ByteArray
	{
		public function NetBaseByteArray()
		{
			super();
			
			this.endian = Endian.LITTLE_ENDIAN;
		}
	}
}