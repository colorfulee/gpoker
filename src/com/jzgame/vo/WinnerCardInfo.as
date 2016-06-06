package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class WinnerCardInfo extends ValueObject
	{
		/*auther     :jim
		* file       :WinnerCardInfo.as
		* date       :Nov 12, 2014
		* description:
		*/
		public var cardInfoList:Vector.<CardInfoVO> = new Vector.<CardInfoVO>;
		public function WinnerCardInfo()
		{
			super();
		}
	}
}