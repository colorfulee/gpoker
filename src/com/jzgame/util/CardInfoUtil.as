package com.jzgame.util
{
	import com.jzgame.common.services.protobuff.PlayerStatus;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.enmu.Card;
	import com.jzgame.vo.CardInfoVO;

	public class CardInfoUtil
	{
		/*auther     :jim
		* file       :CardInfoUtil.as
		* date       :Oct 10, 2014
		* description:
		*/
		public function CardInfoUtil()
		{
		}
		/**
		 * 
		 * @param card
		 * @return 
		 * 
		 */
		public static function praseCardInfo(card:Number):CardInfoVO
		{
			var num:uint = Math.floor(card / Card.EACH_MAX);
			var type:uint = card % Card.EACH_MAX;
			num+=2;
			if(num==14)
			{
				num = 1;
			}
			switch(type)
			{
				case 0:
					type = Card.SUIT_BLACK_HEART;
					break;
				case 1:
					type = Card.SUIT_RED_HEART;
					break;
				case 2:
					type = Card.SUIT_DIAMONDS;
					break;
				case 3:
					type = Card.SUIT_CLUBS;
					break;
			}
			return new CardInfoVO(type,num , card);
		}
		/**
		 * 最大手牌 
		 * @param cards
		 * @return 
		 * 
		 */		
		public static function praseMaxCards(cards:String):String
		{
			//最好手牌
			var max:String=" ";
			if(cards != "")
			{
				var temp:Array = cards.split(AssetsCenter.COMMA);
				for(var i:String in temp)
				{
					max += Card.praseCardString(temp[i]) +" ";
				}
			}else
			{
				max = "--";
			}
			
			return max
		}
		
		/**
		 * 获取玩家状态描述
		 * @param state
		 * @return 
		 * 
		 */
		public static function getStateNameByState(state:uint):String
		{
			var str:String = LangManager.getText("402026");
			switch(state)
			{
				case PlayerStatus.PLAYING_ALLIN:
					str = "全押";
					str = LangManager.getText("300903");
					break;
				case PlayerStatus.PLAYING_CALL:
					str = "跟注";
					str = LangManager.getText("300917");
					break;
				case PlayerStatus.PLAYING_FOLD:
					str = "弃牌";
					str = LangManager.getText("300915");
					break;
				case PlayerStatus.PLAYING_BLIND_LITTLE:
					str = "小盲";
					str = LangManager.getText("300927");
					break;
				case PlayerStatus.PLAYING_BLIND_BIGGER:
					str = "大盲";
					str = LangManager.getText("300926");
					break;
				case PlayerStatus.PLAYING_IDLE:
					str = "等待";
					str = LangManager.getText("300925");
					break;
				case PlayerStatus.PLAYING_CHECK:
					str = "过牌";
					str = LangManager.getText("300916");
					break;
				case PlayerStatus.PLAYING_RAISE:
					str = "加注";
					str = LangManager.getText("300918");
					break;
				case PlayerStatus.PLAYING_ANTE:
					str = "前注";
					str = LangManager.getText("300918");
					break;
				case PlayerStatus.PLAYING_READY:
					str = "等待";
					str = LangManager.getText("300925");
					break;
				default:
					Tracer.error("为什么是空闲状态:"+state);
					break;
			}
			return str;
		}
		
		/**
		 * 
		 * @param type
		 * @return 
		 * 
		 */		
		public static function getCardType(type:uint):String
		{
			var name:String = "";
			switch(type)
			{
				case Card.SUIT_BLACK_HEART:
					name = LangManager.getText("301531");
					name = Card.BLACK_HEART_STR;
					break;
				case Card.SUIT_CLUBS:
					name = LangManager.getText("301532");
					name = Card.SUIT_CLUBS_STR;
					break;
				case Card.SUIT_DIAMONDS:
					name = LangManager.getText("301533");
					name = Card.SUIT_DIAMONDS_STR;
					break;
				case Card.SUIT_RED_HEART:
					name = LangManager.getText("301534");
					name = Card.HEART_STR;
					break;
			}
			
			return name;
		}
	}
}