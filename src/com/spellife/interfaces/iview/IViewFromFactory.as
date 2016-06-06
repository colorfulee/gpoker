package com.spellife.interfaces.iview
{
	import com.spellife.interfaces.ivo.IXMLValueObject;

	public interface IViewFromFactory extends IViewFromLibrary
	{
		function bind(vo:IXMLValueObject):void
	}
}