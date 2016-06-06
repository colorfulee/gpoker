package com.spellife.feathers
{
	import feathers.controls.Label;
	
	public class SLLabel extends Label
	{
		/***********
		 * name:    SLLabel
		 * data:    Nov 16, 2015
		 * author:  jim
		 * des:
		 ***********/
		public function SLLabel()
		{
			super();
		}
		
		public function setLocation(_x:Number,_y:Number):void
		{
			this.x = _x;
			this.y = _y;
		}
	}
}