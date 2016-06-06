package com.spellife.interfaces.display
{
	/**
	 * 
	 * @author apple
	 * 
	 */	
	public interface IList
	{
		function get defaultRow():int
		
		function set defaultRow(value:int):void
		
		function get defaultColumn():int
		
		function set defaultColumn(value:int):void
		
		function set item(item:Class):void
		
		function set dataProvider(data:Array):void
		function get dataProvider():Array
	}
}