package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class PreRoundInfoVO extends ValueObject
	{
		/*auther     :jim
		* file       :PreRoundInfoVO.as
		* date       :Mar 11, 2015
		* description:
		*/
//		PreRoundPlayerInfoVO
		public var playerList:Array = [];
		//我的信息
		public var myRoundInfo:PreRoundPlayerInfoVO;
		//日期
		public var date:Number;
		public var flopCards:Array = [];
		public var turnCard:Number = 0;
		public var riverCard:Number = 0;
		//大盲
		public var blinds:Number = 0;
		private var _myWin:Number = 0;
		public function PreRoundInfoVO()
		{
			super();
		}

		public function get myWin():Number
		{
			if(myRoundInfo)
			{
				return myRoundInfo.win
			}
			return _myWin;
		}

		/**
		 * 销毁 
		 * 
		 */		
		public function dispose():void
		{
			flopCards.splice(0,flopCards.length);
			playerList.splice(0,flopCards.length);
		}
	}
}