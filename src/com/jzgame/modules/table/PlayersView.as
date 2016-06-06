package com.jzgame.modules.table
{
	import starling.display.Sprite;
	
	public class PlayersView extends Sprite
	{
		/***********
		 * name:    PlayersView
		 * data:    Nov 17, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var playerContainer:Sprite = new Sprite;
		public var chatContainer:Sprite = new Sprite;
		public function PlayersView()
		{
			super();
			
			
			addChild(playerContainer);
			addChild(chatContainer);
		}
	}
}