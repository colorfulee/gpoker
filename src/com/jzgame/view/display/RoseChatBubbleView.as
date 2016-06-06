package com.jzgame.view.display
{
	import com.jzgame.common.utils.ResManager;
	import com.spellife.display.Scale9BitmapData;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class RoseChatBubbleView extends ChatBubbleView
	{
		/*auther     :jim
		* file       :RoseChatBubbleView.as
		* date       :Apr 16, 2015
		* description:荷官聊天气泡
		*/
		public function RoseChatBubbleView()
		{
			super();
		}
		
		override protected function initBack():void
		{
			var rect:Rectangle = new Rectangle(65,20,1,1);
			var bd:BitmapData = ResManager.getBitmapDataByName("20000_roseChatBg");
			_back.scale9Bmd = new Scale9BitmapData(bd,rect);
			_back.width = 166;
			addChild(_back);
		}
		
		override public function set text(value:String):void
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
			
//			_back.width = _label.textWidth + 30;
			_back.height = _label.textHeight + 30;
			
			_label.y = 15;
			_label.height = _label.textHeight + 8;
			_back.height = _label.height + 32;
		}
	}
}