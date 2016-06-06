package com.jzgame.enmu
{
	import com.spellife.util.HtmlTransCenter;

	public class Card
	{
		/*auther     :jim
		* file       :Card.as
		* date       :Aug 27, 2014
		* description:
		*/
		public static var EACH_MAX:uint = 4;
//		Suit: 花色(s-spades黑桃 h-hearts红桃 d-diamonds方块 c-clubs梅花)
		public static var SUIT_RED_HEART:uint = 1;//红桃
		public static var SUIT_BLACK_HEART:uint = 2;//黑桃
		public static var SUIT_DIAMONDS:uint = 3;//方块 
		public static var SUIT_CLUBS:uint = 4;//梅花
		
		public static var HEART_STR:String = '♥';
		public static var BLACK_HEART_STR:String = '♠';
		public static var SUIT_DIAMONDS_STR:String = '♦';
		public static var SUIT_CLUBS_STR:String = '♣';
		
		public static var INFO_A:uint = 1;//
		public static var INFO_2:uint = 2;//
		public static var INFO_3:uint = 3;//
		public static var INFO_4:uint = 4;//
		public static var INFO_5:uint = 5;//
		public static var INFO_6:uint = 6;//
		public static var INFO_7:uint = 7;//
		public static var INFO_8:uint = 8;//
		public static var INFO_9:uint = 9;//
		public static var INFO_10:uint = 10;//
		public static var INFO_J:uint = 11;//
		public static var INFO_Q:uint = 12;//
		public static var INFO_K:uint = 13;//
		
		
		public function Card()
		{
		}
		
		public static function praseCardString(card:Number):String
		{
			var num:uint = Math.floor(card / Card.EACH_MAX);
			var type:uint = card % Card.EACH_MAX;
			num+=2;
			if(num==14)
			{
				num = 1;
			}
			
			var temp:String = num.toString();
			switch(num)
			{
				case 1:
					temp = "A"
					break;
				case 13:
					temp = "K"
					break;
				case 12:
					temp = "Q"
					break;
				case 11:
					temp = "J"
					break;
				default:
					temp = num.toString();
					break;
			}
			
			switch(type)
			{
				case 0:
					type = Card.SUIT_BLACK_HEART;
					return BLACK_HEART_STR + temp;
					return HtmlTransCenter.getHtmlStr(HEART_STR,SystemColor.STR_BLACK,12) + temp;
					break;
				case 1:
					type = Card.SUIT_RED_HEART;
					return HEART_STR + temp;
					return HtmlTransCenter.getHtmlStr(HEART_STR,SystemColor.STR_RED_TEXT,12) + temp;
					break;
				case 2:
					type = Card.SUIT_DIAMONDS;
					return SUIT_DIAMONDS_STR + temp;
					return HtmlTransCenter.getHtmlStr(SUIT_DIAMONDS_STR,SystemColor.STR_BLACK,12) + temp;
					break;
				case 3:
					type = Card.SUIT_CLUBS;
					return SUIT_CLUBS_STR + temp;
					return HtmlTransCenter.getHtmlStr(SUIT_CLUBS_STR,SystemColor.STR_BLACK,12) + temp;
					break;
			}
			return "";
		}
		/**
		 * 
		 * @param num
		 * @return 
		 * 
		 */		
		public static function praseNum(num:Number):String
		{
			var temp:String = num.toString();
			switch(num)
			{
				case 1:
					temp = "A"
					break;
				case 13:
					temp = "K"
					break;
				case 12:
					temp = "Q"
					break;
				case 11:
					temp = "J"
					break;
				default:
					temp = num.toString();
					break;
			}
			
			return temp;
		}
	}
}