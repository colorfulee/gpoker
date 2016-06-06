package com.jzgame.i
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public interface IToolTip
	{
		function setRect(rect:Rectangle):void
		function setPoint(p:Point):void
		function move(p:Point):void
	}
}