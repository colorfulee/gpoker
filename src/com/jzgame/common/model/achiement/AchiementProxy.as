package com.jzgame.common.model.achiement
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.vo.AchievementVO;
	
	import flash.events.IEventDispatcher;

/**
 * 保存成就
 * @author Rakuten
 * 
 */
public class AchiementProxy
{
    public function AchiementProxy()
    {
    }
	
	[Inject]
	public var eventDispatcher:IEventDispatcher;
	
	private var achiementArr:Array = [];
	
	public var goldP:Number;
	public var silP:Number;
	public var treP:Number;
	public var first:Number;
	public var second:Number;
	public var third:Number;
	
	public function get length():int
	{
		return achiementArr.length;
	}
	
	public function setData(arr:Array):void
	{
		if (arr.length > 0)
		{
			achiementArr = achiementArr.concat(arr);
			eventDispatcher.dispatchEvent(new AchiementProxyEvent(AchiementProxyEvent.INIT_ACHIEMENT_LIST));
		}
	}
	
	/**
	 * 更新状态 
	 * @param value
	 * 
	 */		
	public function updateInfo(value:Object):void
	{
		var vo:AchievementVO;
		for(var i:String in value)
		{
			vo = Configure.achievementConfig.getAchievementById(i);
			vo.status = value[i]["status"];
			vo.finish_time = value[i]["finish_time"];
			vo.bonus_time = value[i]["bonus_time"];
		}
	}
	
	/**
	 * 取出第一个数据并从库中移除 
	 * @return 
	 * 
	 */	
	public function takeFristData():uint
	{
		return achiementArr.shift();
	}
}
}
