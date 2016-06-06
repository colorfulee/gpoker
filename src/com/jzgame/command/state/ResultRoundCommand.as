package com.jzgame.command.state
{
	import com.jzgame.enmu.ClipType;
	import com.jzgame.enmu.EventType;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.model.TableModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.vo.ResultVO;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ResultRoundCommand extends Command
	{
		/*auther     :jim
		* file       :ResultRoundCommand.as
		* date       :Aug 28, 2014
		* description:结局回合
		*/
		
		[Inject]
		public var table:TableModel;
		
		[Inject]
		public var eventDis:IEventDispatcher;
		
		[Inject]
		public var event:SimpleEvent;
		
		[Inject]
		public var userModel:UserModel;
		public function ResultRoundCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var result:ResultVO = new ResultVO;
			result.chipID = ClipType.MAIN;
			result.winnerID = [userModel.myInfo.userId];
			result.clip = [4800];
			
			//克隆玩家状态,避免玩家此时退出，导致无个人信息
			userModel.copyUserList();
			
			eventDis.dispatchEvent(new SimpleEvent(EventType.SHOW_RESULT,result));
			trace("result round execute.");
		}
	}
}