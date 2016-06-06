package com.jzgame.command
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.PlayerRecordsModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.vo.PlayerRecordsVO;
	import com.netease.protobuf.Int64;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.describeType;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandleUserSummaryCommand extends Command
	{
		/*auther     :jim
		* file       :HandleUserSummaryCommand.as
		* date       :Apr 14, 2015
		* description:
		*/
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var recordsModel:PlayerRecordsModel;
		[Inject]
		public var eventDis:IEventDispatcher;
		public function HandleUserSummaryCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			WindowFactory.hideCommuWindow();
			
			var detail:Object = event.data["r"]["detail"];
			var records:Object = event.data["r"]["play_record"];
			for(var index:String in detail)
			{
				// 再过滤Vector 
				var xml:XML = describeType(userModel.playerDetail[index]); 
				var type:String = ("" + xml.@name) 
				if(!(type.length > 18 && type.slice(0, 19) == "__AS3__.vec::Vector"))
				{
					userModel.playerDetail[index] = detail[index];
				}else
				{
					for(var m:String in detail[index])
					{
						userModel.playerDetail[index].push(detail[index][m]);
					}
				}
			}
//			如果更新的是我个人信息
			if(userModel.playerDetail.uid == userModel.myInfo.userId.toString())
			{
//				userModel.myInfo.uPendingExp = userModel.playerDetail.
//				userModel.myInfo.uLevelExp = userInfo["exp"];
				userModel.myInfo.uRank = userModel.playerDetail.chip_rank;
				userModel.myInfo.uGamePlayed = userModel.playerDetail.play_num;
				userModel.myInfo.uWinning = userModel.playerDetail.winning;
				userModel.myInfo.uMaxWin = userModel.playerDetail.max_win;
				userModel.myInfo.uScore = userModel.playerDetail.score;
//				userModel.myInfo.uEverMaxScore = userModel.playerDetail.;
				userModel.myInfo.uMoney = new Int64(userModel.playerDetail.chip);
				userModel.myInfo.uGold = userModel.playerDetail.coin;
//				userModel.myInfo.uEquipId = userInfo["equip_gift_id"];
				userModel.myInfo.uFB_ID = userModel.playerDetail.fb_id;
//				userModel.myInfo.uVipLevel = userModel.playerDetail;
				userModel.myInfo.uMaxCards = userModel.playerDetail.max_card;
				
				eventDis.dispatchEvent(new Event(EventType.UPDATE_USER_INFO));
			}
			
			var recordsVO:PlayerRecordsVO;
			for(var time:String in records)
			{
				recordsVO = new PlayerRecordsVO;
				for(var i:String in records[time])
				{
					if(recordsVO.hasOwnProperty(i))
					{
						recordsVO[i] = records[time][i];
					}
				}
				recordsModel.addRecords(time,recordsVO);
			}
			eventDis.dispatchEvent(new Event(EventType.UPDATE_USER_SUMMARY));
		}
	}
}