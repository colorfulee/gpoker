package com.jzgame.modules.lobby
{
	import com.jzgame.common.utils.ResManager;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class ToolListItem extends FeathersControl implements IListItemRenderer
	{
		/***********
		 * name:    ToolListItem
		 * data:    Nov 16, 2015
		 * author:  jim
		 * des:
		 ***********/
		protected var _padding:Number = 0;
		protected var _index:int = -1;
		protected var _target:Button;
		protected var _selectBgSkin:Image;
		protected var _data:Object;
		protected var _isSelected:Boolean;
		protected var _owner:List;
		public function ToolListItem()
		{
			super();
		}
		
		override protected function initialize():void
		{
			_target = new Button;
			addChild(_target);
		}
		
		override protected function draw():void
		{
			var dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			
			if(dataInvalid)
			{
				this.commitData();
			}
		}
		
		protected function commitData():void
		{
			switch(index+1)
			{
				case 1:
					_target.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_game1"));
					_target.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_game2"));
					break;
				case 2:
					_target.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_item1"));
					_target.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_item2"));
					break;
				case 3:
					_target.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Activity1"));
					_target.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Activity2"));
					break;
				case 4:
					_target.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_message1"));
					_target.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_message2"));
					break;
				case 5:
					_target.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_friends1"));
					_target.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_friends2"));
					break;
				case 6:
					_target.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Ranking1"));
					_target.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Ranking2"));
					break;
				case 7:
					_target.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_setting1"));
					_target.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_setting2"));
					break;
			}
			
			_target.y = 30 - ( _target.defaultSkin.height) * 0.5;
			_target.addEventListener(Event.TRIGGERED, selected);
		}
		
		private function selected(e:Event):void
		{
			isSelected = true;
		}
		
		public function get padding():Number
		{
			return this._padding;
		}
		
		public function set padding(value:Number):void
		{
			if(this._padding == value)
			{
				return;
			}
			this._padding = value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			if(this._index == value)
			{
				return;
			}
			_index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function get owner():List
		{
			return this._owner;;
		}
		
		public function set owner(value:List):void
		{
			if(this._owner == value)
			{
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function get isSelected():Boolean
		{
			return this._isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			if(this._isSelected == value)
			{
				return;
			}
			
			if(value)
			{
				if(!_selectBgSkin)
				{
					_selectBgSkin = new Image(ResManager.defaultAssets.getTexture("lobby_bg_Halo"));
				}
				_selectBgSkin.y = _target.y + _target.height - 13;
				_selectBgSkin.x = -(_selectBgSkin.width - _target.width ) * 0.5;
				addChildAt(_selectBgSkin,0);
			}else
			{
				if(_selectBgSkin && _selectBgSkin.parent)
				{
					removeChild(_selectBgSkin);
				}
			}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(Event.CHANGE);
		}
		
		override public function dispose():void
		{
			super.dispose();
			_target.dispose();
			if(_selectBgSkin)
			_selectBgSkin.dispose();
			_target.removeEventListener(Event.TRIGGERED, selected);
			_data = null;
			_owner = null;
		}
	}
}