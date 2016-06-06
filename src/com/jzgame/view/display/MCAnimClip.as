package com.jzgame.view.display
{
	import com.jzgame.common.utils.DisplayManager;
	import com.spellife.display.AnimalClip;
	import com.spellife.util.RealGameTimer;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class MCAnimClip extends Sprite
	{
		/*auther     :jim
		* file       :MCAnimClip.as
		* date       :Apr 13, 2015
		* description:
		*/
		private var _anim:AnimalClip;
		private var _source:MovieClip;
		public function MCAnimClip(mc:MovieClip, timer:RealGameTimer)
		{
			_source = mc;
			addChild(_source);
			
			_anim = new AnimalClip(_source,timer);
			_anim.playRange(1,1);
		}
		/**
		 *  
		 * @param start
		 * @param end
		 * 
		 */		
		public function playRange(start:uint,end:uint):void
		{
			_anim.playRange(start,end);
		}
		
		public function start(times:uint = 1):void
		{
			_anim.addEventListener(AnimalClip.ANIMAL_FINISHED, closeHandler);
			_anim.play(times);
		}
		
		private function closeHandler(e:Event):void
		{
			dispatchEvent(e);
			
			_anim.removeEventListener(AnimalClip.ANIMAL_FINISHED, closeHandler);
			_anim.dispose();
			
			dispose();
		}
		
		public function stop():void
		{
			_anim.reset();
		}
		
		public function dispose():void
		{
			if(this.parent)
				this.parent.removeChild(this);
			DisplayManager.clearItemStage(this);
		}
	}
}