package com.spellife.model
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 26, 2013 4:16:18 PM 
	 * @description:
	 */ 
	public class OggSoundManager
	{
		//ELEMENTS
		
		public static const BYTES_PER_SAMPLE:Number = 8;
		public static const NUM_SAMPLES:int = 2048;
		
		private var _isPlaying:Boolean;
		private var _oggBytes:ByteArray;
		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
		private var _playPosition:int;
		
		private var lib:Object = new Object;
		
		public function OggSoundManager()
		{
			super();
		}
		
		public function play(path:String,loop:Boolean = false):void
		{
			var t:Number = getTimer();
			trace(t);
			var oggSoundItem:Mp3SoundItem = new Mp3SoundItem(path);
			trace(getTimer() - t);
			t = getTimer();
			oggSoundItem.play();
			trace(getTimer() - t);
			lib[oggSoundItem.path] = oggSoundItem;
		}
		
		public function stop(path:String):void
		{
			var oggSoundItem:Mp3SoundItem = lib[oggSoundItem.path];
			
			if(oggSoundItem)oggSoundItem.stop();
		}
	}
}