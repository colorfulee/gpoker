package com.jzgame.view.display
{
	import com.jzgame.command.HandleSWFLoadEvent;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.events.HandleDynamicSWFLoadCompleteEvent;
	import com.spellife.display.AnimalClip;
	import com.spellife.display.SLLabel;
	import com.spellife.display.SLUIComponent;
	import com.spellife.ui.ToolTipManager;
	import com.spellife.util.ColorMatrix;
	import com.spellife.util.TimerManager;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class MCInterButton extends SLUIComponent
	{
		/*auther     :jim
		* file       :MCInterButton.as
		* date       :Apr 9, 2015
		* description:
		*/
		public var _label:SLLabel;
		private var _source:MovieClip;
		private var _anim:AnimalClip;
		private var _scareSize:Number = 1.1;
		private var _gray:Boolean = true;
		private var _auto:Boolean = false;
		private var _id:String = "";
		public var _nW:uint = 66;
		public var _nH:uint = 66;
		public function MCInterButton()
		{
			super();
		}
		
		public function set gray(value:Boolean):void
		{
			_gray = value;
		}

		public function set scareSize(value:Number):void
		{
			_scareSize = value;
		}
		/**
		 * 设置基准大小 
		 * @param w
		 * @param h
		 * 
		 */		
		public function setBackSize(w:uint,h:uint):void
		{
			_nW = w;
			_nH = h;
		}
		/**
		 * 直接绑定素材 
		 * @param source
		 * 
		 */
		public function bindView(source:MovieClip,auto:Boolean = false):void
		{
			_source = source;
			_source.x = -Math.floor(_nW * 0.5);
			_source.y = -Math.floor(_nH * 0.5);
			addChild(_source);
			_auto = auto;
			mouseChildren = false;
			
			_anim = new AnimalClip(_source,TimerManager.getInstance().animTimer);
			_anim.playRange(1,0);
			if(_gray)
			{
				ColorMatrix.turnGray(_source);
			}
			if(_auto)
			{
				_anim.play(0);
			}else
			{
				this.addEventListener(MouseEvent.ROLL_OVER, over);
				this.addEventListener(MouseEvent.ROLL_OUT, out);
				this.addEventListener(MouseEvent.MOUSE_DOWN, down);
				this.addEventListener(MouseEvent.MOUSE_UP, up);
			}
			
			this.buttonMode = true;
		}
		/**
		 * 设置提示 
		 * @param value
		 * 
		 */		
		public function setToolTip(value:Object):void
		{
			ToolTipManager.removeToolTip(this);
			if(value)
			ToolTipManager.registeToolTip(this,value);
		}
		/**
		 * 清空显示 
		 * 
		 */
		private function clearView():void
		{
			if(_source)
			{
				_anim.reset();
				
				_source.parent.removeChild(_source);
				ColorMatrix.turnNormal(_source);
				this.removeEventListener(MouseEvent.ROLL_OVER, over);
				this.removeEventListener(MouseEvent.ROLL_OUT, out);
				this.removeEventListener(MouseEvent.MOUSE_DOWN, down);
				this.removeEventListener(MouseEvent.MOUSE_UP, up);
				
				_source = null;
			}
		}
		
		/**
		 * 动态绑定素材 
		 * @param id
		 * 
		 */		
		public function bindId(id:String,auto:Boolean = false):void
		{
			clear();
			
			_id = id;
			
			_auto = auto;
			
			AssetsCenter.eventDispatcher.addEventListener(HandleDynamicSWFLoadCompleteEvent.COMPLETE,updateView);
			AssetsCenter.eventDispatcher.dispatchEvent(new HandleSWFLoadEvent(_id,AssetsCenter.getGiftPath(_id)));
		}
		
		private function updateView(e:HandleDynamicSWFLoadCompleteEvent):void
		{
			if(_id == e.id)
			{
				AssetsCenter.eventDispatcher.removeEventListener(HandleDynamicSWFLoadCompleteEvent.COMPLETE,updateView);
				bindView(ResManager.getMCByOraignName(_id),_auto)
			}
		}
		
		private function over(e:MouseEvent):void
		{
			ColorMatrix.turnNormal(_source);
			_source.scaleX = _source.scaleY = _scareSize;
			_source.x = -Math.floor(_nW *_scareSize* 0.5);
			_source.y = -Math.floor(_nH * _scareSize *0.5);
			_anim.play(0);
		}
		
		private function out(e:MouseEvent):void
		{
//			_source.x = _source.y = 0;
			_source.scaleX = _source.scaleY = 1;
			_source.x = -Math.floor(_nW * 0.5);
			_source.y = -Math.floor(_nH * 0.5);
			if(_gray)
			{
				ColorMatrix.turnGray(_source);
			}
			_anim.reset();
			_anim.resetFrame();
		}
		
		private function down(e:MouseEvent):void
		{
		}
		
		private function up(e:MouseEvent):void
		{
//			_anim.reset();
		}
		/**
		 * 清空缓存，方便下次继续使用 
		 * 
		 */		
		public function clear():void
		{
			if(_label)
			{
				this.removeChild(_label);
			}
			setToolTip(null);
			clearView();
			AssetsCenter.eventDispatcher.removeEventListener(HandleDynamicSWFLoadCompleteEvent.COMPLETE,updateView);
		}
		/**
		 * 销毁 
		 * 
		 */		
		public function dispose():void
		{
			if(_label)
			{
				this.removeChild(_label);
			}
			setToolTip(null);
			clearView();
			AssetsCenter.eventDispatcher.removeEventListener(HandleDynamicSWFLoadCompleteEvent.COMPLETE,updateView);
		}
	}
}