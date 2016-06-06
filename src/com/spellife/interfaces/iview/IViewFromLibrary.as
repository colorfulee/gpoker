package com.spellife.interfaces.iview
{
	import flash.display.MovieClip;
	import flash.events.IEventDispatcher;
	
	public interface IViewFromLibrary extends IEventDispatcher
	{
		function bindView(view:MovieClip):void
		function dispose():void
	}
}