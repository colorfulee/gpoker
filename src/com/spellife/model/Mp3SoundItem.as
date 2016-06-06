package com.spellife.model
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.enmu.ReleaseUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 26, 2013 4:44:31 PM 
	 * @description:
	 */ 
	public class Mp3SoundItem extends EventDispatcher
	{
		public var path:String;
		public var isLoaded:Boolean = false;
		public var isBgSound:Boolean = false;
		
		private var _loader:URLLoader;
		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
		private var index:uint = 0;
		private var _loop:Boolean = false;
		private var _volume:Number = 1;
		public function Mp3SoundItem(mp3Path:String,volume:Number = 1)
		{
			super();
			_volume = volume;
			path = mp3Path;
			
			if(ReleaseUtil.RELEASE)
			{
				path = AssetsCenter.getReleasePath(mp3Path);
			}
		}
		
		public function play(loop:Boolean = false):void
		{
			_loop = loop;
			var request:URLRequest = new URLRequest(path);
			_sound = new Sound();
			_sound.addEventListener(Event.COMPLETE, completeHandler);
			_sound.addEventListener(Event.ID3, id3Handler);
			_sound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_sound.load(request);
			var trans:SoundTransform = new SoundTransform(_volume);
			_soundChannel = _sound.play(0,0,trans);
			if(_loop)
			{
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundPlayCompleteHandler);
			}
			Tracer.info('start load sound'+path);
		}
		
		public function stop():void
		{
			trace('stop load',_loop,path);
			if(_soundChannel)
			{
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundPlayCompleteHandler);
				_soundChannel.stop();
			}
			
			_sound.removeEventListener(Event.COMPLETE, completeHandler);
			_sound.removeEventListener(Event.ID3, id3Handler);
			_sound.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_sound.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		private function completeHandler(event:Event):void {
//			trace("completeHandler: " + event);
			
			_sound.removeEventListener(Event.COMPLETE, completeHandler);
			_sound.removeEventListener(Event.ID3, id3Handler);
			_sound.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_sound.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		private function soundPlayCompleteHandler(event:Event):void
		{
//			trace('soundPlayCompleteHandler');
			if(_soundChannel)
			{
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundPlayCompleteHandler);
			}
			if(_sound)
			{
				var trans:SoundTransform = new SoundTransform(_volume);
				_soundChannel = _sound.play(0,0,trans);
				if(_loop)
				_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundPlayCompleteHandler);
			}
		}
		
		private function id3Handler(event:Event):void {
//			trace("id3Handler: " + event);
		}
		
		private function ioErrorHandler(event:Event):void {
//			trace("ioErrorHandler: " + event);
		}
		
		private function progressHandler(event:ProgressEvent):void {
//			trace("progressHandler: " + event);
		}
	}
}