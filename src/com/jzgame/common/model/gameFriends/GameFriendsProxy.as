package com.jzgame.common.model.gameFriends
{

import com.jzgame.common.events.SimpleEvent;
import com.jzgame.common.services.MessageType;
import com.jzgame.common.utils.LangManager;
import com.jzgame.common.vo.FriendVO;
import com.jzgame.common.vo.GameFriendVO;
import com.jzgame.enmu.EventType;
import com.spellife.util.TimerManager;

import flash.events.IEventDispatcher;

/**
 * 保存游戏内的好友列表
 * @author Rakuten
 *
 */
public class GameFriendsProxy
{
	public var current:int = 1;
	public var onePage:uint = 7;
	public var pages:uint = 1;
	public var totalFriendNum:uint = 0;
    public function GameFriendsProxy()
    {
    }

	[Inject]
	public var eventDispatcher:IEventDispatcher;

    private var friendListArr:Array = [];
//	/**
//	 * 好友页数 
//	 * @return 
//	 * 
//	 */	
//	public function get maxPage():uint
//	{
//		return Math.ceil(friendListArr.length / onePage);
//	}
	
	/**
	 * 设置游戏中好友列表 
	 * @param arr
	 * 
	 */
    public function setData(arr:Array):void
    {
        friendListArr = arr;
		friendListArr.sortOn("chip",Array.NUMERIC);
		friendListArr = friendListArr.reverse();
		eventDispatcher.dispatchEvent(new GameFriendsProxyEvent(GameFriendsProxyEvent.INIT_GAME_FRIENDS));
    }
	/**
	 * 更新信息 
	 * @param value
	 * 
	 */	
	public function updateInfo(value:Object,interfaceName:String):void
	{
		var fr:FriendVO;
		var gf:GameFriendVO;
		var gameFriendArr:Array = [];
		for(var i:String in value)
		{
			gf = new GameFriendVO;
			gf.name = value[i]["name"];
			gf.chip = Number(value[i]["chip"]);
			gf.fb_id= value[i]["fb_id"];
			gf.id = i;
			gameFriendArr.push(gf);
		}
		
		setData(gameFriendArr);
		
		
		switch(interfaceName)
		{
			case MessageType.DELETE_FRIEND:
			{
				eventDispatcher.dispatchEvent(new SimpleEvent(EventType.ERROR_CODE_WINDOW,LangManager.getText("202307")));
				break;
			}
			case MessageType.ADD_FRIEND:
			{
				eventDispatcher.dispatchEvent(new SimpleEvent(EventType.ERROR_CODE_WINDOW,LangManager.getText("202306")));
				break;
			}
		}
	}
	
	/**
	 * 添加好友 
	 * @param arr
	 * 
	 */
    public function addUser(arr:Array):void
    {
        friendListArr=friendListArr.concat(arr);
		eventDispatcher.dispatchEvent(new GameFriendsProxyEvent(GameFriendsProxyEvent.ADDED_GAME_FRIEND));
    }
	/**
	 * 获取好友信息 
	 * @param id 游戏id
	 * 
	 */	
	public function getUserById(id:String):GameFriendVO
	{
		filterTargetId = id;
		var list:Array = friendListArr.filter(userFilterHandler);
		return list[0];
	}
	
	private var filterTargetId:String = "";
	/**
	 * 查找过滤 
	 * @param element
	 * @param index
	 * @param arr
	 * @return 
	 * 
	 */	
	private function userFilterHandler(element:GameFriendVO, index:int, arr:Array):Boolean
	{
		return (GameFriendVO(element).id == filterTargetId)
	}
	/**
	 * 移除过滤 
	 * @param element
	 * @param index
	 * @param arr
	 * @return 
	 * 
	 */	
	private function userRemoveFilterHandler(element:GameFriendVO, index:int, arr:Array):Boolean
	{
		return (GameFriendVO(element).fb_id != filterTargetId)
	}
	
	public function removeUserById(fbId:String):void
	{
		filterTargetId = fbId;
		friendListArr = friendListArr.filter(userRemoveFilterHandler);
		eventDispatcher.dispatchEvent(new GameFriendsProxyEvent(GameFriendsProxyEvent.REMOVED_GAME_FRIEND));
    }
	
	/**
	 * 获取好友信息根据名字 
	 * @param id 游戏id
	 * 
	 */
	public function getUserByName(fname:String):Array
	{
		if(fname=="")return getAllFriendsInvite();
		filterTargetId = fname;
		return friendListArr.filter(friendNameFilterHandler);
	}
	
	/**
	 * 查找过滤 
	 * @param element
	 * @param index
	 * @param arr
	 * @return 
	 * 
	 */	
	private function friendNameFilterHandler(element:GameFriendVO, index:int, arr:Array):Boolean
	{
		return (GameFriendVO(element).name == filterTargetId)
	}
	
	/**
	 * 获取最近登录
	 * @return 
	 * 
	 */	
	public function getRecentFriendsInvite():Array
	{
		var tempArr:Array = friendListArr.concat();
		var temp:Array = tempArr.filter(recentFilterHandler);
		temp.sortOn("last_login_time",Array.NUMERIC);
		temp.reverse();
		var tempLength:int = temp.length - onePage;
		var vo:GameFriendVO;
		//如果好友不满足一页，则补足invite
		if(tempLength < 0)
		{
			for(var m:uint = 0; m<Math.abs(tempLength); m++)
			{
				vo = new GameFriendVO();
				vo.id = "0";
				temp.push(vo);
			}
		}else
		{
			vo = new GameFriendVO();
			vo.id = "0";
			temp.push(vo);
		}
		
		return temp;
	}
	/**
	 * 最近登录 
	 * @param element
	 * @param index
	 * @param arr
	 * @return 
	 * 
	 */	
	private function recentFilterHandler(element:GameFriendVO, index:int, arr:Array):Boolean
	{
		//7 days
		return (Number((GameFriendVO(element).last_login_time) + 604800)  >= TimerManager.getCurrentSysTime())
	}
	
	/**
	 * 获取所有朋友包括邀请 
	 * @return 
	 * 
	 */	
	public function getAllFriendsInvite():Array
	{
		var tempArr:Array = friendListArr.concat();
//		var temp:int = friendListArr.length - onePage;
//		var vo:GameFriendVO;
//		//如果好友不满足一页，则补足invite
//		if(temp < 0)
//		{
//			for(var m:uint = 0; m<Math.abs(temp); m++)
//			{
//				vo = new GameFriendVO();
//				vo.id = "0";
//				tempArr.push(vo);
//			}
//		}else
//		{
//			vo = new GameFriendVO();
//			vo.id = "0";
//			tempArr.push(vo);
//		}
		
		return tempArr; 
	}
	/**
	 * 获取所有好友不包括邀请 
	 * @return 
	 * 
	 */	
	public function getAllFriends():Array
	{
		return friendListArr.concat();
	}
}
}
