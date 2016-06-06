package com.jzgame.view.display
{
	import starling.display.Sprite;

	public class SLUIComponent extends Sprite
	{
		/*auther     :jim
		* file       :SLUIComponent.as
		* date       :Apr 17, 2015
		* description:
		*/
		public function SLUIComponent()
		{
			super();
		}
		/**
		 * 
		 * @param x_
		 * @param y_
		 * 
		 */		
		public function setLocation(x_:Number,y_:Number):void
		{
			this.x = x_;
			this.y = y_;
		}
	}
}