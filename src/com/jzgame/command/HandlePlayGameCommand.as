package com.jzgame.command
{
	import com.jzgame.events.HandleJoinTableEvent;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.RoomModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.model.UserProxy;
	import com.jzgame.vo.room.RoomBaseInfoVO;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandlePlayGameCommand extends Command
	{
		/*auther     :jim
		* file       :HandlePlayGameCommand.as
		* date       :May 26, 2015
		* description:自动加入牌局
		*/
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var roomModel:RoomModel;
		[Inject]
		public var gameModel:GameModel;
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		public function HandlePlayGameCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var tempList:Array; 
			var money:Number = userModel.myInfo.uMoney.toNumber();
			if(money >= roomModel.masterLimit)
			{
				tempList = roomModel.master.concat();
			}else if(money>=roomModel.sharkLimit)
			{
				tempList = roomModel.shark.concat();
			}else if(money>=roomModel.fishLimit)
			{
				tempList = roomModel.fish.concat();
			}else
			{
				tempList = roomModel.newBi.concat();
			}
			//根据小盲筹码排序
			tempList.sortOn("minBuy",Array.NUMERIC);
			tempList.reverse();
			
			var maxRole:uint = 5;
			var tvo:RoomBaseInfoVO;
			if(tempList.length > 0)
			{
				//匹配有人并且没满的桌子
				for(var i:String in tempList)
				{
					tvo = tempList[i];
					
					if(roomModel.autoJoinTableRoomRoleNum!=0)
					{
						if(roomModel.autoJoinTableRoomRoleNum == 1)
						{
							maxRole = 5;
						}else
						{
							maxRole = 9;
						}
						//如果房间不符合自动进入人数,则略过
						if(tvo.maxRole != maxRole)
						{
							continue;
						}
					}
					//如果身上的钱不满足自动买入筹码，则略过
					if(tvo.blinds * 200 > money) continue;
					//符合不满房间
					if(tvo.online > 0 && tvo.online < tvo.maxRole)
					{
						gameModel.autoSit = true;
						eventDispatcher.dispatchEvent(new HandleJoinTableEvent(tvo.id.toString()));
						roomModel.autoJoinTableRoomRoleNum = 0;
						return;
					}
				}
				//如果到了这里，就匹配空桌子或者满桌子
				for(var mm:String in tempList)
				{
					tvo = tempList[mm];
					
					if(roomModel.autoJoinTableRoomRoleNum!=0)
					{
						if(roomModel.autoJoinTableRoomRoleNum == 1)
						{
							maxRole = 5;
						}else
						{
							maxRole = 9;
						}
						//如果房间不符合自动进入人数,则略过
						if(tvo.maxRole != maxRole)
						{
							continue;
						}
					}
					
					//如果身上的钱不满足自动买入筹码，则略过
					if(tvo.blinds * 200 > money) continue;
					
					if(tvo.online == 0 || tvo.online == tvo.maxRole )
					{
						gameModel.autoSit = true;
						eventDispatcher.dispatchEvent(new HandleJoinTableEvent(tvo.id.toString()))
						roomModel.autoJoinTableRoomRoleNum = 0;
						return;
					}
				}
				//如果身上的钱不满足自动买入筹码，检测最后一个。
				if(!UserProxy.checkValid(tvo.blinds * 200,1)) return;
			}
		}
	}
}