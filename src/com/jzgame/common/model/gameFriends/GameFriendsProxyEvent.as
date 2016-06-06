package com.jzgame.common.model.gameFriends
{
import flash.events.Event;
/**
 * 
 * @author Rakuten
 * 
 */
public class GameFriendsProxyEvent extends Event
{
	static public const INIT_GAME_FRIENDS:String = "initGameFriends";
	static public const ADDED_GAME_FRIEND:String = "addedGameFriend";
	static public const REMOVED_GAME_FRIEND:String = "removedGameFriend";
	
    public function GameFriendsProxyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
    {
        super(type, bubbles, cancelable);
    }
	
	override public function clone():Event
	{
		var cloneEvent:GameFriendsProxyEvent = new GameFriendsProxyEvent(type, bubbles, cancelable);
		return cloneEvent;
	}
}
}
