package com.jzgame.model
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.vo.ActionVO;
	import com.jzgame.vo.PreRoundInfoVO;
	import com.jzgame.vo.PreRoundPlayerInfoVO;

	public class PreRoundInfoModel
	{
		/*auther     :jim
		* file       :PreRoundInfoModel.as
		* date       :Mar 11, 2015
		* description:
		*/
		//前几轮手牌
		private var preList:Array = [];
		//最多记录局数
		private var max:uint = 60;
		//时间周期 7天
		private var maxTime:uint = 7;
		
		public var onePage:uint = 15;
		public function PreRoundInfoModel()
		{
//			var vo:PreRoundInfoVO = new PreRoundInfoVO;
//			vo.blinds = 40;
//			vo.date = "2015/4/5";
//			var playerRoundVo:PreRoundPlayerInfoVO = new PreRoundPlayerInfoVO;
//			playerRoundVo.card = [1,2];
//			playerRoundVo.playerName = "test one";
//			playerRoundVo.startChip = 10000;
//			playerRoundVo.firstAction = new ActionVO(1001,PlayerStatus.PLAYING_FOLD);
//			vo.flopCards.push(10);
//			vo.flopCards.push(20);
//			vo.flopCards.push(30);
//			vo.turnCard = 35;
//			vo.riverCard = 40;
//			vo.playerList = [playerRoundVo,playerRoundVo,playerRoundVo,playerRoundVo,playerRoundVo,playerRoundVo];
		}
		/**
		 * 加入记录 
		 * @param vo
		 * 
		 */		
		public function push(vo:PreRoundInfoVO):void
		{
			var length:uint = preList.length;
			
			if(length >= max)
			{
				preList.shift();
			}
			preList.push(vo);
		}
		/**
		 * 保存记录 
		 * 
		 */		
		public function flush():void
		{
			var string:String = JSON.stringify(preList);
			HttpSendProxy.sendPlayRecord(string);
		}
		/**
		 * 解析 
		 * @param json
		 * 
		 */		
		public function prase(value:Object,myUserId:uint):void
		{
			preList.splice(0,preList.length);
			
			var one:Object;
			for(var index:String in value)
			{
				one = value[index];
				var vo:PreRoundInfoVO = new PreRoundInfoVO;
				vo.blinds = one.blinds;
				vo.date = one.date;
				vo.turnCard = one.turnCard;
				vo.riverCard = one.riverCard;
				vo.flopCards = one.flopCards;
				var prvo:Object;
				for(var jindex:String in one.playerList)
				{
					prvo = one.playerList[jindex];
					var playerRoundVo:PreRoundPlayerInfoVO = new PreRoundPlayerInfoVO;
					for(var ii:String in prvo.card)
					{
						playerRoundVo.card.push(prvo.card[ii]);
					}
					playerRoundVo.playerName = prvo.playerName;
					playerRoundVo.startChip = prvo.startChip;
					
					
					playerRoundVo.userId = prvo.userId;
					playerRoundVo.seat = prvo.seat;
					playerRoundVo.fbId = prvo.fbId;
					playerRoundVo.isWin = prvo.isWin;
					playerRoundVo.orderChip = prvo.orderChip;
					playerRoundVo.winChip = prvo.winChip;
					playerRoundVo.winCardType = prvo.winCardType;
					if(prvo.beforeAction)
					{
						playerRoundVo.beforeAction = ActionVO.prase(prvo.beforeAction);
					}
					if(prvo.firstAction)
					{
						playerRoundVo.firstAction = ActionVO.prase(prvo.firstAction);
					}
					if(prvo.secondAction)
					{
						playerRoundVo.secondAction = ActionVO.prase(prvo.secondAction);
					}
					if(prvo.thirdAction)
					{
						playerRoundVo.thirdAction = ActionVO.prase(prvo.thirdAction);
					}
					if(prvo.forthAction)
					{
						playerRoundVo.forthAction = ActionVO.prase(prvo.forthAction);
					}
					vo.playerList.push(playerRoundVo);
					//检测我的info
					if(playerRoundVo.userId == myUserId)
					{
						vo.myRoundInfo = playerRoundVo;
					}
				}
				push(vo);
			}
		}
		/**
		 * 获取记录牌局列表
		 * @return 
		 * 
		 */		
		public function getList():Array
		{
			return preList.concat();
		}
		
		public function getTimeList():Array
		{
			var ccc:Array = preList.sortOn('date',Array.NUMERIC);
			
			return ccc;
		}
		
		public function getBonusList():Array
		{
			var ccc:Array = preList.sortOn('myWin',Array.NUMERIC);
			
			return ccc.reverse();
		}
	}
}