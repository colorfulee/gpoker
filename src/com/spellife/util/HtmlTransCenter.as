package com.spellife.util
{
	import com.jzgame.common.utils.AssetsCenter;
	
	import flash.system.Capabilities;

	public class HtmlTransCenter
	{
		/*auther     :jim
		* file       :HtmlTransCenter.as
		* date       :Aug 29, 2014
		* description:
		*/
		public function HtmlTransCenter()
		{
		}
		
		public static function microsoftYaHei():String
		{
			Capabilities.os
			var pType:String = String(Capabilities.playerType);
//			
//			if (pType == "Plugin" || pType == "ActiveX") {/* swf is running a browser */};
//			if (pType == "Desktop") {/* swf is running in a desktop AIR application */};
//			if (pType == "StandAlone") {/* swf is running in a standalone Flash Player */};
//			if (pType == "External") {/* swf is running in the Flash IDE preview player */};
//			return "微软雅黑";
			return "Microsoft YaHei";
		}
		/**
		 * 宋体 
		 * @return 
		 * 
		 */		
		public static function SontTi():String
		{
			return "SimSun";
		}
		/**
		 * 黑体 
		 * @return 
		 * 
		 */		
		public static function Hei():String
		{
			return "SimHei";
		}
		/**
		 * 默认字体 
		 * @return 
		 * 
		 */
		public static function Arial():String
		{
			if(ExternalVars.language == AssetsCenter.ZH_TW)
			{
				return microsoftYaHei();
			}
			return "Arial";
		}
		/**
		 * arial 字体 
		 * @return 
		 * 
		 */		
		public static function realArial():String
		{
			return "Arial";
		}
		/**
		 * 
		 * @param text
		 * @param color
		 * @return 
		 * 
		 */		
		public static function getColorStr(text:String, color:String) : String
		{
			return "<font color=\'#" + color + "\'>" + text + "</font>";
		}
		/**
		 * 
		 * @param text
		 * @param size
		 * @return 
		 * 
		 */		
		public static function getSizeStr(text:String, size:uint) : String
		{
			return "<font size='" + size + "'>" + text + "</font>";
		}
		/**
		 * 
		 * @param text
		 * @param color
		 * @param size
		 * @return 
		 * 
		 */		
		public static function getHtmlStr(text:String,color:String,size:uint=12,font:String="",align:String = "left"):String
		{
			if(font == "") font = Arial();
			return "<p align='"+align+"'><font color=\'#" + color + "' size='" + size + "' face='"+font+"'>" + text + "</font></p>";
		}
		/**
		 * 获取html字段
		 * @param text
		 * @param color
		 * @param size
		 * @param font
		 * @return 
		 * 
		 */		
		public static function getFontStr(text:String,color:String,size:uint=12,font:String=""):String
		{
			if(font == "") font = Arial();
			return "<font color=\'#" + color + "' size='" + size + "' face='"+font+"'>" + text + "</font>";
		}
		/**
		 * 
		 * @param text
		 * @return 
		 * 
		 */		
		public static function getBoldStr(text:String):String
		{
			return "<b>"+text+"</b>";
		}
		/**
		 * 增加下划线  
		 * @param text
		 * @return 
		 * 
		 */		
		public static function getUnderLineStr(text:String):String
		{
			return "<u>"+text+"</u>";
		}
	}
}