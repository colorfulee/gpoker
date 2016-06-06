package com.jzgame.modules.operate
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.EventType;
	import com.starling.theme.StyleProvider;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class PreOpeButton extends Button
	{
		/***********
		 * name:    PreOpeButton
		 * data:    Nov 19, 2015
		 * author:  jim
		 * des:
		 ***********/
		protected var _checkBox:Check;
		//check box 的黑背景
		protected var _back:Image;
		public function PreOpeButton()
		{
			super();
			
			styleNameList.add(StyleProvider.CUSTOM_BUTTON_IN_PRE_OPERATE);
			
			_back = new Image(ResManager.tableAssets.getTexture("table_bg_checkbox"));
			_back.x = 16;
			_back.y = 16;
			addChild(_back);
			_checkBox = new Check();
			_checkBox.styleProvider = null;
			_checkBox.x = 10;
			_checkBox.y = 10;
			addChild(_checkBox);
			_checkBox.defaultSkin = new Quad(28,28,0xffffff);
			_checkBox.defaultSkin.alpha = 0;
			_checkBox.defaultSelectedIcon = new Image(ResManager.tableAssets.getTexture("table_icon_choose"));
			_checkBox.isSelected = false;
			_checkBox.touchable = false;
			
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		private function touchHandler(e:TouchEvent):void
		{
			if(e.getTouch(this,TouchPhase.ENDED))
			{
				_checkBox.isSelected = !_checkBox.isSelected;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		/**
		 * 是否选中 
		 * @return 
		 * 
		 */		
		public function isSelected():Boolean
		{
			return _checkBox.isSelected;
		}
		
		//取消选择
		public function nonSelect():void
		{
			_checkBox.isSelected = false;
			dispatchEvent(new Event(EventType.UN_SELECTED));
		}
		
		override public function dispose():void
		{
			super.dispose();
			this.removeEventListener(TouchEvent.TOUCH, touchHandler);
		}
	}
}