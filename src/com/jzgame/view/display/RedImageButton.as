package com.jzgame.view.display
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.ResManager;
	import com.spellife.display.ImageButton;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class RedImageButton extends ImageButton
	{
		/*auther     :jim
		* file       :RedImageButton.as
		* date       :May 11, 2015
		* description:紅icon按鈕
		*/
		private var _red:Bitmap = new Bitmap;
		public function RedImageButton(out:BitmapData=null, over:BitmapData=null, down:BitmapData=null, disabled:BitmapData=null)
		{
			super(out, over, down, disabled);
			
			_red.bitmapData = ResManager.getBitmapDataByName("20007_roundBg");
			_red.scaleX = _red.scaleY = .5;
			_red.x = this._view.x+this._view.width-_red.width/2-5;
			_red.y = this._view.y-_red.height/4+3;
			
			showRed();
		}
		
		public function showRed(b:Boolean = false):void
		{
			_red.visible = b;
			if(b)
			{
				addChild(_red);
			}else
			{
				if(_red.parent)
					removeChild(_red);
			}
		}
		
		public function setRedLocation(xx:Number,yy:Number):void
		{
			_red.x = xx;
			_red.y = yy;
		}
		
		override public function dispose():void
		{
			super.dispose();
			DisplayManager.disposeBitmap(_red);
		}
	}
}