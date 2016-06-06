package com.jzgame.command
{
	import com.jzgame.common.utils.ConfigSO;
	import com.jzgame.events.SoundEffectEvent;
	import com.spellife.model.Mp3SoundItem;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class SoundEffectCommand extends Command
	{
		/*auther     :jim
		* file       :SoundEffectCommand.as
		* date       :Apr 7, 2015
		* description:
		*/
		[Inject]
		public var event:SoundEffectEvent
		public function SoundEffectCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var mp3SoundItem:Mp3SoundItem = new Mp3SoundItem(event.path,ConfigSO.getInstance().soundEffectVolumn / 100);
			mp3SoundItem.isBgSound = false;
			mp3SoundItem.play(false);
		}
	}
}