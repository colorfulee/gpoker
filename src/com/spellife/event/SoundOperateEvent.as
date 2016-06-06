package com.spellife.event
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 26, 2013 4:26:32 PM 
	 * @description:
	 */ 
	import com.spellife.vo.SoundOperateVO;
	
	import flash.events.Event;
	
	public class SoundOperateEvent extends Event
	{
		public static var PLAY_SOUND:String = 'PLAY_SOUND';
		public static var STOP_SOUND:String = 'STOP_SOUND';
		
		public var soundData:SoundOperateVO;
		public function SoundOperateEvent(type:String, data:SoundOperateVO)
		{
			soundData = data;
			super(type, bubbles, cancelable);
		}
	}
}