package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class OnlineVO extends ValueObject
	{
		/*auther     :jim
		* file       :OnlineVO.as
		* date       :May 4, 2015
		* description:
		*/
		public var tableId:String ="";
		public var userId:String = "";
		public function OnlineVO()
		{
			super();
		}
	}
}