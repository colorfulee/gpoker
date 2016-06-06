package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.ResManager;
	import com.spellife.util.HtmlTransCenter;
	import com.spellife.util.RealGameTimer;
	
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	public class ChatBubbleView extends Sprite
	{
		/***********
		 * name:    ChatBubbleView
		 * data:    Jan 12, 2016
		 * author:  jim
		 * des:
		 ***********/
		protected var _back:Scale9Image;
		protected var _text:TextField;
		protected var _arrow:Image;
		protected var _timer:RealGameTimer;
		public function ChatBubbleView()
		{
			super();
			
			var rect:Rectangle = new Rectangle(30,18,2,2);
			var scaleBack:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_table_bg_tips1"),rect);
			_back = new Scale9Image(scaleBack);
			addChild(_back);
			
			_arrow = new Image(ResManager.defaultAssets.getTexture("table_bg_tips2"));
			_arrow.y = 5;
			addChild(_arrow);
			
			_text = new TextField(100,100,'test',HtmlTransCenter.Arial(),18,0xffffff);
			_text.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_text.isHtmlText = true;
			
			_timer = new RealGameTimer(3000);
			_timer.addEventListener(TimerEvent.TIMER, hideBubble);
		}
		
		public function set text(v:String):void
		{
			_text.text = v;
			_text.x = 8;
			_text.x = - Math.floor(_text.width * .5);
			addChild(_text);
			
			_back.width  = _text.width + 50;
			_back.height = _text.height + 15;
			_back.x = - Math.floor(_back.width * 0.5);
//			_back.y = _arrow.height;
			_text.y = 8;
			_arrow.x = -Math.floor(_arrow.texture.width * 0.5);
			_arrow.y = _back.height-6;
			
			if(this.visible == false)
			{
				_timer.start();
				this.visible = true;
			}else
			{
				_timer.stop();
				_timer.start();
			}
		}
		
		/**
		 * 隐藏 
		 * @param e
		 * 
		 */		
		private function hideBubble(e:TimerEvent):void
		{
			_timer.stop();
			
			this.visible = false;
		}
		
		override public function dispose():void
		{
			super.dispose();
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, hideBubble);
		}
	}
}