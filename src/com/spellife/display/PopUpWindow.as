package com.spellife.display
{
	import com.jzgame.effects.DefaultPopUpWindowEffect;
	import com.jzgame.enmu.ReleaseUtil;
	import com.spellife.interfaces.display.IPopUpWindow;
	import com.spellife.interfaces.effect.ITweenEffect;
	import com.spellife.ui.UIBaseView;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	
	public class PopUpWindow extends UIBaseView implements IPopUpWindow
	{
		protected var _isModal:Boolean = true;
		protected var _isSole:Boolean  = true;
		protected var _isDrag:Boolean  = false;
		protected var _isEnable:Boolean  = true;
		protected var _isStageTouchEnable:Boolean  = true;
		//模态化的时候是否显示背景
		protected var _modalVisible:Boolean = false;
		
		protected var _motionEffect:ITweenEffect;
		
		protected var _isShown:Boolean = false;
		//是否在动画
		protected var _isMoving:Boolean = false;
		
		private var _closeList:Array = [];
		
		public function PopUpWindow()
		{
			super();
			_motionEffect = new DefaultPopUpWindowEffect;
			this.addEventListener(Event.ADDED_TO_STAGE, addListener);
		}

		public function get isStageTouchEnable():Boolean
		{
			return _isStageTouchEnable;
		}

		public function set isStageTouchEnable(value:Boolean):void
		{
			_isStageTouchEnable = value;
		}

		public function get isMoving():Boolean
		{
			return _isMoving;
		}

		public function set isMoving(value:Boolean):void
		{
			_isMoving = value;
		}

		public function get motionEffect():ITweenEffect
		{
			return _motionEffect;
		}

		public function show(...rests):void
		{
			_isShown = true;
			//根据分辨率 来适配弹窗，防止超过屏幕
			var ssx:Number = ReleaseUtil.STAGE_WIDTH / this.width;
			var ssy:Number = ReleaseUtil.STAGE_HEIGHT / this.height;
			//取最小缩放,这个防止超过屏幕
			var s:Number = Math.min(ssx,ssy);
			if(s<1)
			{
				this.scale = s;
			}
			
			initShow();
 		}
		
		private function addListener(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addListener);
			this.addEventListener(Event.ENTER_FRAME, comeOn);
		}
		
		private function comeOn(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME, comeOn);
			if(this.stage)
			this.stage.addEventListener(TouchEvent.TOUCH, touchStageEvent);
		}
		/**
		 * 显示回调 
		 * 
		 */		
		protected function initShow():void
		{
			
		}
		/**
		 * 关闭回调 
		 * 
		 */		
		protected function initHide():void
		{
			
		}
		/**
		 * 关闭 
		 * 
		 */		
		public function hide():void
		{
			clearListener();
			_isShown = false;
//			clearView();
			
			initHide();
		}

		public function get isShown():Boolean
		{
			return _isShown;
		}
		
		public function get isModal():Boolean
		{
			return _isModal;
		}
		
		public function get isSole():Boolean
		{
			return _isSole;
		}
		
		public function get isModalVisible():Boolean
		{
			return _modalVisible;
		}
		
		public function get isDrag():Boolean
		{
			return _isDrag;
		}
		
		public function get isEnable():Boolean
		{
			return _isEnable;
		}
		
		protected function setClose(target:DisplayObject):void
		{
			_closeList.push(target);
			target.addEventListener(TouchEvent.TOUCH, closeHandler);
		}
		/**
		 * 清空监听 
		 * 
		 */		
		private function clearListener():void
		{
			var target:DisplayObject;
			for(var i:String in _closeList)
			{
				target = _closeList[i];
				target.removeEventListener(TouchEvent.TOUCH, closeHandler);
			}
			
			_closeList = [];
			this.stage.removeEventListener(TouchEvent.TOUCH, touchStageEvent);
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function touchStageEvent(e:TouchEvent):void
		{
			if(e.getTouch(this))
			{
				
			}else
			{
				if(e.getTouch(this.stage,TouchPhase.ENDED) && isStageTouchEnable)
				{
					var rect:Rectangle = new Rectangle;
					this.getBounds(this.stage,rect);
					var point:Point = new Point(e.getTouch(this.stage).globalX,e.getTouch(this.stage).globalY);
					trace("touch event:",this,rect,point);
					if(!rect.containsPoint(point))
					{
						closeWindow();
					}
				}
			}
		}
		
		public function closeWindow():void
		{
			if(this.motionEffect)
			{
				_isMoving = true;
				this.motionEffect.out(this);
			}else
			{
				PopUpWindowManager.removePopUpWindow(this);
			}
		}
		
		protected function closeHandler(e:TouchEvent):void
		{
			var touch:Touch;
			for(var i:String in _closeList)
			{
				touch = e.getTouch(_closeList[i],TouchPhase.ENDED);
				
				if(touch)break;
			}
			if(touch)
			{
				trace("touch!",_closeList[i],this.name);
				//关闭音效
				closeWindow();
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
	}
}