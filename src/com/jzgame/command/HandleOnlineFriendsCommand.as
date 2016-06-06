package com.jzgame.command
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.OnLineModel;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandleOnlineFriendsCommand extends Command
	{
		/*auther     :jim
		* file       :HandleOnlineFriendsCommand.as
		* date       :May 7, 2015
		* description:处理在线好友列表
		*/
		[Inject]
		public var online:OnLineModel;
		[Inject]
		public var e:HttpResponseEvent;
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		public function HandleOnlineFriendsCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if(e.result)
			{
				if(e.result.hasOwnProperty("online"))
				{
					online.updateInfo(e.result);
					eventDispatcher.dispatchEvent(new Event(EventType.UPDATE_ONLINE_FRIEND));
				}
			}
		}
	}
}