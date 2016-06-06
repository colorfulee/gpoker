package com.jzgame.effects
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;
	import com.spellife.display.PopUpWindow;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.interfaces.effect.ITweenEffect;
	
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class DefaultPopUpWindowEffect implements ITweenEffect
	{
		/***********
		 * name:    DefaultPopUpWindowEffect
		 * data:    Jul 27, 2015
		 * author:  jim
		 * des:     默认的特效
		 ***********/
		private var _target:DisplayObject;
		public function DefaultPopUpWindowEffect()
		{
		}
		
		public function go(target:DisplayObject, ...rests):void
		{
			var startX:Number;
			var startY:Number;
			
			_target= target;

//			target.pivotX = centerX;
//			target.pivotY = centerY;
			var sx:Number = _target.scaleX;
			var sy:Number = _target.scaleY;
//			Sprite(target).flatten(false);
			target.scaleX = target.scaleY = .5;
			_target.alpha = .1;
			TweenMax.to(target,.4,{alpha:1,scaleX:sx,scaleY:sy,ease:Cubic.easeOut,onComplete:handleInEnd});
//			var bd:BitmapData = new BitmapData(target.width,target.height,true,0);
//			bd.draw(target);
//			_bitmap.bitmapData = bd;
//			
//			target.parent.addChild(_bitmap);
//			var rect:Rectangle = target.getRect(target.parent);
//			var startX:Number = rect.x + Math.floor(rect.width * 0.5);
//			var startY:Number = rect.y + Math.floor(rect.height * 0.5);
//			_bitmap.x = startX;
//			_bitmap.y = startY;
//			_bitmap.alpha = 0;
//			_bitmap.scaleX = _bitmap.scaleY = .3;
////			_target.visible = false;
//			_target.alpha = 0;
////			TweenMax.to(target,0.4,{scaleX:1,scaleY:1,ease:Back.easeOut,onUpdate:updatePosition,onUpdateParams:[target,startX,startY]})
//			TweenMax.to(_bitmap,0.5,{alpha:1,scaleX:1,scaleY:1,ease:Back.easeOut,onUpdate:updatePosition,onUpdateParams:[_bitmap,startX,startY],onComplete:handleInEnd})
		}
		
		private function handleInEnd():void
		{
			_target.dispatchEvent(new Event(Event.COMPLETE));
//			Sprite(_target).unflatten();
//			_target.visible = true;
//			if(_target)
//			_target.alpha = 1;
//			DisplayManager.disposeBitmap(_bitmap);
		}
		
		public function out(target:DisplayObject):void
		{
//			var bd:BitmapData = new BitmapData(target.width,target.height,true,0);
//			bd.draw(target);
//			_bitmap.bitmapData = bd;
//			_bitmap.visible = true;
//			_target.visible = false;
//			var rect:Rectangle = target.getRect(target.parent);
//			var startX:Number = rect.x + Math.floor(rect.width * 0.5);
//			var startY:Number = rect.y + Math.floor(rect.height * 0.5);
//			Sprite(_target).flatten();
			TweenMax.to(target,0.2,{alpha:0,scaleX:.5,scaleY:.5,ease:Linear.easeOut,onComplete:handleOutEnd})
		}
		
		private function updatePosition(target:DisplayObject,rectx:Number,recty:Number):void
		{
			var rect:Rectangle = target.getBounds(target.parent);
			var startX:Number = rectx - Math.floor(rect.width * 0.5);
			var startY:Number = recty - Math.floor(rect.height * 0.5);
			
//			target.x = startX;
//			target.y = startY;
		}
		
		
		public function handleOutEnd():void
		{
//			Sprite(_target).unflatten();
//			PopUpWindow(_target).isMoving = false;
//			DisplayManager.disposeBitmap(_bitmap);
			PopUpWindowManager.removePopUpWindow(PopUpWindow(_target));
//			_target = null;
//			_bitmap = null;
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