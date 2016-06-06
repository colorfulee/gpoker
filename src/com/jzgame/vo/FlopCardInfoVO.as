package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	public class FlopCardInfoVO extends ValueObject
	{
		/*auther     :jim
		* file       :FlopCardInfoVO.as
		* date       :Aug 27, 2014
		* description:
		*/
		public var card:CardInfoVO;
		public var index:uint = 0;
		
		public function FlopCardInfoVO(index_:uint,card_:CardInfoVO)
		{
			super();
			
			index = index_;
			card  = card_;
		}
		
		override public function toString():String
		{
			return "第"+index+"张牌,牌值:"+card.number+"牌类型:"+card.type;
		}
	}
}