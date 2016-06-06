package com.jzgame.command
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.achiement.AchiementProxy;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.vo.AchievementVO;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.UserModel;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandleAchieCommand extends Command
	{
		/*auther     :jim
		* file       :HandleAchieCommand.as
		* date       :May 6, 2015
		* description:处理成就
		*/
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var eventDis:IEventDispatcher;
		[Inject]
		public var e:HttpResponseEvent;
		[Inject]
		public var achie:AchiementProxy;
		[Inject]
		public var gameModel:GameModel;
		public function HandleAchieCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var result:Object = e.data["r"];
			
			var achievement:Object = result["achievement"];
			
			var vo:AchievementVO;
			var g:Number = 0;
			var s:Number = 0;
			var t:Number = 0;
			
			Configure.achievementConfig.updateCurrent(userModel.playerDetail,userModel.myInfo.userId == gameModel.tipUserId);
			//			var tot:Number = 0;
			var first:Number = 0;
			var second:Number = 0;
			var third:Number = 0;
			for(var i:String in achievement)
			{
				vo = Configure.achievementConfig.getAchievementById(i);
				vo.status = achievement[i]["status"];
				vo.finish_time = achievement[i]["finish_time"] ? achievement[i]["finish_time"] : "0";
				vo.bonus_time = achievement[i]["bonus_time"];
				//				5 筹码总数达到XXX 6 玩的总局数达到XXX 7 胜利的总局数达到XXX 8 失败的总局数达到XXX 9 游戏内好友数量达到XXX 10 FB邀请好友数量达到XXX 11 送出礼物的次数达到XXX 12 收到礼物的次数达到XXX 
				if(vo.status == "1" || vo.status == "2")
				{
					switch(Number(vo.level))
					{
						case 1:
							g++;
							break;
						case 2:
							s++;
							break;
						case 3:
							t++;
							break;
					}
					
					switch(Number(vo.firstlabel))
					{
						case 1:
							first ++;
							break;
						case 2:
							second ++;
							break;
						case 3:
							third ++;
							break;
					}
				}
			}
			
			achie.goldP = g;
			achie.silP = s;
			achie.treP = t;
			achie.first =first;
			achie.second = second;
			achie.third = third;
			
//			var temp:Array = Configure.achievementConfig.getList(0,0);
//			for(var uu:String in temp)
//			{
//				trace(temp[uu]);
//			}
			
			eventDis.dispatchEvent(new Event(EventType.UPDATE_ACHIE));
			
		}
	}
}