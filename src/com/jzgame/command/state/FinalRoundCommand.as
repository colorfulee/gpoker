package com.jzgame.command.state
{
	import com.jzgame.enmu.EventType;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.model.TableModel;
	import com.jzgame.common.services.protobuff.PlayerStatus;
	import com.jzgame.vo.ActionVO;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class FinalRoundCommand extends Command
	{
		/*auther     :jim
		* file       :ThirdRoundCommand.as
		* date       :Aug 28, 2014
		* description:
		*/
		
		[Inject]
		public var table:TableModel;
		
		[Inject]
		public var eventDis:IEventDispatcher;
		
		[Inject]
		public var event:SimpleEvent;
		public function FinalRoundCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var type:uint = uint(event.data);
			switch(type)
			{
				case 0:
					table.currentSeat = 9;
					break;
				case 1:
					turnHandle();
					break;
				case 2:
					actionHandler();
					break;
				case 3:
					raiseHandler();
					break;
			}
		}
		
		private function actionHandler():void
		{
			var next:uint = table.next();
			var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_CHECK);
			eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
			table.currentSeat = next;
			trace("final action:",next,table.currentSeat , table.dealerSeat);
		}
		
		private function raiseHandler():void
		{
			var next:uint = table.next();
			var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_CALL,1200);
			eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
			table.currentSeat = next;
		}
		
		
		private function turnHandle():void
		{
			var next:uint = table.next();
			eventDis.dispatchEvent(new SimpleEvent(EventType.TURN,next));
			if(next==table.mySeat)
			{
				eventDis.dispatchEvent(new Event(EventType.GUIDE_MY_TURN_TO_MAIN));
			}
			trace("final turn:",next,table.currentSeat);
		}
	}
}