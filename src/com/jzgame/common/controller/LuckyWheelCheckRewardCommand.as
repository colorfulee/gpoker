package com.jzgame.common.controller
{
import com.jzgame.common.model.LuckyWheelProxy;
import com.jzgame.common.services.http.events.HttpResponseEvent;

import robotlegs.bender.bundles.mvcs.Command;
/**
 * 转盘奖品列表
 * @author Rakuten
 * 
 */
public class LuckyWheelCheckRewardCommand extends Command
{
    public function LuckyWheelCheckRewardCommand()
    {
        super();
    }
	
	[Inject]
	public var event:HttpResponseEvent;
	
	[Inject]
	public var proxy:LuckyWheelProxy;
	
	override public function execute():void
	{
		var obj:* = event.data;
		if (obj.e == 0)
		{
			proxy.tickets = obj.r.lucky_wheel.tickets;
			proxy.rewardArr = obj.r.lucky_wheel.items
		}
//		trace(obj);
	}
}
}
