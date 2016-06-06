package com.jzgame.common.model.friendList
{
import flash.events.Event;
/**
 * 
 * @author Rakuten
 * 
 */
public class FriendListProxyEvent extends Event
{
	static public const INIT_FRIEND_LIST:String = "initFriendList";
	static public const ADDED_FRIEND:String = "addedFriend";
	static public const REMOVED_FRIEND:String = "removedFriend";
	
    public function FriendListProxyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
    {
        super(type, bubbles, cancelable);
    }
	
	override public function clone():Event
	{
		var cloneEvent:FriendListProxyEvent = new FriendListProxyEvent(type, bubbles, cancelable);
		return cloneEvent;
	}
}
}
