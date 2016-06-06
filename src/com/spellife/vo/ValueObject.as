package com.spellife.vo
{
	import com.spellife.interfaces.vo.IValueObject;
	
	import flash.events.EventDispatcher;
	
	public class ValueObject extends EventDispatcher implements IValueObject
	{
		public function clone():IValueObject
		{
			return null;
		}
	}
}