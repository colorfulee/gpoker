package com.spellife.controller
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Mar 29, 2013 10:15:27 AM 
	 * @description:
	 */ 
	import com.spellife.interfaces.ifactory.IFactory;
	import com.spellife.interfaces.iview.IViewFromFactory;
	
	import flash.events.Event;
	
	public class Factory implements IFactory
	{
		private var rest:Array = [];
		
		public function generate():IViewFromFactory
		{
			var item:IViewFromFactory = rest.shift();
			if(!item) item = getItem();
			item.addEventListener(Event.REMOVED_FROM_STAGE, clear);
			return item;
		}
		/**
		 * 根据不同的工厂出产不同的产品类型 
		 * @return 
		 * 
		 */		
		protected function getItem():IViewFromFactory
		{
			return null;
		}
		private function clear(event:Event):void
		{
			var item:IViewFromFactory = event.currentTarget as IViewFromFactory;
			item.removeEventListener(Event.REMOVED_FROM_STAGE, clear);
			item.dispose();
			rest.push(item);
		}
	}
}