package com.jzgame.common.events
{
import flash.display.DisplayObject;
import flash.events.Event;

/**
 * 
 * @author Rakuten
 * 
 */
public class ModuleEvent extends Event
{
	static public const LOAD_MODULE:String = "loadModule";
	static public const MODULE_LOAD_COMPLETE:String = "moduleLoadComplete";
	static public const REMOVE_MODULE:String = "removeModule";
	
	public var moduleName:String="";
	public var module:DisplayObject;
    public function ModuleEvent(type:String, moduleName_:String = '',bubbles:Boolean=false, cancelable:Boolean=false)
    {
        super(type, bubbles, cancelable);
		
		moduleName = moduleName_;
    }
	
	override public function clone():Event
	{
		var spevent:ModuleEvent = new ModuleEvent(type,moduleName);
		spevent.module = module;
		return spevent; 
	}
}
	
	
}
