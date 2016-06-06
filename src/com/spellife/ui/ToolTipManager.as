package com.spellife.ui
{
	import com.jzgame.i.IToolTip;
	import com.jzgame.view.display.DefaultToolTip;
	import com.jzgame.view.display.SLUIComponent;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class ToolTipManager
	{
		/*auther     :jim
		* file       :ToolTipManager.as
		* date       :Apr 28, 2015
		* description:提醒管理
		*/
		private static var _dic:Dictionary = new Dictionary;
		//tip容器
		private static var _stage:Sprite;
		public function ToolTipManager()
		{
		}
		/**
		 * 初始容器 
		 * @param stage
		 * 
		 */		
		public static function init(stage:Sprite):void
		{
			_stage = stage;
			
			_stage.touchable = false;
		}
		/**
		 * 注册提醒 
		 * @param view
		 * @param value
		 * 
		 */		
		public static function registeToolTip(view:Sprite,value:Object):void
		{
			if(!value)
			{
				removeToolTip(view);
				return;
			}
			var result:Sprite;  
			if(value is Sprite){  
				// control show or hide  
				result = value as Sprite;  
			}else{  
				value = value.toString();  
				// default toolTip dspObj show or hide  
				result = new DefaultToolTip(value as String);  
			}
			_dic[view] = result;
			
			view.addEventListener(TouchEvent.TOUCH, touchEvent);
		}
		
		private static function touchEvent(e:TouchEvent):void
		{
			var num:uint = _stage.numChildren;
			var view:Sprite;
			for(var i:Sprite in _dic)
			{
				view = i;
				
				var touch:Touch = e.getTouch(view);
				if(touch)
				{
					switch (touch.phase)
					{
						case TouchPhase.BEGAN:
							overTip(view);
							break;
						case TouchPhase.ENDED:
							outTip(view);
							break;
					}
				}
			}
		}
		/**
		 * 移上 
		 * @param e
		 * 
		 */		
		private static function overTip(target:Sprite):void
		{
			var rect:Rectangle = target.getBounds(target.stage);
			showTip(_dic[target],rect);
		}
		/**
		 * 移出 
		 * @param e
		 * 
		 */		
		private static function outTip(target:Sprite):void
		{
			hideTip(_dic[target]);
		}
		
		private static function hideTip(tip:Sprite):void{
			if(tip && tip.parent)
			{
				tip.parent.removeChild(tip);
			}
		}
		private static function showTip(tip:IToolTip,rect:Rectangle):void{
			_stage.addChild(tip as SLUIComponent);
			tip.setRect(rect);
		}
		
		public static function removeToolTip(view:Sprite):void
		{
			view.removeEventListener(MouseEvent.ROLL_OVER, overTip);
			view.removeEventListener(MouseEvent.ROLL_OUT, outTip);
//			view.removeEventListener(Event.REMOVED_FROM_STAGE,outTip);
			hideTip(_dic[view]);
			delete _dic[view];
		}
	}
}