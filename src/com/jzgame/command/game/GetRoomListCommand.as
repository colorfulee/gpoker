package com.jzgame.command.game
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.MTTAttendModel;
	import com.jzgame.model.RoomModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.vo.room.RingRoomInfoVO;
	import com.jzgame.vo.room.RoomBaseInfoVO;
	import com.jzgame.vo.room.SitAndGoTourTableListInfo;
	import com.jzgame.vo.room.SpecialAllInTableListInfo;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class GetRoomListCommand extends Command
	{
		/*auther     :jim
		* file       :GetRoomListCommand.as
		* date       :Apr 7, 2015
		* description:房间列表处理中心
		*/
		
		[Inject]
		public var roomModel:RoomModel;
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var attendModel:MTTAttendModel;
		[Inject]
		public var eventDis:IEventDispatcher;
		public function GetRoomListCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			WindowFactory.hideCommuWindow();
			
			var result:Object = event.result;
			if(!result)return;
			
			var index:String
			
			var ring:Object = result["shark"];
			if(ring)
			{
				roomModel.shark.splice(0,roomModel.shark.length);
				for(index in ring)
				{
					updateRoomListInfo(ring[index],index,roomModel.shark);
				}
			}
			
			ring = result["master"];
			if(ring)
			{
				roomModel.master.splice(0,roomModel.master.length);
				for(index in ring)
				{
					updateRoomListInfo(ring[index],index,roomModel.master);
				}
			}
			ring = result["fish"];
			if(ring)
			{
				roomModel.fish.splice(0,roomModel.fish.length);
				for(index in ring)
				{
					updateRoomListInfo(ring[index],index,roomModel.fish);
				}
			}
			ring = result["newbie"];
			if(ring)
			{
				roomModel.newBi.splice(0,roomModel.newBi.length);
				for(index in ring)
				{
					updateRoomListInfo(ring[index],index,roomModel.newBi);
				}
			}
			ring = result["fast"];
			if(ring)
			{
				roomModel.fast.splice(0,roomModel.fast.length);
				for(index in ring)
				{
					updateRoomListInfo(ring[index],index,roomModel.fast);
				}
			}
			
			var sitandgo:Object =result["sit_and_go"];
			if(sitandgo)
			{
				roomModel.tournamentSG.splice(0,roomModel.tournamentSG.length);
				updateSpeTourRoomListInfo( sitandgo,roomModel.tournamentSG);
			}
			
			var mtt:Object = result["mtt"];
			if(mtt)
			{
				attendModel.updateMTTList(mtt);
			}
			
			var allin:Object =result["all_in"];
			if(allin)
			{
				roomModel.allinList.splice(0,roomModel.allinList.length);
				for(index in allin)
				{
					updateSpeAllInRoomListInfo( allin[index],index,roomModel.allinList);
				}
			}
			
			eventDis.dispatchEvent(new Event(EventType.UPDATE_ROOM_LIST));
		}
		
		/**
		 * 处理单个房间类型列表 
		 * @param value
		 * 
		 */		
		private function updateRoomListInfo(value:Object,num:String,arr:Array):void
		{
			var ringNew:Object = value;
			var ip:Array = ringNew.ip.split(":");
			var room:RoomBaseInfoVO = new RoomBaseInfoVO;
			room.host = ip[0];
			room.port = ip[1]
			room.id = Number(num);
			room.blinds =ringNew["blinds"].split("/")[0];
			room.online =ringNew["online"].split("/")[0];
			room.maxRole = ringNew["online"].split("/")[1];
			room.minBuy = ringNew["min_buy"];
			room.maxBuy = ringNew["max_buy"];
			room.limit  = ringNew["limit"];
			room.tableName = ringNew["table"];
			arr.push(room);
			
			var ring:RingRoomInfoVO;
			if(roomModel.mobile.hasOwnProperty(room.maxBuy.toString()))
			{
				ring = roomModel.mobile[room.maxBuy.toString()];
				ring.online +=room.online;
				ring.rooms.push(room.id);
			}else
			{
				roomModel.mobile[room.maxBuy.toString()] = new RingRoomInfoVO();
				ring = roomModel.mobile[room.maxBuy.toString()];
				ring.online +=room.online;
				ring.blinds = room.blinds;
				ring.max = room.maxBuy;
				ring.rooms.push(room.id);
			}
			
		}
		/**
		 * 更新特殊房间列表
		 * @param value
		 * @param lib
		 * 
		 */		
		private function updateSpeTourRoomListInfo(value:Object,lib:Array):void
		{
			var ringNew:Object = value;
			var tableListInfo:SitAndGoTourTableListInfo;
			for(var index:String in ringNew)
			{
				tableListInfo = new SitAndGoTourTableListInfo;
				tableListInfo.id = Number(index);
				tableListInfo.attendance_fee = ringNew[index]["attendance_fee"];
				tableListInfo.online = ringNew[index]["kick_off_time"].split("/")[0];
				tableListInfo.maxRole = ringNew[index]["kick_off_time"].split("/")[1];
				tableListInfo.service_fee = ringNew[index]["service_fee"];
				tableListInfo.sign_up = ringNew[index]["sign_up"];
				tableListInfo.champion_prize = ringNew[index]["champion_prize"];
				lib.push(tableListInfo);
			}
		}
		/**
		 * 更新all in 玩法特殊房间列表
		 * @param value
		 * @param lib
		 * 
		 */		
		private function updateSpeAllInRoomListInfo(value:Object,index:String,lib:Array):void
		{
			var ringNew:Object = value;
			var tableListInfo:SpecialAllInTableListInfo;
			//			for(var index:String in ringNew)
			{
				tableListInfo = new SpecialAllInTableListInfo;
				tableListInfo.id = uint(index);
				tableListInfo.reward = ringNew["reward"];
				tableListInfo.online = ringNew["online"].split("/")[0];
				tableListInfo.maxRole = ringNew["online"].split("/")[1];
				tableListInfo.enter_cost = ringNew["enter_cost"];
				tableListInfo.service_cost = ringNew["service_cost"];
				tableListInfo.table = ringNew["table"];
				lib.push(tableListInfo);
			}
		}
	}
}