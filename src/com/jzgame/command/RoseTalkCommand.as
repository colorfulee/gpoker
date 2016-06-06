package com.jzgame.command
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.RoseTalkType;
	import com.jzgame.events.RoseTalkEvent;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class RoseTalkCommand extends Command
	{
		/***********
		 * name:    RoseTalkCommand
		 * data:    Jul 22, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var event:RoseTalkEvent;
		[Inject]
		public var eventDisp:IEventDispatcher;
		public function RoseTalkCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			switch(uint(event.talkType))
			{
				case RoseTalkType.ROUND_START:
					eventDisp.dispatchEvent(new SimpleEvent(EventType.ROSE_REAL_TALK,LangManager.getText("402225")));
					break;
				case RoseTalkType.COUNTING:
					eventDisp.dispatchEvent(new SimpleEvent(EventType.ROSE_REAL_TALK,LangManager.getText("402227",event.uName)));
					break;
				case RoseTalkType.ALL_IN:
					eventDisp.dispatchEvent(new SimpleEvent(EventType.ROSE_REAL_TALK,LangManager.getText("402226")));
					break;
				case RoseTalkType.GOOD_CARD_TYPE:
					var txt:String = LangManager.getText("402228",event.uName,LangManager.getText(String(301500 + event.cardWinType)));
					eventDisp.dispatchEvent(new SimpleEvent(EventType.ROSE_REAL_TALK,txt));
					break;
			}
		}
	}
}