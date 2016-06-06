package com.spellife.interfaces.display
{
	import flash.display.SimpleButton;
	import flash.geom.Rectangle;

	public interface IScroll
	{
		function viewPort(w:Number,h:Number):void
		function get viewPortWidth():Number
			
		function get viewPortHeight():Number
		function scroller(mc:SimpleButton,rect:Rectangle):void
	}
}