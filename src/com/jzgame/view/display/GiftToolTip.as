package com.jzgame.view.display
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.SystemColor;
	import com.jzgame.i.IToolTip;
	import com.spellife.display.SLLabel;
	import com.spellife.display.SLUIComponent;
	import com.spellife.display.Scale9Bitmap;
	import com.spellife.display.Scale9BitmapData;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class GiftToolTip extends SLUIComponent implements IToolTip
	{
		/*auther     :jim
		* file       :DefaultToolTip.as
		* date       :Apr 30, 2015
		* description:提示基础类
		*/
		protected var _tip:String;
		protected var _name:SLLabel = new SLLabel;
		protected var _label:SLLabel = new SLLabel;
		protected var _back:Scale9Bitmap = new Scale9Bitmap;
//		protected var _arrow:Bitmap = new Bitmap;
		
		public function GiftToolTip(giftName:String,tip:String)
		{
			super();
			
			_tip = tip;
			var rect:Rectangle = new Rectangle(12,12,2,2);
			var scaleBack:Scale9BitmapData = new Scale9BitmapData(ResManager.getBitmapDataByName("20000_tipsBack"),rect);
			_back = new Scale9Bitmap(scaleBack);
			addChild(_back);
			
			_name.setLocation(5,5);
			_name.font = HtmlTransCenter.Arial();
			_name.color = SystemColor.TITLE_TEXT;
			_name.size = 14;
			_name.setLocation(5,5);
			_name.autoTextSzie= true;
			addChild(_name);
			_name.text = giftName;
			
			_label.autoTextSzie = true;
//			_label.multiline = true;
//			_label.wordWrap  = true;
			_label.setLocation(5,30);
			_label.font = HtmlTransCenter.Arial();
			_label.color = SystemColor.STATE_TEXT;
			_label.size = 14;
			addChild(_label);
			_label.text = _tip;
			
			_back.width  = this.width + 10;
			_back.height = this.height + 10;
//			_arrow.bitmapData = ResManager.getBitmapDataByName("20000_tipArrow");
//			_arrow.x = Math.floor((_back.width - _arrow.width) * .5);
//			_arrow.y = 2;
//			_arrow.scaleY = -1;
//			addChild(_arrow);
		}
		
		/**
		 * 以为标准 
		 * @param rect
		 * 
		 */		
		public function setRect(rect:Rectangle):void
		{
			this.x = Math.floor(rect.x + (rect.width * 0.5) );
			this.y = Math.floor(rect.y + rect.height );
//			this.x = 100;
//			this.y = 100;
			if(this.x < 0)
			{
//				_arrow.x += this.x - Math.floor(_arrow.width * 0.5);
				this.x = 0;
			}
		}
		/**
		 * 以点为标准 
		 * @param p
		 * 
		 */		
		public function setPoint(p:Point):void
		{
//			this.x = p.x - _arrow.x;
//			this.y = p.y - _arrow.y;
		}
		
		public function move(p:Point):void
		{
			setPoint(p);
		}
	}
}