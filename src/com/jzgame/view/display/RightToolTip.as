package com.jzgame.view.display
{
	import com.jzgame.common.utils.DisplayManager;
	
	import flash.geom.Rectangle;

	public class RightToolTip extends DefaultToolTip
	{
		/*auther     :jim
		* file       :RightToolTip.as
		* date       :Apr 30, 2015
		* description: 排行榜等提示,箭头右边
		*/
		public function RightToolTip(tip:String)
		{
			super(tip);
		}
		
		override public function setRect(rect:Rectangle):void
		{
			_arrow.rotation = 90;
			_arrow.x = _back.width - 4;
			DisplayManager.centerY(_arrow,_back);

			this.x = Math.floor(rect.x - this.width);
			this.y = Math.floor(rect.y + ((rect.height - _back.height) * 0.5));
			
			if(this.x < 0)
			{
				_arrow.x += this.x - Math.floor(_arrow.width * 0.5);
				this.x = 0;
			}
		}
	}
}