package com.jzgame.view.display
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.SystemColor;
	import com.spellife.display.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextFormatAlign;
	
	public class PrizeItem extends Sprite
	{
		/*auther     :jim
		* file       :PrizeItem.as
		* date       :May 22, 2015
		* description:奖励物品表现
		*/
		private var _back:Bitmap = new Bitmap;
		private var _icon:Bitmap = new Bitmap;
		private var _des:SLLabel = new SLLabel;
		public function PrizeItem()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_back.bitmapData = ResManager.getBitmapDataByName("20000_blingBack");
			addChild(_back);
			
			_icon.bitmapData = ResManager.getBitmapDataByName("20000_bigChipIcon");
			addChild(_icon);
			DisplayManager.center(_icon,_back);
			
			_des.setSize(100,30);
			_des.setLocation(-10,80);
			_des.color = SystemColor.WHITE;
			_des.font = HtmlTransCenter.Arial();
			_des.textAlign(TextFormatAlign.CENTER);
			addChild(_des);
		}
		
		public function setDes(value:String):void
		{
			_des.text = value;
		}
		/**
		 * 销毁 
		 * 
		 */		
		public function dispose():void
		{
			DisplayManager.disposeBitmaps(_back,_icon);
			DisplayManager.clearItemStage(this);
		}
	}
}