package com.jzgame.modules.lobby
{
	import com.jzgame.common.utils.ResManager;
	
	import feathers.controls.Button;
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class GamelListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    ToolListItem
		 * data:    Nov 16, 2015
		 * author:  jim
		 * des:
		 ***********/
		protected var _padding:Number = 0;
		protected var _target:Button;
		protected var _desDownSkin:Image;
		protected var _desNormalSkin:Image;
		protected var _desIconSkin:Image;
		protected var _icon:Image;
		public function GamelListItem()
		{
			super();
		}
		
		override protected function initialize():void
		{
			styleProvider = null;
			hasLabelTextRenderer = false;
			
			_target = new Button;
			_target.addEventListener(Event.TRIGGERED,someEventHandler);
			addChild(_target);
			_target.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Function2"));
			_target.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Function1"));
			
			this.addEventListener(TouchEvent.TOUCH, touchMeHandler);
		}
		
		override public function set index(value:int):void
		{
			super.index = value;
			//初始化的时候第一位会重复进来两次
			switch(index+1)
			{
				case 1:
					if(!_desDownSkin)
					_desDownSkin = new Image(ResManager.defaultAssets.getTexture("lobby_txt_playnow2"));
					addChild(_desDownSkin);
					if(!_desNormalSkin)
					_desNormalSkin = new Image(ResManager.defaultAssets.getTexture("lobby_txt_playnow1"));
					addChild(_desNormalSkin);
					_target.defaultIcon = new Image(ResManager.defaultAssets.getTexture("lobby_txt_play1"));
					_target.downIcon = new Image(ResManager.defaultAssets.getTexture("lobby_txt_play2"));
					if(!_icon)
					_icon = new Image(ResManager.defaultAssets.getTexture('lobby_icon_playnow'));
					break;
				case 2:
					_desDownSkin = new Image(ResManager.defaultAssets.getTexture("lobby_txt_ringgame2"));
					addChild(_desDownSkin);
					_desNormalSkin = new Image(ResManager.defaultAssets.getTexture("lobby_txt_ringgame1"));
					addChild(_desNormalSkin);
					_target.defaultIcon = new Image(ResManager.defaultAssets.getTexture("lobby_txt_Routine1"));
					_target.downIcon = new Image(ResManager.defaultAssets.getTexture("lobby_txt_Routine2"));
					_icon = new Image(ResManager.defaultAssets.getTexture('lobby_icon_ringgame'));
					break;
				case 3:
					_desDownSkin = new Image(ResManager.defaultAssets.getTexture("lobby_txt_tournament2"));
					addChild(_desDownSkin);
					_desNormalSkin = new Image(ResManager.defaultAssets.getTexture("lobby_txt_tournament1"));
					addChild(_desNormalSkin);
					_target.defaultIcon = new Image(ResManager.defaultAssets.getTexture("lobby_txt_MTT1"));
					_target.downIcon = new Image(ResManager.defaultAssets.getTexture("lobby_txt_MTT2"));
					_icon = new Image(ResManager.defaultAssets.getTexture('lobby_icon_mtt'));
					break;
			}
			_icon.x = 40;
			_icon.y = 32;
			_icon.alpha = .29
			addChild(_icon);
			_desDownSkin.visible = false;
			_desDownSkin.x = 373 - _desDownSkin.width - 23;
			_desDownSkin.y = 56;
			_desNormalSkin.visible = true;
			_desNormalSkin.y = 56;
			_desNormalSkin.x = 373 - _desNormalSkin.width - 23;
			_target.iconOffsetX = 50 + 85;
			_target.iconOffsetY = -16;
		}
		
		private function someEventHandler( event:Event ):void
		{
			this.dispatchEventWith( Event.TRIGGERED );
		}
		
		private function touchMeHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			var touches:Vector.<Touch> = e.getTouches(this);
			if(touch)
			{
				switch(touch.phase)
				{
					case TouchPhase.BEGAN:
						_desDownSkin.visible = true;
						_desNormalSkin.visible = false;
						_icon.alpha = .6;
						break;
					case TouchPhase.ENDED:
						_desDownSkin.visible = false;
						_desNormalSkin.visible = true;
						_icon.alpha = .29;
						break;
					case TouchPhase.MOVED:
						if(this._target.getBounds(this).containsPoint(touch.getLocation(this)))
						{
						}else
						{
							_desDownSkin.visible = false;
							_desNormalSkin.visible = true;
						}
						break;
				}
			}else
			{
				_desDownSkin.visible = false;
				_desNormalSkin.visible = true;
			}
			
//			var touch2:Touch = e.getTouch(this._target);
//			if(!touch2)
//			{
//				trace("xxxxxxxx");
//			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			_target.dispose();
			_data = null;
			_owner = null;
		}
	}
}