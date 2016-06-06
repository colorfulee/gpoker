package com.jzgame.view.display
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.enmu.SystemColor;
	import com.spellife.display.ImageButton;
	import com.spellife.display.SLLabel;
	import com.spellife.display.SLUIComponent;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	
	public class SLPageList extends SLUIComponent
	{
		/*auther     :jim
		* file       :PageList.as
		* date       :Feb 6, 2015
		* description:页签选择
		*/
		public var left:ImageButton;
		public var right:ImageButton;
		public var label:SLLabel;
		
		public static var PAGE_CHANGE_EVENT:String = 'PAGE_CHANGE_EVENT';
		private var _index:uint = 1;
		private var _max:uint = 1;
		
		public function SLPageList()
		{
			super();
		}

		public function get max():uint
		{
			return _max;
		}
		/**
		 * 设置最大页签 
		 * @param value
		 * 
		 */
		public function set max(value:uint):void
		{
			_max = value == 0? 1:value;
			left.enabled  = true;
			right.enabled = true;
			chechEnable();
			
			setLabel();
		}

		/**
		 * 当前页 
		 * @return 
		 * 
		 */		
		public function get index():uint
		{
			return _index;
		}
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set index(value:uint):void
		{
//			if(_index > value)
//			{
//				processPre();
//			}else if(_index < value)
//			{
//				processNext();
//			}
			
			_index = value;
			
			chechEnable();
			
			setLabel();
		}
		
		public function setLeftButton(button:ImageButton):void
		{
			left = button;
			addChild(left);
			left.addEventListener(MouseEvent.CLICK, preHandler);
		}
		
		public function setRightButton(button:ImageButton):void
		{
			right = button;
			addChild(right);
			right.addEventListener(MouseEvent.CLICK, nextHandler);
		}
		
		public function setLabelView():void
		{
			label = new SLLabel;
			label.font = HtmlTransCenter.Arial();
			label.setSize(70,25);
			label.setLocation(15,0);
			label.textAlign(TextFormatAlign.CENTER);
			label.size = 16;
			label.color = SystemColor.STATE_TEXT;
			addChild(label);
		}
		/**
		 * 设置标签 
		 * 
		 */		
		private function setLabel():void
		{
			if(label)
			label.text = _index + "/" + _max;
		}
		
		private function preHandler(e:MouseEvent):void
		{
			processPre();
		}
		
		private function nextHandler(e:MouseEvent):void
		{
			processNext();
		}
		
		
		private function processPre():void
		{
			if(--_index<=1)
			{
				right.enabled = true;
				left.enabled = false;
				
				_index = 1;
			}
			
			chechEnable();
//			if(--_index<=1)
//			{
//				right.enabled = true;
//			}else
//			{
//				if (_index!=_max) {
//					right.enabled = true;
//				}
//				left.enabled = false;
//			}
			
			setLabel();
			
			dispatchEvent(new Event(PAGE_CHANGE_EVENT));
		}
		/**
		 * 
		 * 
		 */		
		private function chechEnable():void
		{
			if (_index==1) {
				left.enabled = false;
			}else
			{
				left.enabled = true;
			}
			
			if(_index == _max)
			{
				right.enabled = false;
			}else
			{
				right.enabled = true;
			}
		}
		
		private function processNext():void{
			if(++_index>=_max)
			{
//				right.enabled = false;
//				left.enabled = true;
				
				_index  = _max;
			}
			
			chechEnable();
			
			setLabel();
			dispatchEvent(new Event(PAGE_CHANGE_EVENT));
		}
		/**
		 * 销毁 
		 * 
		 */		
		public function dispose():void
		{
			if(left)
			{
				left.removeEventListener(MouseEvent.CLICK, preHandler);
				left.dispose();
			}
			if(right)
			{
				right.removeEventListener(MouseEvent.CLICK, nextHandler);
				right.dispose();
			}
			
			DisplayManager.clearItemStage(this);
		}
	}
}