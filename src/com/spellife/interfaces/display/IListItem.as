package com.spellife.interfaces.display
{
	public interface IListItem
	{
		function set row(index:uint):void
		function get row():uint
		function set column(index:uint):void
		function get column():uint
		function set data(data:Object):void
			
		function reset():void
	}
}