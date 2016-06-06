package com.jzgame.command
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.model.DailyModel;
	import com.jzgame.model.NoteModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindowManager;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandleNoteCommand extends Command
	{
		/*auther     :jim
		* file       :HandleNoteCommand.as
		* date       :May 28, 2015
		* description:公告
		*/
		[Inject]
		public var note:NoteModel;
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var dailyModel:DailyModel;
		public function HandleNoteCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			WindowFactory.hideCommuWindow();
			
			note.update(event.result);
			
			if(userModel.newer)return;
			
			if(note.getList().length > 0)
			{
				WindowFactory.addAutoPopUpWindow(WindowFactory.NOTE_WINDOW);
			}
			
			if(userModel.myInfo.todayLoginBonus == 1)
			{
				WindowFactory.addAutoPopUpWindow(WindowFactory.SEVEN_LOGIN_BONUS_WINDOW);
			}
			
			PopUpWindowManager.autoPopUp();
		}
	}
}