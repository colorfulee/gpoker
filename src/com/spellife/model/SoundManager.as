package com.spellife.model
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 26, 2013 4:15:57 PM 
	 * @description:
	 */ 
	import com.spellife.event.SoundOperateEvent;
	import com.spellife.vo.SoundOperateVO;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class SoundManager extends EventDispatcher
	{
		public static var OGG_SOUND:String = 'ogg';
		public static var MP3_SOUND:String = 'mp3';
		public static var MP3_BG_SOUND:String = 'bg_mp3';
		
		private var _oggSoundManager:OggSoundManager;
		private var _mp3SoundManager:Mp3SoundManager;
		
		public function SoundManager(target:IEventDispatcher)
		{
			super(target);
			
//			_oggSoundManager = new OggSoundManager;
			_mp3SoundManager = new Mp3SoundManager;
			
			target.addEventListener(SoundOperateEvent.PLAY_SOUND, play);
			target.addEventListener(SoundOperateEvent.STOP_SOUND, stop);
		}
		
		protected function play(event:SoundOperateEvent):void
		{
			var soundVO:SoundOperateVO = event.soundData;
			switch(soundVO.type)
			{
				case OGG_SOUND:
					_oggSoundManager.play(soundVO.path,soundVO.loop);
					break;
				case MP3_SOUND:
					_mp3SoundManager.play(soundVO.path,soundVO.loop);
					break;
				case MP3_BG_SOUND:
					_mp3SoundManager.play(soundVO.path,soundVO.loop,true);
					break;
			}
		}
		
		protected function stop(event:SoundOperateEvent):void
		{
			var soundVO:SoundOperateVO = event.soundData;
			switch(soundVO.type)
			{
				case OGG_SOUND:
					_oggSoundManager.stop(soundVO.path);
					break;
				case MP3_SOUND:
					_mp3SoundManager.stop(soundVO.path);
					break;
			}
		}
	}
}