package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class ResultVO extends ValueObject
	{
		/*auther     :jim
		* file       :ResultVO.as
		* date       :Aug 29, 2014
		* description:
		*/
		
		public var winnerID:Array=[];
		public var winnerType:uint;
		public var winnerCardList:Vector.<WinnerCardInfo> = new Vector.<WinnerCardInfo>;
//		public var cardInfoList:Vector.<CardInfoVO> = new Vector.<CardInfoVO>;
		public var clip:Array=[];
		public var chipID:uint = 0;
		
		public function ResultVO()
		{
			super();
		}
		
		public function reset():void
		{
			winnerID.splice(0,winnerID.length);
			winnerCardList.splice(0,winnerCardList.length);
			clip.splice(0,clip.length);
		}
	}
}