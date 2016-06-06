package com.spellife.interfaces.ivo
{
	public interface IXMLValueObject
	{
		function bind(xml:XML):void
		function clone():IXMLValueObject;
	}
}