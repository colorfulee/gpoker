package com.jzgame.effects
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;
	import com.spellife.display.PopUpWindow;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.interfaces.effect.ITweenEffect;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class FadeOutWindowEffect implements ITweenEffect
	{
		/***********
		 * name:    DefaultPopUpWindowEffect
		 * data:    Jul 27, 2015
		 * author:  jim
		 * des:     默认的特效
		 ***********/
		private var _target:DisplayObject;
		public function FadeOutWindowEffect()
		{
		}
		
		public function go(target:DisplayObject, ...rests):void
		{
			var startX:Number;
			var startY:Number;
			
			_target = target;
			_target.y = -_target.height - 10;
			var endY:Number = Math.ceil(_target.height * .5);

			_target.alpha = .1;
			TweenMax.to(target,.4,{alpha:1,y:endY,ease:Cubic.easeOut,onComplete:handleInEnd});
		}
		
		private function handleInEnd():void
		{
			_target.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function out(target:DisplayObject):void
		{
			TweenMax.to(target,0.2,{alpha:0,y:-target.height - 10,ease:Linear.easeOut,onComplete:handleOutEnd})
		}
		
		
		public function handleOutEnd():void
		{
			PopUpWindowManager.removePopUpWindow(PopUpWindow(_target));
		}
		/**
		 * 销毁 
		 * 
		 */		
		public function dispose():void
		{
//			if(_bitmap.parent)_bitmap.parent.removeChild(_bitmap);
//			DisplayManager.disposeBitmap(_bitmap);
//			_target = null;
//			_bitmap = null;
		}
	}
}