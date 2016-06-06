package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.view.display.FaceWithFrame;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Shape;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ChatAtListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    ChatAtListItem
		 * data:    Jan 13, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _face:FaceWithFrame;
		private var _name:SLLabel;
		private var _shape:Shape;
		public function ChatAtListItem()
		{
			super();
			
			_face = new FaceWithFrame();
			_face.x = 10;
			_face.y = 10;
			_face.scaleX = _face.scaleY = .7;
			addChild(_face);
			
			_shape = new Shape;
			_shape.graphics.beginFill(0x34273c);
			_shape.graphics.drawRect(0,0,480,1);
			_shape.graphics.endFill();
			
			_shape.y = 100;
			addChild(_shape);
			
			_name = new SLLabel();
			_name.setSize(300,30);
			_name.textRendererProperties.textFormat = StyleProvider.getTF(0xb3a7db,20);
			_name.setLocation(90,35);
			addChild(_name);
			
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!value)return;
			
			_face.setData(value.fbId);
			_name.text = value.name;
		}
		
		private function touchHandler(e:TouchEvent):void
		{
			if(e.getTouch(this,TouchPhase.ENDED))
			{
				SignalCenter.onChatAtTriggered.dispatch(data.name);
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			this.removeEventListener(TouchEvent.TOUCH, touchHandler);
		}
	}
}