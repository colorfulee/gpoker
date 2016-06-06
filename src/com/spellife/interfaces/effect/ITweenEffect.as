package com.spellife.interfaces.effect
{
	import starling.display.DisplayObject;

	public interface ITweenEffect
	{
		function go(target:DisplayObject,...rests):void
		function out(target:DisplayObject):void
		function dispose():void
	}
}