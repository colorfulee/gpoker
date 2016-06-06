package com.jzgame.common.model.task
{
import flash.events.Event;
/**
 * 
 * @author Rakuten
 * 
 */
public class TaskProxyEvent extends Event
{
	static public const INIT_TASK_LIST:String = "initTaskList";
	
    public function TaskProxyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
    {
        super(type, bubbles, cancelable);
    }
	
	override public function clone():Event
	{
		var cloneEvent:TaskProxyEvent = new TaskProxyEvent(type, bubbles, cancelable);
		return cloneEvent;
	}
}
}
