package com.jzgame.command.state
{
	import com.jzgame.enmu.Card;
	import com.jzgame.enmu.EventType;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.model.TableModel;
	import com.jzgame.vo.CardInfoVO;
	import com.jzgame.vo.FlopCardInfoVO;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class CoverRoundCommand extends Command
	{
		/*auther     :jim
		* file       :CoverRoundCommand.as
		* date       :Aug 27, 2014
		* description:
		*/
		
		[Inject]
		public var model:TableModel;
		
		[Inject]
		public var eventDisp:IEventDispatcher;
		
		public function CoverRoundCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var coverCard:CardInfoVO = new CardInfoVO(Card.SUIT_CLUBS,Card.INFO_J);
			var flop:FlopCardInfoVO = new FlopCardInfoVO(1,coverCard);
			eventDisp.dispatchEvent(new SimpleEvent(EventType.FLOP_CARD,flop));
			
			coverCard = new CardInfoVO(Card.SUIT_DIAMONDS,Card.INFO_10);
			flop = new FlopCardInfoVO(2,coverCard);
			eventDisp.dispatchEvent(new SimpleEvent(EventType.FLOP_CARD,flop));
			
			coverCard = new CardInfoVO(Card.SUIT_DIAMONDS,Card.INFO_3);
			flop = new FlopCardInfoVO(3,coverCard);
			eventDisp.dispatchEvent(new SimpleEvent(EventType.FLOP_CARD,flop));
		}
	}
}