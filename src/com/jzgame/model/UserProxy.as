package com.jzgame.model
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.enmu.EventType;
	import com.jzgame.util.ExternalCenter;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.LessChipWindow;
	import com.jzgame.vo.UserBaseVO;
	
	import flash.events.Event;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;

	public class UserProxy
	{
		/*auther     :jim
		* file       :UserProxy.as
		* date       :Apr 15, 2015
		* description:个人信息汇总
		*/
		public static var myInfo:UserBaseVO;
		public static var CHIP:uint = 1;
		public static var GOLD:uint = 2;
		public static var ROBOT_ID_RANGE:Number = 1000000;
		public function UserProxy()
		{
		}
		/**
		 * 
		 * @param rank
		 * @return 
		 * 
		 */		
		public static function checkRank(rank:uint):String
		{
			if(rank == 0)
			{
				return ">10000";
			}
			
			return rank.toString();
		}
		/**
		 * 
		 * @param value
		 * @param type
		 * @return 
		 * 
		 */		
		public static function checkValid(value:Number,type:uint = 1):Boolean
		{
			var window:LessChipWindow;
			if(type == CHIP)
			{
				if(value > myInfo.uMoney.toNumber())
				{
//					if(myInfo.chip_box > 0)
//					{
//						WindowFactory.addPopUpWindow(WindowFactory.LESS_CHIP_WITH_BANK_WINDOW,null,myInfo.isset_box_pwd);
//					}else
//					{
//						WindowFactory.addPopUpWindow(WindowFactory.LESS_CHIP_WINDOW,null,addChip);
//					}
					WindowFactory.addPopUpWindow(WindowFactory.LESS_CHIP_WINDOW,null,addChip);
					return false;
				}
			}else
			{
				if(value > myInfo.uGold)
				{
					WindowFactory.addPopUpWindow(WindowFactory.LESS_CHIP_WINDOW,null,addCoin);
					return false;
				}
			}
			
			return true;
		}
		/**
		 * 检测最大筹码《如果我的筹码超过房间筹码，则不可进入
		 * @param chip
		 * @return 
		 * 
		 */		
		public static function checkChip(chip:Number):Boolean
		{
			if(chip == 0) return true;
			if(myInfo.uMoney.toNumber() > chip)
			{
				feathers.controls.Alert.show(LangManager.getText("402216",chip),"less",new ListCollection([{label:'ok'}]));
//				WindowFactory.addPopUpWindow(WindowFactory.ALERT,null,LangManager.getText("402216",chip),Alert.OK,playNow);
				return false;
			}
			return true;
		}
		/**
		 * 立即玩牌
		 */		
		private static function playNow():void
		{
			ExternalCenter.checkPoint(ExternalCenter.LOG_PLAY_NOW);
			AssetsCenter.eventDispatcher.dispatchEvent(new Event(EventType.PLAY_NOW_IN_TABLE));
		}
		/**
		 * 充值 
		 * 
		 */		
		public static function addChip():void
		{
			ExternalCenter.addChip();
		}
		public static function addCoin():void
		{
			ExternalCenter.addChip(false);
		}
	}
}