package com.jzgame.view.display
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.SystemColor;
	import com.spellife.display.SLLabel;
	import com.spellife.display.Scale9Bitmap;
	import com.spellife.display.Scale9BitmapData;
	import com.spellife.util.HtmlTransCenter;
	import com.spellife.util.RealGameTimer;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	
	public class ChatBubbleView extends Sprite
	{
		/*auther     :jim
		* file       :ChatBubbleView.as
		* date       :Mar 13, 2015
		* description:
		*/
		protected var _back:Scale9Bitmap = new Scale9Bitmap;
		protected var _label:SLLabel = new SLLabel;
		protected var _timer:RealGameTimer;
		public function ChatBubbleView()
		{
			super();
			
			init();
		}
		
		protected function initBack():void
		{
			var rect:Rectangle = new Rectangle(53,40,1,1);
			var bd:BitmapData = ResManager.getBitmapDataByName("20000_userChatBg");
			_back.scale9Bmd = new Scale9BitmapData(bd,rect);
			addChild(_back);
		}
		
		private function init():void
		{
			initBack();
			
			_label.font = HtmlTransCenter.Arial();
			_label.multiline = true;
			_label.wordWrap = true;
			_label.color = SystemColor.WHITE;
			_label.size = 12;
			_label.setSize(146,66);
			_label.maxCharater = 60;
			_label.x = 10;
			_label.y = 20;
			addChild(_label);
			
			_timer = new RealGameTimer(3000);
			_timer.addEventListener(TimerEvent.TIMER, hideBubble);
		}
		
		public function set text(value:String):void
		{
			if(this.visible == false)
			{
				_timer.start();
				this.visible = true;
			}else
			{
				_timer.stop();
				_timer.start();
			}
			
			_label.text = value;
			
			_back.width = _label.textWidth + 30;
			_back.height = _label.textHeight + 30;
			
			this.x = 65 - _back.width;
			this.y = _back.height - 5;
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
		
		public function dispose():void
		{
			_timer.removeEventListener(TimerEvent.TIMER, hideBubble);
		}
	}
}