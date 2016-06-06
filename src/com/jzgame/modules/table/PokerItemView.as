package com.jzgame.modules.table
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.vo.CardInfoVO;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.text.TextFormat;
	
	import feathers.controls.Label;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PokerItemView extends Sprite
	{
		/***********
		 * name:    PokerItemView
		 * data:    Nov 20, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Image;
		private var _icon:Image;
		private var _label:Label;
		public var data:CardInfoVO;
		public function PokerItemView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_back = new Image(ResManager.tableAssets.getTexture("zhuozi_bg_poker"));
			addChild(_back);
			
			_label = new Label();
			_label.x = 5;
			_label.y = 5;
			_label.width  = 30;
			_label.height = 30;
			addChild(_label);
		}
		
		/**
		 * 设置牌信息 
		 * @param value
		 * 
		 */		
		public function setData(value:CardInfoVO):void
		{
			data = value;
			switch(value.type)
			{
				case 1:
					_icon = new Image(ResManager.tableAssets.getTexture('zhuozi_icon_pokerhongtao'));
					addChild(_icon);
					break;
				case 2:
					_icon = new Image(ResManager.tableAssets.getTexture('zhuozi_icon_pokerheitao'));
					addChild(_icon);
					break;
				case 3:
					_icon = new Image(ResManager.tableAssets.getTexture('zhuozi_icon_pokerfangkuai'));
					addChild(_icon);
					break;
				case 4:
					_icon = new Image(ResManager.tableAssets.getTexture('zhuozi_icon_pokercaohua'));
					addChild(_icon);
					break;
			}
			
			_icon.y = 30;
			_icon.x = 10;
			
			//字颜色，红色跟黑色
			if((value.type % 2) == 0)
			{
				_label.textRendererProperties.textFormat = new TextFormat(HtmlTransCenter.Arial(),16,0x000000);
			}else
			{
				_label.textRendererProperties.textFormat = new TextFormat(HtmlTransCenter.Arial(),16,0xff0000);
			}
			
			if(value.value == 1)
			{
				_label.text = "A";
			}else if(value.value == 11)
			{
				_label.text = "J";
			}else if(value.value == 12)
			{
				_label.text = "Q";
			}else if(value.value == 13)
			{
				_label.text = "K";
			}
			else
			{
				_label.text = value.value.toString();
			}
		}
	}
}