package com.spellife.model
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 26, 2013 4:44:31 PM 
	 * @description:
	 */ 
	public class OggSoundItem extends EventDispatcher
	{
		public var path:String;
		public var isLoaded:Boolean = false;
		
		private var _loader:URLLoader;
		private var _oggBytes:ByteArray;
		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
//		private var _oggManager:OggManager;
		private var index:uint = 0;
		public function OggSoundItem(oggPath:String)
		{
			super();
			
			path = oggPath;
			_oggBytes = new ByteArray;
			
//			_oggManager= new OggManager;
		}
		
		private	function loaded(e:Event):void
		{
			_loader.removeEventListener(Event.COMPLETE, loaded);
			//Save bytes
//			_oggBytes.length = 0;
//			_oggBytes.writeBytes(_loader.data);
//			_oggBytes.position = 0;
//			_oggManager.initDecoder(_oggBytes);
			
			isLoaded = true;
			
			_sound = new Sound();
			_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, handleSoundData, false, 0, true);
			loudSound();
		}
		
		private function loudSound():void
		{
			var soundTrans:SoundTransform = new SoundTransform;
			soundTrans.volume = 0.5;
			_soundChannel = _sound.play(0,0,soundTrans);
		}
		
		private function handleSoundData(e:SampleDataEvent):void
		{
//			trace('handleSoundData'+index++);
//			//handleSoundData
//			var result:Object;
//			var tmpBuffer:ByteArray = new ByteArray();
//			result = _oggManager.getSampleData(OggSoundManager.NUM_SAMPLES, tmpBuffer);
//			
//			if (tmpBuffer.length < OggSoundManager.NUM_SAMPLES * OggSoundManager.BYTES_PER_SAMPLE)
//			{//reset
//				trace("Rewind");
//				//Right now the only way to rewind is reseting the decoder
//				_oggManager.initDecoder(_oggBytes);
//				result = _oggManager.getSampleData(OggSoundManager.NUM_SAMPLES, tmpBuffer);
//			}//reset
//			
//			tmpBuffer.position = 0;	
//			
//			while (tmpBuffer.bytesAvailable)
//			{//feed
//				//feed data
//				e.data.writeFloat(tmpBuffer.readFloat());		//Left Channel
//				e.data.writeFloat(tmpBuffer.readFloat());		//Right Channel
//			}//feed
			
		}
		
		public function play(loop:Boolean = false):void
		{
			return
			if(isLoaded)
			{
				loudSound();
			}else
			{
				_loader = new URLLoader;
				
				_loader.dataFormat = URLLoaderDataFormat.BINARY;
				_loader.addEventListener(Event.COMPLETE, loaded);
				_loader.load(new URLRequest(path));
				trace('start load');
			}
		}
		
		public function stop():void
		{
			if(_soundChannel)
			_soundChannel.stop();
		}
	}
}