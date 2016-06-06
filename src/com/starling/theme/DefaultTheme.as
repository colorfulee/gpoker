package com.starling.theme
{
	import feathers.controls.Button;
	import feathers.core.DisplayListWatcher;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	
	public class DefaultTheme extends DisplayListWatcher
	{
		/***********
		 * name:    DefaultTheme
		 * data:    Nov 9, 2015
		 * author:  jim
		 * des:     默认主题
		 ***********/
		public function DefaultTheme(topLevelContainer:DisplayObjectContainer)
		{
			super(topLevelContainer);
		}
		
		override protected function addedHandler(event:Event):void
		{
			super.addedHandler(event);
			
			init();
		}
		
		private function init():void
		{
			setInitializerForClass(Button,buttonInitHandler,"test");
		}
		
		private function buttonInitHandler( button:Button ):void
		{
//			button.defaultSkin = new Image( upTexture );
//			button.downSkin = new Image( downTexture );
//			button.hoverSkin = new Image( hoverTexture );
//			
//			button.defaultLabelProperties.textFormat = this.smallUIDarkTextFormat;
//			button.disabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
//			button.selectedDisabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
		}
	}
}