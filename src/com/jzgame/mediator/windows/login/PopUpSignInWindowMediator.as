package com.jzgame.mediator.windows.login
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.vo.SevenLoginBonus;
	import com.jzgame.model.DailyModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.view.windows.login.PopUpSignInWindow;
	import com.spellife.util.TimerManager;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class PopUpSignInWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpSignInWindowMediator
		 * data:    Dec 18, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpSignInWindow;
		[Inject]
		public var dailyModel:DailyModel;
		[Inject]
		public var userModel:UserModel;
		public function PopUpSignInWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.signBtn.addEventListener(Event.TRIGGERED,signHandler);
			view.descBtn.addEventListener(Event.TRIGGERED,descHandler);
			addContextListener(MessageType.SEVEN_LOGIN_INFO,updateInfoHandler);
			
			if(view.motionEffect)
			{
				view.addEventListener(Event.COMPLETE, startNet);
			}else
			{
				startNet(null);
			}
		}
		
		override public function destroy():void
		{
			view.descBtn.removeEventListener(Event.TRIGGERED,descHandler);
			view.signBtn.removeEventListener(Event.TRIGGERED,signHandler);
			removeContextListener(MessageType.SEVEN_LOGIN_INFO,updateInfoHandler);
		}
		
		private function startNet(e:Event):void
		{
			HttpSendProxy.sendSevenInfo();
		}
		
		private function updateStatusHandler(e:HttpResponseEvent):void
		{
			HttpSendProxy.sendSevenInfo();
		}
		private function updateInfoHandler(e:HttpResponseEvent):void
		{
			var result:Object = e.result;
			if(result)
			{
				var total:uint = 0;
				dailyModel.dailyBonus = [];
				dailyModel.totalBonus = [];
				for(var i:uint = 0; i< 7 ;i++)
				{
					Configure.sevenLoginBonus.getItemById(String(i+1)).status = uint(result[String(i+1)]);
					if(uint(result[String(i+1)])>0)
					{
						total++;
					}
					if(uint(result[String(i+1)])==1)
					{
						//如果是今天
						if(TimerManager.getSysWeekDay() == String(i+1))
						{
							dailyModel.dailyBonus.push(String(i+1));
						}
					}
				}
				var d3:SevenLoginBonus = Configure.sevenLoginTotalBonus.getItemById(String("3"));
				d3.status = uint(result["t3"]);
				if(total >= 3)
				{
					if(d3.status == 0)
					{
						dailyModel.totalBonus.push(String("3"));
					}
				}
				
				var d5:SevenLoginBonus = Configure.sevenLoginTotalBonus.getItemById(String("5"));
				d5.status = uint(result["t5"]);
				if(total >= 5)
				{
					if(d5.status == 0)
					{
						dailyModel.totalBonus.push(String("5"));
					}
				}
				
				var d7:SevenLoginBonus = Configure.sevenLoginTotalBonus.getItemById(String("7"));
				d7.status = uint(result["t7"]);
				
				if(total >= 7)
				{
					if(d7.status == 0)
					{
						dailyModel.totalBonus.push(String("7"));
					}
				}
				
				view.setData(total);
				
//				view.signBtn.isEnabled = userModel.myInfo.todayLoginBonus < 2;
//				view.signBtn.touchable = userModel.myInfo.todayLoginBonus < 2;
			}
		}
		/**
		 * 领奖 
		 * @param e
		 * 
		 */		
		private function signHandler(e:Event):void
		{
			view.closeWindow();
			HttpSendProxy.sendSevenReward();
		}
		/**
		 * 描述 
		 * @param e
		 * 
		 */		
		private function descHandler(e:Event):void
		{
			
		}
	}
}