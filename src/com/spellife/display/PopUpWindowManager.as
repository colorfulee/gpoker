package com.spellife.display
{
	import com.jzgame.enmu.ReleaseUtil;
	import com.spellife.interfaces.display.IPopUpWindow;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;

	/**
	 * a global window manager class which manage every pop up window shown and hide
	 * 2011.6.15 
	 * @author apple
	 * 
	 */
	public class PopUpWindowManager extends EventDispatcher
	{
		//默认容器
		public static var container:DisplayObjectContainer;
//		窗口列表
		private static var _windowList:Dictionary   = new Dictionary;
//		自动弹窗序列
		private static var _sequenceData:Array          = [];
		/**
		 * add a normal pop up window to stage 
		 * @param win ,the instance of the pop up window
		 * @param parent, the parent for the window
		 * @param rests,the arguments for the window
		 * 
		 */		
		public static function addPopUpWindow(win:PopUpWindow,parent:DisplayObjectContainer = null,...rests):IPopUpWindow
		{
			if(parent == null)parent = container;
			var otherWin:WindowWithModal;
			for(var i:String in _windowList)
			{
				otherWin = 	_windowList[i] as WindowWithModal;
				if(otherWin.window.isSole)
				{
					removePopUpWindow(otherWin.window);
				}
			}
			//如果存在实例
			if(_windowList[DisplayObject(win).name])
			{
				parent.addChild(_windowList[DisplayObject(win).name]);
			}else
			{
				var winUnit:WindowWithModal = new WindowWithModal(win,parent.stage.stageWidth,parent.stage.stageHeight);
				if(!win.isEnable)
				{
					winUnit.touchable = false;
				}
				parent.addChild(winUnit);
//				//一定要加载一次，才会激发mediator的事件
//				winUnit.addChild(winUnit.window);
				_windowList[DisplayObject(win).name] = winUnit;
			}
			win.show.apply(win,rests);
			
			if(win.motionEffect) 
			{
				win.motionEffect.go(win as DisplayObject,rests);
			}
			return win;
		}
		/**
		 * 显示组件居中显示 
		 * @param win
		 * 因为窗体的中心点都在中心
		 */		
		public static function centerPopUpWindow(win:DisplayObject):void
		{
			win.x = int((ReleaseUtil.STAGE_WIDTH) * 0.5);
			win.y = int((ReleaseUtil.STAGE_HEIGHT) * 0.5);
		}
		
		/**
		 * 根据窗口名字查找窗体
		 * 需要在窗体外部关闭窗体的
		 * 需要复写窗体实例的name方法
		 * @param windowName
		 * @return 
		 * 
		 */		
		public static function getWindow(windowName:String):IPopUpWindow
		{
			if(_windowList[windowName])
			{
				return WindowWithModal(_windowList[windowName]).window;
			}
			return null;
		}
		/**
		 * remove a normal pop up window from the stage 
		 * @param win
		 * 
		 */		
		public static function removePopUpWindow(win:PopUpWindow):void
		{
			trace("removePopUpWindow:",win.name);
			var otherWin:WindowWithModal = _windowList[DisplayObject(win).name];
			
			if(otherWin)
			{
				win.hide();
				otherWin.removeFromParent(true);
				otherWin.dispose();
				delete _windowList[DisplayObject(win).name];
			}
		}
		/**
		 * 移除掉所有窗口 
		 * 
		 */		
		public static function removeAll():void
		{
			for(var i:String in _windowList)
			{
				var otherWin:WindowWithModal;
				otherWin = 	_windowList[i] as WindowWithModal;
				if(PopUpWindow(otherWin.window).isMoving) continue;
				removePopUpWindow(otherWin.window);
			}
		}
		/**
		 * add the auto pop up window 
		 * @param win
		 * @param parent
		 * 
		 */		
		public static function addAutoPopUpWindow(data):void
		{
			_sequenceData.push(data);
		}
		
		/**
		 *start the auto pop up window 
		 * 
		 */		
		public static function autoPopUp():void
		{
			var data:Array = [];
			var window:DisplayObject;
			var parent:DisplayObject;
			if (_sequenceData.length != 0)
			{
				data = _sequenceData.shift();
				window = data[0];
				window.addEventListener(Event.REMOVED_FROM_STAGE, nextPopUpHandler);
				PopUpWindowManager.addPopUpWindow.apply(PopUpWindowManager,data)
			}
		}
		/**
		 * the handler to show the next window 
		 * @param e
		 * 
		 */		
		private static function nextPopUpHandler(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, nextPopUpHandler);
			if(_sequenceData.length == 0) return;
			
			autoPopUp();
		}
		/**
		 * 把弹窗移到顶 
		 * @param target
		 * 
		 */		
		public static function bringTop(target:PopUpWindow):void
		{
				trace("bringTopbringTopbringTop");
			var otherWin:WindowWithModal = _windowList[target.name];
			
			if(otherWin)
			{
				trace("bringTopbringTopbringTop",target.name);
				otherWin.parent.addChild(otherWin);
			}
		}
	}
}

import com.jzgame.enmu.ReleaseUtil;
import com.spellife.display.PopUpWindow;
import com.spellife.interfaces.display.IPopUpWindow;

import starling.display.DisplayObject;
import starling.display.Shape;
import starling.display.Sprite;
import starling.events.Event;

/**
 * 2011.6.15 a window with modal 
 * @author apple
 * 
 */
class WindowWithModal extends Sprite
{
	private var _modal:Shape      = new Shape();
	private var _win:PopUpWindow;
	/**
	 * 
	 * @param win
	 * @param stageWidth
	 * @param stageHeight
	 * 
	 */	
	public function WindowWithModal(win:PopUpWindow,stageWidth:Number, stageHeight:Number)
	{
		_win = win;
		if(win.isModal)
		{
			_modal.graphics.clear();
			if(win.isModalVisible)
			{
				_modal.graphics.beginFill(0x000000,0.4);
			}else
			{
				_modal.graphics.beginFill(0x000000,0);
			}
			_modal.graphics.drawRect(0,0,stageWidth,stageHeight);
			_modal.graphics.endFill();
		}else
		{
			_modal.graphics.clear();
		}
		_win.pivotX = Math.round(_win.width * 0.5);
		_win.pivotY = Math.round(_win.height * 0.5);
		_win.x            = Math.round((ReleaseUtil.STAGE_WIDTH) * 0.5);
		_win.y            = Math.round((ReleaseUtil.STAGE_HEIGHT) * 0.5);
		addChild(_modal);
		this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
	}
	
	private function addToStageHandler(e:Event):void
	{
		this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		
		addChild(_win);
	}
	
	public function get window():PopUpWindow
	{
		return _win as PopUpWindow;
	}
	/**
	 * 销毁 
	 * 
	 */	
	override public function dispose():void
	{
		while(this.numChildren > 0)
		{
			getChildAt(0).removeFromParent(true);
		}
		
		_win = null;
	}
}