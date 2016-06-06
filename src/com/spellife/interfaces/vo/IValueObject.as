package com.spellife.interfaces.vo
{
	public interface IValueObject
	{
		/**
		 * 克隆 
		 * 
		 */		
		function clone():IValueObject
		/**
		 * 打印 
		 * @return 
		 * 
		 */			
		function toString():String;
	}
}