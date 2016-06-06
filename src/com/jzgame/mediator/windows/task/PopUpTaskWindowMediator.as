package com.jzgame.mediator.windows.task
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.task.TaskProxy;
	import com.jzgame.common.model.task.TaskProxyEvent;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.util.ExternalCenter;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.task.PopUpTaskWindow;
	import com.spellife.display.PopUpWindowManager;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class PopUpTaskWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpTaskWindowMediator
		 * data:    Nov 27, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpTaskWindow;
		[Inject]
		public var task:TaskProxy;
		public function PopUpTaskWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			ExternalCenter.checkPoint(ExternalCenter.LOG_OPEN_TASK);
			
			addContextListener(TaskProxyEvent.INIT_TASK_LIST, updateTaskList);
			addContextListener(MessageType.TASK_BONUS, bonusBackTaskList);
			SignalCenter.onTaskReward.add(getRewardBtnHandler);
			view.sign.addEventListener(Event.TRIGGERED, showSignHandler);
			
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
			SignalCenter.onTaskReward.remove(getRewardBtnHandler);
			view.removeEventListener(Event.COMPLETE, startNet);
			view.sign.removeEventListener(Event.TRIGGERED, showSignHandler);
			removeContextListener(MessageType.TASK_BONUS, bonusBackTaskList);
			removeContextListener(TaskProxyEvent.INIT_TASK_LIST, updateTaskList);
			
			
			//窗口在关闭的时候不需要主动调用dispose，在popupmanager的时候会有removeFromparent(true)会调用dispose,container底层会自动dispose所有children
			//view.dispose();
		}
		private function startNet(e:Event):void
		{
			sendTaskList();
		}
		/**
		 * 获取任务列表 
		 * 
		 */		
		private function sendTaskList():void
		{
			HttpSendProxy.sendGetTaskList();
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function showSignHandler(e:Event):void
		{
			view.closeWindow();
			
			PopUpWindowManager.centerPopUpWindow(WindowFactory.addPopUpWindow(WindowFactory.SEVEN_LOGIN_BONUS_WINDOW) as DisplayObject);
		}
		/**
		 * 领奖结束 
		 * @param e
		 * 
		 */
		private function bonusBackTaskList(e:HttpResponseEvent):void
		{
			//更新任务列表
			sendTaskList();
		}
		/**
		 * 领奖 
		 * @param e
		 * 
		 */		
		private function getRewardBtnHandler(id:uint):void
		{
			HttpSendProxy.sendTaskReward(id.toString());
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function updateTaskList(e:TaskProxyEvent):void
		{
			view.setList(task.getAllTask());
//			view.reset();
//			view.missionList.setList(task.getAllTask());
//			view.missionList.list.selectedIndex=1;
//			changeDes();
			//			view.limitMission.dataProvider = taskProxy.getLimitTask();
		}
	}
}