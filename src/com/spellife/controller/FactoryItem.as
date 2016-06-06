package com.spellife.controller
{
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 13, 2013 12:36:20 PM 
	 * @description:
	 */ 
	import com.spellife.interfaces.iview.IViewFromFactory;
	import com.spellife.interfaces.ivo.IXMLValueObject;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class FactoryItem implements IViewFromFactory
	{
		public function FactoryItem()
		{
		}
		
		public function bind(vo:IXMLValueObject):void
		{
		}
		
		public function bindView(view:MovieClip):void
		{
		}
		
		public function dispose():void
		{
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return false;
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return false;
		}
		
		public function willTrigger(type:String):Boolean
		{
			return false;
		}
	}
}