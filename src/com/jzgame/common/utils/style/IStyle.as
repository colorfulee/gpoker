package com.jzgame.common.utils.style
{
import com.spellife.display.ImageButton;
import com.spellife.display.S9ImageButton;
import com.spellife.display.Scale9BitmapData;

import flash.display.BitmapData;

/**
 *
 * @author Rakuten
 *
 */
public interface IStyle
{
    /**
     * 滚动条上按钮
     * @return
     *
     */
    function get listBarUpButton():ImageButton
    /**
     * 滚动条下按钮
     * @return
     *
     */
    function get listBarDownButton():ImageButton
    /**
     * 滚动条背景
     * @return
     *
     */
    function get listBarHandlerBack():Scale9BitmapData
    /**
     * 滚动条滑块
     * @return
     *
     */
    function get listBarHandler():Scale9BitmapData
    /**
     * 任务完成弹窗背景
     * @return
     *
     */
    function get missionCompleteBg():Scale9BitmapData
    /**
     * 成就圆角半透明背景
     * @return
     *
     */
    function get roundBg():Scale9BitmapData

    /**
     * 成就圆角半透明over背景
     * @return
     *
     */
    function get roundOverBg():Scale9BitmapData
    /**
     * 任务完成弹窗背景
     * @return
     *
     */
    function get missionCompleteSmallBg():BitmapData
    /**
     * 滚动条中间的icon
     * @return
     *
     */
    function get scrollCenterIcon():BitmapData
    /**
     * 获取统一按钮  圆角按钮 不能y軸拉伸
     * @return
     *
     */
    function get imageNormalButton():S9ImageButton
    /**
     * 获取统一按钮 方角按钮 不能拉伸
     * @return
     *
     */
    function get imageRectNormalButton():ImageButton
    /**
     * 获取统一按钮 方角按钮 可以横向拉伸
     * @return
     *
     */
    function get imageRectNormalHorButton():S9ImageButton
    /**
     * 获取关闭按钮
     * @return
     *
     */
    function get closeButton():ImageButton
    /**
     *
     * @return
     *
     */
    function get rectAlphaBackground():Scale9BitmapData
		
	/**
	 * 获取vip按钮 
	 * @return 
	 * 
	 */		
	function get vipButton():ImageButton
}
}
