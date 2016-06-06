package com.jzgame.common.model.task
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.vo.TaskConfigVO;
	import com.jzgame.common.vo.TaskVO;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HttpReceivedTaskCommand extends Command
	{
		/*auther     :jim
		* file       :HttpReceivedTaskCommand.as
		* date       :Dec 11, 2014
		* description:
		*/
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var eventDispatcher:IEventDispatcher;
//		[Inject]
//		public var gameModel:GameModel;
		[Inject]
		public var taskProxy:TaskProxy;
//		[Inject]
//		public var taskConfigModel:TaskConfigModel;
		public function HttpReceivedTaskCommand()
		{
			super();
		}
		
//		"e": 0,
//		"r": {
//			"task": {
//				"902001": {
//					"status": "2",
//					"finish_time": "1418123398",
//					"bonus_time": "1418180003"
//				},
//				"902002": {
//					"status": "1",
//					"finish_time": "1418123398",
//					"bonus_time": "0"
//				},
//				"902003": {
//					"status": "1",
//					"finish_time": "1418123398",
//					"bonus_time": "0"
//				}
//			}
//		}

		override public function execute():void
		{
			var error:uint = event.data["e"];
			if(error > 0)
			{
				return;
			}
			var result:Object = event.data["r"];
			var task:Object = result["task"];
			var uuidList:Array = event.request.data;
			var vo:TaskVO;
			taskProxy.removeAll();
			
			var configVO:TaskConfigVO;
			var nowList:Array = [];
			var limitList:Array = [];
			for(var kk:String in task)
			{
				vo = Configure.taskConfig.getTaskById(kk);
				vo.status  = task[kk]["status"];
				vo.current = task[kk]["current"];
				vo.finishTime = task[kk]["finish_time"];
				//如果已经领奖结束则不显示
				if(vo.status == 2)
				{
					continue;
				}
				
				if(vo.taskConfigVO.limited == 1)
				{
					vo.taskConfigVO.start_time = task[kk]["start_time"];
					vo.taskConfigVO.end_time = task[kk]["end_time"];
					limitList.push(vo);
				}else
				{
					nowList.push(vo);
				}
			}
			limitList.sortOn("status",Array.DESCENDING);
			nowList.sortOn("status",Array.DESCENDING);
			taskProxy.setLimitData(limitList);
			taskProxy.setData(nowList);
		}
	}
}