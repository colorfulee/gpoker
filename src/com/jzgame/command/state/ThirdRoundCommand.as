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
	
	public class ThirdRoundCommand extends Command
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
		public function ThirdRoundCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var type:uint = uint(event.data);
			switch(type)
			{
				case 0:
					table.currentSeat = 7;
					break;
				case 1:
					turnHandle();
					break;
				case 2:
					actionHandler();
					break;
			}
		}
		
		private function actionHandler():void
		{
			var next:uint = table.next();
			if(next == table.mySeat)
			{
				
			}else
			{
				var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_CHECK);
				eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
				table.currentSeat = next;
				trace("third action:",next,table.currentSeat,actionVo.state);
//				if(table.currentSeat == table.dealerSeat)
//				{
//					trace("third turn end.");
//					eventDis.dispatchEvent(new Event(EventType.TURN_END));
//				}else
//				{
//					eventDis.dispatchEvent(new Event(EventType.NEXT_TURN));
//				}
			}
		}
		
		
		private function turnHandle():void
		{
			var next:uint = table.next();
			eventDis.dispatchEvent(new SimpleEvent(EventType.TURN,next));
			if(next==table.mySeat)
			{
				eventDis.dispatchEvent(new Event(EventType.GUIDE_MY_TURN_TO_MAIN));
			}
			trace("third turn:",next,table.currentSeat);
		}
	}
}