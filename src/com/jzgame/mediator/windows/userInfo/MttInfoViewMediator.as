package com.jzgame.mediator.windows.userInfo
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.model.MTTAttendModel;
	import com.jzgame.view.windows.userInfo.MttInfoView;
	import com.spellife.util.TimerManager;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	public class MttInfoViewMediator extends StarlingMediator
	{
		/***********
		 * name:    MttInfoViewMediator
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:MttInfoView;
		[Inject]
		public var mttModel:MTTAttendModel;
		public function MttInfoViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			addContextListener(MessageType.SPE_MTT_GLOBAL_RANK,updateInfo,HttpResponseEvent);
			
			HttpSendProxy.sendSpeMTTRank();
		}
		
		override public function destroy():void
		{
			removeContextListener(MessageType.SPE_MTT_GLOBAL_RANK,updateInfo,HttpResponseEvent);
			
			view.dispose();
		}
		
		private function updateInfo(e:HttpResponseEvent):void
		{
			if(e.result)
			{
				mttModel.updateGlobalRank(e.result);
				//			"uid": "1007",
				//			"fb_id": "012345678901007",
				//			"fb_first_name": "Player",
				//			"fb_last_name": "1007",
				//			"join_times": "15",
				//			"champion_times": "4",
				//			"runner_up_times": "6",
				//			"second_runner_up_times": "3",
				//			"total_prize": "14",
				//			"last_match_time": "1430998200",
				//			"last_match_rank": "1",
				//			"rank": "2"
				view.time.text = LangManager.getText("301731") + ":"+mttModel.mttSelfInfo.join_times;
				view.champTime.text = LangManager.getText("301730") + ":"+mttModel.mttSelfInfo.champion_times;
				view.lastRank.text = LangManager.getText("301733") + ":"+mttModel.mttSelfInfo.last_match_rank;
				view.lastTime.text = LangManager.getText("301732") + ":"+TimerManager.getTimerFormat(mttModel.mttSelfInfo.last_match_time);
			}
		}
	}
}