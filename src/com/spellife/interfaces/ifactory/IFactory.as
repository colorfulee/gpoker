package com.spellife.interfaces.ifactory
{
	import com.spellife.interfaces.iview.IViewFromFactory;

	public interface IFactory
	{
		function generate():IViewFromFactory
	}
}