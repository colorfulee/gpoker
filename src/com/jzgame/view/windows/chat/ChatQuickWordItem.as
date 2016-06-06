package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.SignalCenter;
	import com.starling.theme.StyleProvider;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Shape;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ChatQuickWordItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    ChatQuickWordItem
		 * data:    Jan 12, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _shape:Shape;
		public function ChatQuickWordItem()
		{
			super();
			
			defaultLabelProperties.textFormat = StyleProvider.getTF(0xb3a7db,20);
			
			_shape = new Shape;
			_shape.graphics.beginFill(0x34273c);
			_shape.graphics.drawRect(0,0,422,1);
			_shape.graphics.endFill();
			
			_shape.y = 55;
			addChild(_shape);
			
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		private function touchHandler(e:TouchEvent):void
		{
			if(e.getTouch(this,TouchPhase.ENDED))
			{
				SignalCenter.onChatQuickWordTriggered.dispatch(String(data));
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			this.removeEventListener(TouchEvent.TOUCH, touchHandler);
		}
	}
}