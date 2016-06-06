package com.jzgame.common.model.task
{
import com.jzgame.common.vo.TaskVO;

import flash.events.IEventDispatcher;

/**
 * 保存任务
 * @author Rakuten
 * 
 */
public class TaskProxy
{
    public function TaskProxy()
    {
    }

	[Inject]
	public var eventDispatcher:IEventDispatcher;
	
	private var taskArr:Array = /* of TaskVO */ [];
	private var taskLimitArr:Array = /* of TaskVO */ [];
	
	public function setData(arr:Array):void
	{
		taskArr = arr;
		eventDispatcher.dispatchEvent(new TaskProxyEvent(TaskProxyEvent.INIT_TASK_LIST));
	}
	/**
	 * 设置限时任务列表 
	 * @param arr
	 * 
	 */	
	public function setLimitData(arr:Array):void
	{
		taskLimitArr = arr;
	}
	
	public function getTaskByIndex(index:int):TaskVO
	{
		return taskArr[index];
	}
	/**
	 * 获取限时任务列表 
	 * @return 
	 * 
	 */	
	public function getLimitTask():Array
	{
		return taskLimitArr;
	}
	
	public function getAllTask():Array
	{
		return taskArr;
	}
	
	public function removeAll():void
	{
		taskArr.splice(0);
	}
}
}
