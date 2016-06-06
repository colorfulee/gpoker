package com.jzgame.modules.operate
{
	import com.jzgame.common.utils.ResManager;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.Slider;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class RaiseSlider extends Sprite
	{
		/***********
		 * name:    RaiseSlider
		 * data:    Dec 11, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _slider:Slider;
		private var _back:Image;
		private var _up:Image;
		private var _allIn:Button;
		private var _num:SLLabel;
		private var _max:Number = 0;
		private var _per:Number = 1;
		//最小的数值
		private var _min:Number = 0;
		
		public function RaiseSlider()
		{
			super();
			
			init();
		}
		private var _temp:Sprite;

		public function get num():Number
		{
			return Number(_num.text);
		}

		private function init():void
		{
			_back = new Image((ResManager.tableAssets.getTexture('table_bg_lever')));
			addChild(_back);
			_back.addEventListener(TouchEvent.TOUCH, setPos);
			
			_temp = new Sprite;
			_temp.touchable = false;
			_temp.clipRect = new Rectangle(0,0,300,300);
			addChild(_temp);
			_up = new Image((ResManager.tableAssets.getTexture('table_btn_lever')));
			_up.x = 10;
			_up.y = 65;
			_temp.addChild(_up);
			
			_allIn = new Button();
			_allIn.styleProvider = null;
			_allIn.defaultSkin = new Image(ResManager.tableAssets.getTexture('table_btn_allin1'));
			_allIn.downSkin = new Image(ResManager.tableAssets.getTexture('table_btn_allin2'));
			_allIn.defaultIcon = new Image(ResManager.tableAssets.getTexture('table_txt_allin1'));
			_allIn.downIcon = new Image(ResManager.tableAssets.getTexture('table_txt_allin2'));
			_allIn.x = 378;
			_allIn.y = 12;
			addChild(_allIn);
			
			_num = new SLLabel();
			_num.textRendererProperties.textFormat = StyleProvider.getTF(0x44ffa1,18);
			_num.text = "0";
			_num.x = 275;
			_num.y = 60;
			_num.rotation = Math.PI * -11 / 180;
			addChild(_num);
		}
	
		/**
		 * 
		 * @param from
		 * @param to
		 * 
		 */		
		public function setRange(from:Number,to:Number):void
		{
			_max = to;
			
			_min = from;
		}
		
		/**
		 * 设置进度条进度 
		 * @param v
		 * 
		 */		
		public function set value(v:Number):void
		{
			_per = v;
			update();
		}
		
		private function setPos(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_back); 
			var point:Point;
			if(touch)
			{
				switch(touch.phase)
				{
					case TouchPhase.ENDED:
						point = touch.getLocation(_back)
						_per = (point.x / _back.width);
						_per<0 ? _per = 0:null;
						_per>1 ? _per = 1:null;
						update();
						break;
					case TouchPhase.MOVED:
						point = touch.getLocation(_back)
						_per = (point.x / _back.width);
						_per<0 ? _per = 0:null;
						_per>1 ? _per = 1:null;
						update();
						break;
				}
			}
		}
		
		private function update():void
		{
			_temp.clipRect = new Rectangle(0,0,_up.width * _per,300);
			_num.text = (_min + Math.floor(_max * _per)).toString();
		}
		
		public function setNum(v:Number):void
		{
			_num.text = v.toString();
		}
	}
}