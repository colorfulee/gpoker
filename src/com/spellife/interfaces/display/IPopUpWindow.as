package com.spellife.interfaces.display
{
	import com.spellife.interfaces.effect.ITweenEffect;

	public interface IPopUpWindow
	{
//		是否需要全屏背景
		function get isModal():Boolean
//		是否需要全屏背景
		function get isModalVisible():Boolean
//		是否是唯一显示窗体
		function get isSole():Boolean
//		是否可拖拽
		function get isDrag():Boolean
//是否屏蔽鼠标事件
		function get isEnable():Boolean
		
		function get motionEffect():ITweenEffect
		function show(...rests):void
		function hide():void
	}
}