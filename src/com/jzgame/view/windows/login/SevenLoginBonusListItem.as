package com.jzgame.view.windows.login
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.SystemColor;
	import com.jzgame.util.ItemStringUtil;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.ColorMatrix;
	import com.spellife.util.HtmlTransCenter;
	import com.spellife.util.TimerManager;
	
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Image;
	
	public class SevenLoginBonusListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    SevenLoginBonusListItem
		 * data:    Jul 23, 2015
		 * author:  jim
		 * des:
		 ***********/
		
		private var _image:Image;
		private var _itemBack:Bitmap = new Bitmap;
		private var _text:SLLabel = new SLLabel;
		private var _reward:Bitmap = new Bitmap();
		public function SevenLoginBonusListItem()
		{
			super();
			
			_defaultWidth  = 90;
			_defaultHeight = 140;
			
			init();
		}
		
		private function init():void
		{
			_itemBack.bitmapData = ResManager.getBitmapDataByName("20018_itemBack");
			_itemBack.x = 6;
			_itemBack.y = 40;
			addChild(_itemBack);
			
			_image = new Image(new Rectangle(43,80,90,0));
			addChild(_image);
			
			_text.color = SystemColor.WHITE;
			_text.size = 12;
			_text.textAlign( TextFormatAlign.CENTER );
			_text.font = HtmlTransCenter.Arial();
			_text.setSize(_defaultWidth,30);
			_text.setLocation(0,120);
			addChild(_text);
			
			_reward.y = -10;
			_reward.x = 5;
			addChild(_reward);
		}
		
		override public function set data(data:Object):void
		{
			super.data = data;
			
			//for(var i:String in data.bonus)
			{
				var id:String = data.bonus[0].split(AssetsCenter.COLON)[0];
				var num:String = data.bonus[0].split(AssetsCenter.COLON)[1];
				_text.text = ItemStringUtil.getItemDes(id,num);
				//				_image.setScaleX(0.5);
				//				_image.setScaleY(0.5);
				_image.url = AssetsCenter.getImagePath(ItemStringUtil.getItemImage(id));
				_image.setToolTip(ItemStringUtil.getItemDesc(id));
			}
			
			var current:String = TimerManager.getSysWeekDay();
			_text.visible = true;
			_itemBack.visible = true;
			
			DisplayManager.disposeBitmap(_reward);
			switch(data.status)
			{
				//					if(data.day > Number(current))
				//					{
				//						
				//					}else
				//					{
				//						ColorMatrix.turnGray(_image);
				//						DisplayManager.disposeBitmap(_reward);
				//					}
				//					break;
				case 0:
				case 1:
					if(data.day >= Number(current))
					{
					}else
					{
						_reward.bitmapData = ResManager.getBitmapDataByName("20018_missIcon");
						_reward.y = -10;
						_reward.x = 5;
						ColorMatrix.turnGray(_image);
					}
					break;
				case 2:
					_text.visible = false;
					_itemBack.visible = false;
					_reward.y = -10;
					_reward.x = 5;
					_reward.bitmapData = ResManager.getBitmapDataByName("20018_getIcon");
					break;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			_image.dispose();
			
			DisplayManager.disposeBitmap(_reward);
			
			DisplayManager.clearItemStage(this);
		}
	}
}