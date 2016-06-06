package com.jzgame.mediator.windows.note
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.NoteEnum;
	import com.jzgame.events.AddSourceEvent;
	import com.jzgame.model.NoteModel;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.note.PopUpNoteWindow;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import feathers.data.ListCollection;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	public class PopUpNoteWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpNoteWindowMediator
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpNoteWindow;
		[Inject]
		public var note:NoteModel;
		public function PopUpNoteWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			var list:Array = note.getList();
			changePageHandler(null);
		}
		
		override public function destroy():void
		{
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function changePageHandler(e:Event):void
		{
			var list:Array = note.getList();
			var listC:ListCollection = new ListCollection(list);
			for(var i:String in list)
			{
				list[i].label = list[i].msg;
			}
			view.tabBar.dataProvider = listC;
			//			tabBar.dataProvider = new ListCollection(
			//				[
			//					{ label: LangManager.getText("300704") }
			//				]);
			if(list.length > 0)
			{
				view.tabBar.selectedIndex = 0;
			}
		}
		
		/**
		 * 点击链接 
		 * @param e
		 * 
		 */		
		private function linkHandler(e:MouseEvent):void
		{
			var data:Object = note.getList()[view.tabBar.selectedIndex];
			
			var temp:Array = String(data.link).split("url:");
			//外链
			if(temp.length > 1)
			{
				navigateToURL(new URLRequest(temp[1]),"_blank");
			}else
			{
				temp = String(data.link).split("_");
				switch(String(temp[0]))
				{
					case NoteEnum.ACHIEVEMENT:
						WindowFactory.addPopUpWindow(WindowFactory.PLAYER_INFO_WINDOW,null,2);
						break;
					case NoteEnum.MISSION:
						WindowFactory.addPopUpWindow(WindowFactory.MISSION_WINDOW);
						break;
					case NoteEnum.STORE:
						switch(String(temp[1]))
						{
							case NoteEnum.GIFT:
								WindowFactory.addPopUpWindow(WindowFactory.STORE_WINDOW,null,1);
								break;
							case NoteEnum.ITEM:
								WindowFactory.addPopUpWindow(WindowFactory.STORE_WINDOW,null,2);
								break;
							case NoteEnum.VIP:
								WindowFactory.addPopUpWindow(WindowFactory.STORE_WINDOW,null,3);
								break;
						}
						break;
					case NoteEnum.BUY:
						if(String(temp[1]) == NoteEnum.GOLD)
						{
							AssetsCenter.eventDispatcher.dispatchEvent(new AddSourceEvent(false));
						}else
						{
							AssetsCenter.eventDispatcher.dispatchEvent(new AddSourceEvent(true));
						}
						break;
					case NoteEnum.RINGGAME:
						dispatch(new SimpleEvent(EventType.CHANGE_ROOM_TYPE,data.link));
						view.closeWindow();
						break;
					case NoteEnum.TOURNAMENT:
						dispatch(new SimpleEvent(EventType.CHANGE_ROOM_TYPE,NoteEnum.TOURNAMENT));
						view.closeWindow();
						break;
					case NoteEnum.JACKPOT:
						if(String(temp[1]) == NoteEnum.RULE)
						{
							WindowFactory.addPopUpWindow(WindowFactory.JACK_POT_WINDOW,null,2);
						}
						//						view.closeWindow();
						break;
					case NoteEnum.LOGIN_DAYS:
						WindowFactory.addPopUpWindow(WindowFactory.SEVEN_LOGIN_BONUS_WINDOW,null);
						//						view.closeWindow();
						break;
				}
			}
		}
	}
}