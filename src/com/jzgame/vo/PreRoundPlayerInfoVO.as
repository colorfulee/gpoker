package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class PreRoundPlayerInfoVO extends ValueObject
	{
		/*auther     :jim
		* file       :PreRoundPlayerInfoVO.as
		* date       :Mar 11, 2015
		* description:
		*/
		//玩家id
		public var userId:uint = 0;
		//座位
		public var seat:uint = 0;
		//手牌列表
		public var card:Array = [];
		//玩家姓名
		public var playerName:String = "";
		//fbid
		public var fbId:String = "";
		//开局带入的筹码
		public var startChip:Number = 0;
		//是否赢得主池的筹码
		public var isWin:Boolean = false;
		//只存储大小盲
		public var beforeAction:ActionVO;
		//记录行为
//		public var actions:Vector.<ActionVO> = new Vector.<ActionVO>;
		//压注
		public var orderChip:Number = 0;
		//赢得注
		public var winChip:Number = 0;
		//赢牌类型
		public var winCardType:uint = 0;
		//首轮操作
		public var firstAction:ActionVO;
		public var secondAction:ActionVO;
		public var thirdAction:ActionVO;
		public var forthAction:ActionVO;
		public function PreRoundPlayerInfoVO()
		{
			super();
		}
		
		public function get win():Number
		{
			return winChip - orderChip;
		}
	}
}