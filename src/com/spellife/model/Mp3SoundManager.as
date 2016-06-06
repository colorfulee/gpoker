package com.spellife.model
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 26, 2013 4:16:18 PM 
	 * @description:
	 */ 
	public class Mp3SoundManager
	{
		private var lib:Object = new Object;
		
		public function Mp3SoundManager()
		{
			super();
		}
		
		public function play(path:String,loop:Boolean = false, bg:Boolean = false):void
		{
			if(bg)
			{
				stopCurrentBg();
			}
			
			var mp3SoundItem:Mp3SoundItem = new Mp3SoundItem(path);
			mp3SoundItem.isBgSound = bg;
			mp3SoundItem.play(loop);
			lib[mp3SoundItem.path] = mp3SoundItem;
		}
		
		public function stop(path:String):void
		{
			var mp3SoundItem:Mp3SoundItem = lib[path];
			
			if(mp3SoundItem)mp3SoundItem.stop();
			
			delete lib[path];
		}
		
		private function stopCurrentBg():void
		{
			for(var path:String in lib)
			{
				var mp3SoundItem:Mp3SoundItem = lib[path];
				
				if(mp3SoundItem.isBgSound)
				{
					stop(path);
					break;
				}
			}
		}
	}
}