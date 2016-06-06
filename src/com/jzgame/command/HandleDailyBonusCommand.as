package com.jzgame.command
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.DailyModel;
	import com.jzgame.vo.DailyBonusItemVO;
	import com.jzgame.vo.DailyLoginInfoVO;
	import com.spellife.util.TimerManager;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandleDailyBonusCommand extends Command
	{
		/***********
		 * name:    HandleDailyBonusCommand
		 * data:    Jun 23, 2015
		 * author:  jim
		 * des:     日常奖励数据处理中心
		 ***********/
		
		[Inject]
		public var dailyModel:DailyModel;
		[Inject]
		public var event:HttpResponseEvent;
		
		[Inject]
		public var eventDis:IEventDispatcher;
		public function HandleDailyBonusCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var result:Object = event.result;
			return;
			var task:Object = result["daily_task"];
			var item:DailyBonusItemVO;
			var show:Boolean = false;
			for(var index:String in task)
			{
				item = Configure.dailyBonus.getItemById(index);
				item.current = task[index]["point"];
				item.status = (Number(task[index]["status"]));
				
				if(item.status == 1 )
				{
					show = true;
					break;
				}
			}
			
			
			//			"daily_task": {
			//				"10001": {
			//					"task_id": 10001,  
			//					"target": 30,
			//					"point": "0", 
			//					"status": "0"   #0默认  1完成 2领取过奖励
			//				}
			//			},
			
			//			"daily_chips": {
			//				"login_bonus": 0,
			//				"friend_bonus": 1,
			//				"vip_bonus": "0", 
			//				"bonused": "1"   #是否领取过奖励
			//			},
			
			//			"daily_login": {
			//				"201501": {
			//					"days": "1",
			//					"fill_days": "0",
			//					"bonused_7": "0",
			//					"bonused_15": "0",
			//					"bonused_31": "0"
			//				},
			//				"201412": {
			//					"days": "27",
			//					"fill_days": "0",
			//					"bonused_7": 0,
			//					"bonused_15": 0,
			//					"bonused_31": "0"
			//				}
			var chips:Object = result["daily_chips"];
			dailyModel.friendBonus = chips.friend_bonus;
			dailyModel.friendNum = chips.invite_num;
			dailyModel.loginBonus  = chips.login_bonus;
			dailyModel.vipBonus    = chips.vip_bonus;
			dailyModel.getBonus    = chips.bonused == "1";
			//登录信息
			var login:Object = result["daily_login"];
			var d:DailyLoginInfoVO;
			for(var i:String in login)
			{
				d = new DailyLoginInfoVO;
				d.days = login[i].days;
				d.fillDays = login[i].fill_days;
				d.bonus15 = login[i].bonused_15;
				d.bonus7 = login[i].bonused_7;
				d.bonus31 = login[i].bonused_31;
				d.year = Number(i.substr(0,4));
				d.month = Number(i.substr(4,6));
				if(d.month.toString() == TimerManager.getSysMonth())
				{
					dailyModel.month = d;
				}else
				{
					dailyModel.lastMonth = d;
				}
			}
			
			eventDis.dispatchEvent(new SimpleEvent(EventType.CHANGE_DAILY_TASK_TIP,show));
			eventDis.dispatchEvent(new Event(EventType.UPDATE_DAILY_TASK));
		}
	}
}