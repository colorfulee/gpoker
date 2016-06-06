package com.spellife.vo
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 26, 2013 4:27:29 PM 
	 * @description:
	 */ 
	public class SoundOperateVO extends ValueObject
	{
		//路径
		public var path:String;
		//是否重复播放
		public var loop:Boolean;
		//类型
		public var type:String;
		public function SoundOperateVO()
		{
			super();
		}
	}
}