package com.jzgame.effects
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Sine;
	import com.jzgame.common.events.ModuleEvent;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.enmu.ModuleType;
	import com.jzgame.enmu.ReleaseUtil;
	import com.spellife.display.PopUpWindow;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.interfaces.display.IPopUpWindow;
	import com.spellife.interfaces.effect.ITweenEffect;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public class WheelWindowEffect implements ITweenEffect
	{
		/***********
		 * name:    DefaultPopUpWindowEffect
		 * data:    Jul 27, 2015
		 * author:  jim
		 * des:     大转盘的特效
		 ***********/
		private var _target:DisplayObject;
		private var _bitmap:Bitmap = new Bitmap();
		public function WheelWindowEffect()
		{
		}
		
		public function go(target:DisplayObject, ...rests):void
		{
			_target= target;
			var bd:BitmapData = new BitmapData(target.width,target.height,true,0);
			bd.draw(target);
			_bitmap.bitmapData = bd;
			
			target.parent.addChild(_bitmap);
			var rect:Rectangle = target.getRect(target.parent);
			_bitmap.x = ReleaseUtil.STAGE_WIDTH;
			_bitmap.y = target.y;
			_target.visible = false;
			TweenMax.to(_bitmap,0.4,{alpha:1,x:target.x,ease:Back.easeOut,onComplete:handleInEnd})
		}
		
		private function handleInEnd():void
		{
			_bitmap.visible = false;
			DisplayManager.disposeBitmap(_bitmap);
			_target.visible = true;
		}
		
		public function out(target:DisplayObject):void
		{
			var bd:BitmapData = new BitmapData(target.width,target.height,true,0);
			bd.draw(target);
			_bitmap.bitmapData = bd;
			_bitmap.visible = true;
			_target.visible = false;
			_bitmap.x = target.x;
			_bitmap.y = target.y;
			TweenMax.to(_bitmap,0.6,{x:ReleaseUtil.STAGE_WIDTH,ease:Back.easeOut,onComplete:handleOutEnd})
		}
		
		public function handleOutEnd():void
		{
			DisplayManager.disposeBitmap(_bitmap);
			PopUpWindowManager.removePopUpWindow(IPopUpWindow(_target));
			_target = null;
			_bitmap = null;
			
			var moduleEvent:ModuleEvent = new ModuleEvent(ModuleEvent.REMOVE_MODULE);
			moduleEvent.moduleName = ModuleType.LUCKY_WHEEL;
			AssetsCenter.eventDispatcher.dispatchEvent(moduleEvent);
		}
		/**
		 * 销毁 
		 * 
		 */		
		public function dispose():void
		{
			DisplayManager.disposeBitmap(_bitmap);
			_target = null;
			_bitmap = null;
		}
	}
}