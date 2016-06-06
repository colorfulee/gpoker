package com.jzgame.command
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.enmu.ActiviesID;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.ActivitiesModel;
	import com.jzgame.model.RankModel;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandleActivitiesListCommand extends Command
	{
		/***********
		 * name:    HandleActivitiesListCommand
		 * data:    Sep 29, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var eventDis:IEventDispatcher;
		[Inject]
		public var rankModel:RankModel;
		[Inject]
		public var activitiesModel:ActivitiesModel;
		public function HandleActivitiesListCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			updateInfo(event);
		}
		
		private function updateInfo(e:HttpResponseEvent):void
		{
			if(e.result)
			{
				//存储活动id
				var data:Array = [];
				var red:Boolean = false;
				for(var i:String in e.result)
				{
					var target:Object = new Object;
					target.id = i;
					target.showRed = false;
					data.push(target);
					switch(i)
					{
						case ActiviesID.MISTERY:
							rankModel.misteryTicket = e.result[ActiviesID.MISTERY].ticket;
							rankModel.misteryTicketRank = e.result[ActiviesID.MISTERY].ticket_rank;
							rankModel.misteryTotalTicket = e.result[ActiviesID.MISTERY].ticket_total;
							break;
						case ActiviesID.FESTERVAL:
							var r1002:Object = e.result[ActiviesID.FESTERVAL];
							var ft:Object = r1002.task;
							if(ft)
							{
								activitiesModel.festervalTask = [];
							}
							
							var taskList:Array = [];
							for(var ti:String in ft)
							{
								if(ft[ti].status == 1)
								{
									taskList.push(ft[ti]);
									target.showRed = true;
									red = true;
								}else
								{
									activitiesModel.festervalTask.push(ft[ti]);
								}
							}
							
							activitiesModel.festervalTask.sortOn("status",Array.NUMERIC);
							
							activitiesModel.festervalTask = taskList.concat(activitiesModel.festervalTask);
							
							activitiesModel.festervalCard = [];
							
							for(var ca:String in r1002.card)
							{
								var n:uint = r1002.card[ca];
								activitiesModel.festervalCard.push(n>0?n:n+51);
							}
							activitiesModel.festervalPoint = r1002.point;
							
							break;
						
						case ActiviesID.RAIDER:
//							"1004": {
//							"type": "4",
//							"start_time": 1442710800,
//							"end_time": 1446166800,
//							"pics": {         #碎片
//								"1001": 1,
//								"1002": 2,
//								"1003": 10,
//								"1025": 220
//							}
							var r1004:Object = e.result[ActiviesID.RAIDER];

							var pics:Object = r1004.pics;
							activitiesModel.puzzleInfo=pics;
							activitiesModel.puzzleStart = r1004.start_time;
							activitiesModel.puzzleEnd = r1004.end_time;
							break;
						case ActiviesID.HUNTER:
							var r1003:Object = e.result[ActiviesID.HUNTER];
							var fh:Object = r1003.task;
							if(fh)
							{
								activitiesModel.hunterTask = [];
							}
							var taskkkList:Array = [];
							for(var th:String in fh)
							{
								if(fh[th].status == 1)
								{
									taskkkList.push(fh[th]);
								}else
								{
									activitiesModel.hunterTask.push(fh[th]);
								}
							}
							activitiesModel.hunterTask.sortOn("status",Array.NUMERIC);
							activitiesModel.hunterTask = taskkkList.concat(activitiesModel.hunterTask);
							
//							"point":"0","bonus":{"30":0,"60":0,"90":0,"120":0}
							activitiesModel.hunterStart   = r1003.start_time;
							activitiesModel.hunterEnd = r1003.end_time;
							activitiesModel.hunterPoint = r1003.point;
							activitiesModel.hunterBonus = [r1003.bonus["30"],r1003.bonus["60"],r1003.bonus["90"],r1003.bonus["120"]];
							if(r1003.point >= 120)
							{
								for(var a:uint = 0;a<4;a++)
								{
									if(activitiesModel.hunterBonus[a] == "0")
									{
										activitiesModel.hunterBonus[a] = "2";
									}
								}
							}else if(r1003.point >= 90)
							{
								for(var b:uint = 0;b<3;b++)
								{
									if(activitiesModel.hunterBonus[b] == "0")
									{
										activitiesModel.hunterBonus[b] = "2";
									}
								}
							}else if(r1003.point >= 60)
							{
								for(var c:uint = 0;c<2;c++)
								{
									if(activitiesModel.hunterBonus[c] == "0")
									{
										activitiesModel.hunterBonus[c] = "2";
									}
								}
							}else if(r1003.point >= 30)
							{
								if(activitiesModel.hunterBonus[0] == "0")
								{
									activitiesModel.hunterBonus[0] = "2";
								}
							}
							break;
					}
				}
//				view.setData(data);
				
				eventDis.dispatchEvent(new SimpleEvent(EventType.UPDATE_ACTIVITES_LIST,data));
				eventDis.dispatchEvent(new SimpleEvent(EventType.EVENT_RED_TIP,red));
			}
		}
	}
}