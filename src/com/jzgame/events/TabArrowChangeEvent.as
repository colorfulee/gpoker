package com.jzgame.events
{
	import flash.events.Event;
	
	public class TabArrowChangeEvent extends Event
	{
		/*auther     :jim
		* file       :TabArrowChangeEvent.as
		* date       :Feb 4, 2015
		* description:tab 组件 箭头排序更改事件
		*/
		public static var CHANGE:String = "TabArrowChangeEvent_CHANGE";
		//选中索引
		public var tabIndex:uint;
		//排序顺序
		public var tabSort:uint;
		public function TabArrowChangeEvent(index:uint,sort:uint)
		{
			super(CHANGE, bubbles, cancelable);
			
			tabIndex = index;
			tabSort = sort;
		}
		
		override public function clone():Event
		{
			return new TabArrowChangeEvent(tabIndex,tabSort);
		}
	}
}