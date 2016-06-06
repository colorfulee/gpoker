package com.jzgame.view.windows.safeBox
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.NumUtil;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Point;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class SafeBoxSaveView extends Sprite
	{
		/***********
		 * name:    SafeBoxSaveView
		 * data:    Jan 6, 2016
		 * author:  jim
		 * des:
		 ***********/
		protected var _title1:Label;
		protected var _money1:Label;
		protected var _title2:Label;
		protected var _money2:Label;
		protected var _inputBack:Scale9Image;
		protected var _barBack:Image;
		protected var _pin:Button;
		private var _mine:Number;
		private var _tip:SafeBoxPinTipView;
		private var _min:SLLabel;
		private var _max:SLLabel;
		public function SafeBoxSaveView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_inputBack = StyleProvider.commonWhiteRoundBack;
			_inputBack.width  = 813;
			_inputBack.height = 317;
			addChild(_inputBack);
			
			_title1 = new Label();
			_title1.x = 28;
			_title1.y = 22;
			_title1.text = LangManager.getText('402344');
			_title1.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,24);
			addChild(_title1);
			
			_money1 = new Label();
			_money1.x = 28;
			_money1.y = 63;
//			_money1.text = LangManager.getText('402344');
			_money1.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,24);
			addChild(_money1);
			
			_title2 = new Label();
			_title2.x = 626;
			_title2.y = 22;
			_title2.text = LangManager.getText('402343');
			_title2.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,24);
			addChild(_title2);
			
			_money2 = new Label();
			_money2.x = 626;
			_money2.y = 63;
//			_money2.text = LangManager.getText('402344');
			_money2.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,24);
			addChild(_money2);
			
			_barBack = new Image(ResManager.defaultAssets.getTexture('details_bg_scroll1'));
			_barBack.x = 20;
			_barBack.y = 183;
			addChild(_barBack);
			
			_pin = new Button();
			_pin.styleProvider = null;
			_pin.defaultSkin = new Image(ResManager.defaultAssets.getTexture('details_bg_scroll2'));
			_pin.x = 20;
			_pin.y = 160;
			addChild(_pin);
			
			_pin.addEventListener(TouchEvent.TOUCH, touchPin);
			
			_tip = new SafeBoxPinTipView();
			_tip.text = 0;
//			_tip.visible = false;
			addChild(_tip);
			_tip.x = _pin.x + _pin.defaultSkin.width * 0.5;
			_tip.y = _pin.y - _pin.defaultSkin.height;
			
			_min = new SLLabel();
			_min.x = 20;
			_min.y = 231;
			_min.text = LangManager.getText('500252');
			_min.textRendererProperties.textFormat = StyleProvider.getTF(0xab5780,24);
			addChild(_min);
			
			_max = new SLLabel();
			_max.x = 742;
			_max.y = 231;
			_max.text = LangManager.getText('500253');
			_max.textRendererProperties.textFormat = StyleProvider.getTF(0xab5780,24);
			addChild(_max);
		}
		private var _start:Boolean = false;
		//拖动时候点击位置
		private var _startX:Number = 0;
		private function touchPin(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_pin);
			if(touch)
			{
				switch(touch.phase)
				{
					case TouchPhase.BEGAN:
//						_tip.visible = true;
						_start = true;
						var pinPoint:Point = new Point();
						touch.getLocation(_pin,pinPoint);
						_startX = pinPoint.x;
						break;
					case TouchPhase.MOVED:
						if(_start)
						{
							var point:Point = new Point;
							touch.getLocation(this,point);
							
							_pin.x = Math.max(20,point.x - _startX);
							_pin.x = Math.min(785-_pin.width,_pin.x);
							_tip.text = Math.floor(_mine * (_pin.x - 20) / (785-_pin.width - 20)) ;
							_tip.x = _pin.x + _pin.width * 0.5;
						}
						break;
					case TouchPhase.ENDED:
//						_tip.visible = false;
						_start = false;
						_startX = 0;
						break;
				}
			}
		}
		/**
		 * 设置
		 * @param bank
		 * @param mine
		 * 
		 */		
		public function setMoney(bank:Number, mine:Number):void
		{
			_money1.text = NumUtil.n2c(mine);
			_money2.text = NumUtil.n2c(bank);
			
			_mine = mine;
		}
		/**
		 * 获取存入值 
		 * @return 
		 * 
		 */		
		public function getMoney():Number
		{
			return Math.floor(_mine * (_pin.x - 20) / (785-_pin.width - 20));
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			_pin.removeEventListener(TouchEvent.TOUCH, touchPin);
		}
	}
}