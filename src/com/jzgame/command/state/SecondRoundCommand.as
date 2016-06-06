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
	
	public class SecondRoundCommand extends Command
	{
		/*auther     :jim
		* file       :SecondRoundCommand.as
		* date       :Aug 28, 2014
		* description:
		*/
		[Inject]
		public var table:TableModel;
		
		[Inject]
		public var eventDis:IEventDispatcher;
		
		[Inject]
		public var event:SimpleEvent;
		
		public function SecondRoundCommand()
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
				//加注
				case 3:
					raiseActionHandler();
					break;
				case 7:
					handFold();
					break;
			}
		}
		
		/**
		 * 放弃手牌 
		 * 
		 */		
		private function handFold():void
		{
			var next:uint = table.next();
			var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_FOLD);
			eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
			table.currentSeat = next;
		}
		
		private function raiseActionHandler():void
		{
			var next:uint = table.next();
			var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_CALL,600);
			eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
			table.currentSeat = next;
		}
		
		private function actionHandler():void
		{
			var next:uint = table.next();
			//如果轮到我操作
			if(next == table.mySeat)
			{
			}else
			{
				var actionVo:ActionVO = new ActionVO(next,PlayerStatus.PLAYING_CALL,200);
				eventDis.dispatchEvent(new SimpleEvent(EventType.ACTION,actionVo));
				table.currentSeat = next;
				
				if(table.currentSeat == table.dealerSeat)
				{
					trace("second turn end.");
					eventDis.dispatchEvent(new Event(EventType.TURN_END));
				}else
				{
//					eventDis.dispatchEvent(new Event(EventType.NEXT_TURN));
				}
			}
		}
		
		
		private function turnHandle():void
		{
			var next:uint = table.next();
			eventDis.dispatchEvent(new SimpleEvent(EventType.TURN,next));
			
			trace("second turn:",next,table.currentSeat);
		}
	}
}