package com.jzgame.common.model.friendList
{
import com.jzgame.common.vo.FriendVO;

import flash.events.IEventDispatcher;

/**
 * 保存社交平台好友列表
 * @author Rakuten
 *
 */
public class FriendListProxy
{
	public var current:int = 1;
	public var onePage:uint = 7;
	public var pages:uint = 1;
	
    public function FriendListProxy()
    {
    }

	[Inject]
	public var eventDispatcher:IEventDispatcher;

    private var friendListArr:Array = [];
	public function get totalFriendNum():int
	{
		return friendListArr.length;
	}

    public function setData(arr:Array):void
    {
        friendListArr = arr;
		eventDispatcher.dispatchEvent(new FriendListProxyEvent(FriendListProxyEvent.INIT_FRIEND_LIST));
    }

    public function addUser(arr:Array):void
    {
        friendListArr=friendListArr.concat(arr);
		eventDispatcher.dispatchEvent(new FriendListProxyEvent(FriendListProxyEvent.ADDED_FRIEND));
    }

	private var filterTargetId:String = "";
	private function userFilterHandler(element:*, index:int, arr:Array):Boolean
	{
		return (FriendVO(element).fb_id != filterTargetId)
	}
	
    public function removeUserById(fbId:String):void
    {
		filterTargetId = fbId;
		friendListArr = friendListArr.filter(userFilterHandler);
		eventDispatcher.dispatchEvent(new FriendListProxyEvent(FriendListProxyEvent.REMOVED_FRIEND));
    }
	
	public function getAllFriends():Array
	{
		return friendListArr;
	}
}
}
