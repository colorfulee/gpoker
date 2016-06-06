//TweenEffect.as
//Nov 5, 2011
//author:jim
//description:
package com.spellife.interfaces.effect
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	
	public class TweenEffect extends EventDispatcher implements ITweenEffect
	{
		protected var _params:Object;
		protected var _target:DisplayObject;
		public function TweenEffect()
		{
		}
		
		public function go(target:DisplayObject, ...rests):void
		{
		}
		
		public function get rests():Object
		{
			return _params;
		}
		
		public function get win():DisplayObject
		{
			return _target;
		}
		
		public function end():void
		{
		}
	}
}