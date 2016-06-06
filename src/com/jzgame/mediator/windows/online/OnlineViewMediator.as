package com.jzgame.mediator.windows.online
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.model.SocketSendProxy;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.online.OnlineView;
	import com.spellife.util.TimerManager;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class OnlineViewMediator extends StarlingMediator
	{
		/***********
		 * name:    OnlineViewMediator
		 * data:    Jan 8, 2016
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:OnlineView;
		[Inject]
		public var userModel:UserModel;
		public function OnlineViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.addEventListener(TouchEvent.TOUCH,touchHandler);
			addContextListener(EventType.COUNT_DOWN_BOX, countDownBoxUpdataHandler);
		}
		
		override public function destroy():void
		{
			removeContextListener(EventType.COUNT_DOWN_BOX, countDownBoxUpdataHandler);
			view.removeEventListener(TouchEvent.TOUCH,touchHandler);
		}
		
		private function touchHandler(e:TouchEvent):void
		{
			if(e.getTouch(view,TouchPhase.ENDED))
			{
				if(userModel.myInfo.uSeatIndex>0)
				{
					if(userModel.openOnlineTime)
					{
						//倒计时 如果大于0
						if(userModel.onlineTime>0)
						{
							getReward();
						}else
						{
							SocketSendProxy.sendOnlineReward();
						}
					}
				}else
				{
					WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText("10206"));
				}
			}
		}
		
		/**
		 * 同步倒计时时间 
		 * @param e
		 */		
		private function countDownBoxUpdataHandler(e:SimpleEvent):void
		{
			if(e.carryData)
			{
				userModel.openOnlineTime=true;
				if(userModel.onlineTime>0 && int(e.carryData["remaining"])>0 && int(e.carryData["remaining"])>userModel.onlineTime)
				{
					//userModel.onlineTime = userModel.onlineTime;
				}
				else
				{
					userModel.onlineTime = int(e.carryData["remaining"]);
				}
				
				//				trace("在线时间:"+userModel.onlineTime);
				if(userModel.onlineTime>0)
				{
					TimerManager.getInstance().addCallBack(1000,onlineTimeFun);
				}
				else
				{
					TimerManager.getInstance().removeCallBack(1000,onlineTimeFun);
				}
				
				
				onlineTimeFun();
			}
		}
		/**
		 * 更新倒计时 
		 * 
		 */		
		private function onlineTimeFun():void
		{
			if(userModel.onlineTime>0)
			{
				userModel.onlineTime-=1;
			}else
			{
				userModel.onlineTime=0;
			}
		}
		/**
		 * 领奖 
		 * 
		 */		
		private function getReward():void
		{
			var timeStr:String="";
			if(userModel.onlineTime>0)
			{
				var surplus:int=userModel.onlineTime;
				var hour:int=0;
				var min:int=0;
				var seconds:int=0;
				
				if(surplus>=3600)
				{
					hour=Math.floor(surplus/3600);
					surplus=surplus%3600;
				}
				if(surplus>=60)
				{
					min=Math.floor(surplus/60);
					surplus=surplus%60;
				}
				
				seconds=surplus;
				
				if(hour>=10)
				{
					timeStr+=String(hour)+":";
				}
				else
				{
					timeStr+="0"+String(hour)+":";
				}
				
				if(min>=10)
				{
					timeStr+=String(min)+":";
				}
				else
				{
					timeStr+="0"+String(min)+":";
				}
				
				if(seconds>=10)
				{
					timeStr+=String(seconds);
				}
				else
				{
					timeStr+="0"+String(seconds);
				}
				
				WindowFactory.addPopUpWindow(WindowFactory.FADE_TIP_WINDOW,null,LangManager.getText('500256',timeStr));
			}
			else
			{
				userModel.onlineTime=0;
				timeStr="00:00:00";
			}
		}
	}
}