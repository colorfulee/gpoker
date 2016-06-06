package com.jzgame.vo
{
	import com.jzgame.enmu.Card;
	import com.spellife.vo.ValueObject;

	public class CardInfoVO extends ValueObject
	{
		/*auther     :jim
		* file       :CardInfoVO.as
		* date       :Aug 27, 2014
		* description:
		*/
		
		public var type:uint = 0;//花色
		public var value:uint = 1;//牌面
		public var number:uint = 0;//原值
		public function CardInfoVO(type_:uint,value_:uint,cardNum:uint = 0)
		{
			super();
			
			type  = type_;
			value = value_;
			number = cardNum;
		}
		
		override public function toString():String
		{
			return getCardType(type)+value;
		}
		
		private function getCardType(type:uint):String
		{
			var name:String = "";
			switch(type)
			{
				case Card.SUIT_BLACK_HEART:
					name = "黑桃";
					break;
				case Card.SUIT_CLUBS:
					name = "梅花";
					break;
				case Card.SUIT_DIAMONDS:
					name = "方片";
					break;
				case Card.SUIT_RED_HEART:
					name = "红桃";
					break;
			}
			
			return name;
		}
	}
}