package com.jzgame.view
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class MainView extends Sprite
	{
		public var pop:Sprite = new Sprite;
		public var container:Sprite = new Sprite;
		
		public var table:DisplayObject;
		public function MainView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			addChild(container);
			addChild(pop);
		}
	}
}