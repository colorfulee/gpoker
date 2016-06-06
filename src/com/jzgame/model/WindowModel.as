package com.jzgame.model
{
	import com.jzgame.common.configHelper.Configure;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import starling.display.DisplayObject;

	public class WindowModel
	{
		public static var popUpContainer:Sprite;
		
		private var window:Dictionary = new Dictionary;
		private var dic:Dictionary = new Dictionary;
		
//		[Inject]
//		public var config:ConfigModel;
		
		/**
		 * 插入窗体实例 
		 * @param windowName
		 * @param windowIns
		 * 
		 */		
		public function insert(windowName:String, windowIns:DisplayObject) : void
		{
			this.window[windowName] = windowIns;
			return;
		}
		/**
		 * 查找窗体实例 
		 * @param windowName
		 * @return 
		 * 
		 */		
		public function getWindow(windowName:String) : DisplayObject
		{
			return this.window[windowName] as DisplayObject;
		}
		/**
		 * 移除窗体实例 
		 * @param windowName
		 * 
		 */		
		public function removeWindow(windowName:String) : void
		{
			delete window[windowName];
		}
		/**
		 * 创建窗体实例
		 * @param windowName
		 * @return 
		 * 
		 */		
		public function createWindow(windowName:String) : DisplayObject
		{
			return new dic[windowName] as DisplayObject;
		}
		/**
		 * 注册窗体类
		 * @param windowName
		 * @param windowc
		 * 
		 */		
		public function register(windowName:String, windowc:Class) : void
		{
			dic[windowName] = windowc;
		}
		/**
		 * 移除注册的窗体类,为modular服务
		 * @param windowName
		 * 
		 */		
		public function remove(windowName:String):void
		{
			delete dic[windowName];
		}
		/**
		 * 查找是否有注册过窗体类
		 * @param windowName
		 * @return 
		 * 
		 */		
		public function hasRegisterWindow(windowName:String) : Boolean
		{
			if (this.dic[windowName] == null)
			{
				return false;
			}
			return true;
		}
		
	}
}