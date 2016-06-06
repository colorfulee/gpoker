package com.jzgame.common.model
{

/**
 *
 * @author Rakuten
 *
 */
public class LuckyWheelProxy
{
    public function LuckyWheelProxy()
    {
    }

    public var tickets:int = 0;
    private var _rewardArr:Array = [];

    public function get rewardArr():Array
    {
        return _rewardArr;
    }

    public function set rewardArr(value:Array):void
    {
        _rewardArr=value;
    }

//    public function getRewardNameById(val:uint):String
//    {
//        return _rewardArr[val].name;
//    }
	
	public function getRewardById(val:uint):*
	{
		return _rewardArr[val];
	}
}
}
