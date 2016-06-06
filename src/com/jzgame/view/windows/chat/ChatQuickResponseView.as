package com.jzgame.view.windows.chat
{
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Sprite;
	
	public class ChatQuickResponseView extends Sprite
	{
		/***********
		 * name:    ChatQuickResponseView
		 * data:    Jan 12, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _wordsList:List;
		public function ChatQuickResponseView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_wordsList = new List();
			_wordsList.x = 65;
			_wordsList.width  = 410;
			_wordsList.height = 490;
			addChild(_wordsList);
			_wordsList.itemRendererType = ChatQuickWordItem;
			
			var layout:VerticalLayout = new VerticalLayout;
			layout.gap = 1;
			_wordsList.itemRendererProperties.height = 55;
			_wordsList.layout = layout;
		}
		
		public function setList(arr:Array):void
		{
			_wordsList.dataProvider = new ListCollection(arr);
		}
	}
}