package com.starling.theme
{
	import com.jzgame.common.utils.ResManager;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
	import feathers.skins.FunctionStyleProvider;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.Texture;

	public class StyleProvider
	{
		/***********
		 * name:    Style
		 * data:    Nov 11, 2015
		 * author:  jim
		 * des:
		 ***********/
		public static var customButtonStyles:FunctionStyleProvider = new FunctionStyleProvider(skinButton);
		public static var CUSTOM_RADIO_WITH_CHECK:String = "CUSTOM_RADIO_WITH_CHECK";
		public static var CUSTOM_TAB_BUTTON_IN_MAIL:String = "CUSTOM_TAB_BUTTON_IN_MAIL";
		public static var CUSTOM_SIMPLEBAR_IN_MAIL:String = "CUSTOM_SIMPLEBAR_IN_MAIL";
		public static var CUSTOM_LIST_IN_MAIL:String = "CUSTOM_LIST_IN_MAIL";
		public static var CUSTOM_INC_IN_NUM_STEPPER:String = "CUSTOM_INC_IN_NUM_STEPPER";
		public static var CUSTOM_DECC_IN_NUM_STEPPER:String = "CUSTOM_DECC_IN_NUM_STEPPER";
		public static var CUSTOM_TEXT_INPUT_IN_NUM_STEPPER:String = "CUSTOM_TEXT_INPUT_IN_NUM_STEPPER";
		public static var CUSTOM_BUTTON_IN_MESSAGE:String = "CUSTOM_BUTTON_IN_MESSAGE";
		public static var CUSTOM_BUTTON_IN_PRE_OPERATE:String = "CUSTOM_BUTTON_IN_PRE_OPERATE";
		public function StyleProvider()
		{
			Label.globalStyleProvider = new FunctionStyleProvider(skinLabel);
		}
		/**
		 * 创建一个一般定制的按钮 
		 * @param defaultTexture
		 * @param downTexture
		 * @param defaultIcon
		 * @param downIcon
		 * @return 
		 * 
		 */		
		public static function createButton(defaultTexture:Texture,downTexture:Texture=null,defaultIcon:Texture=null,downIcon:Texture=null):Button
		{
			var button:Button = new Button();
			button.styleProvider = null;
			button.defaultSkin = new Image(defaultTexture);
			button.downSkin = new Image(downTexture);
			button.defaultIcon = new Image(defaultIcon);
			button.downIcon = new Image(downIcon);
			return button;
		}
		/**
		 * 获取文本样式 
		 * @param color
		 * @param size
		 * @param font
		 * @param align
		 * @return 
		 * 
		 */		
		public static function getTF(color:uint,size:uint=12,font:String="",align:String = "left",b:Boolean = false):TextFormat
		{
			var tf:TextFormat = new TextFormat(font,size,color);
			tf.align = align;
			if(font == "")
			{
				tf.font = HtmlTransCenter.Arial();
			}
			tf.bold = b;
			return tf;
		}
		
		private static function skinButton( button:Button ):void
		{
			button.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Recharge1"));
			button.downSkin    = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Recharge2"));
		}
		
		private static function skinLabel( label:Label ):void
		{
			label.textRendererFactory = function():ITextRenderer
			{
				return new TextFieldTextRenderer();
			}
		}
		/**
		 * 获取充值按钮 
		 * @return 
		 * 
		 */		
		public static function get addCashButton():Button
		{
			var button:Button = new Button;
			button.styleProvider = null;
			button.defaultSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_recharge1"));
			button.downSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_recharge2"));
			button.defaultIcon = new Image(ResManager.defaultAssets.getTexture("details_txt_recharge"));;
			button.downIcon = new Image(ResManager.defaultAssets.getTexture("details_txt_recharge"));;
			return button;
		}
		/**
		 * 获取关闭按钮 
		 * @return 
		 * 
		 */		
		public static function get closeButton():Button
		{
			var button:Button = new Button;
			button.styleProvider = null;
			button.defaultSkin = new Image(ResManager.defaultAssets.getTexture("common_btn_close1"));
			button.downSkin = new Image(ResManager.defaultAssets.getTexture("common_btn_close2"));
			return button;
		}
		/**
		 * 获取通用灰白色背景 
		 * @return 
		 * 
		 */		
		public static function get commonWhiteRoundBack():Scale9Image
		{
			return new Scale9Image(new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1)));
		}
		/**
		 * 获取通用背景 
		 * @return 
		 * 
		 */		
		public static function get commonRoundBack():Scale9Image
		{
			return new Scale9Image(new Scale9Textures(ResManager.defaultAssets.getTexture('common_bg_popup1'),new Rectangle(20,20,1,1)));
		}
		/**
		 * 获取num 
		 * @param num
		 * @return 
		 * 
		 */		
		public static function getNum(num:uint):QuadBatch
		{
			var snum:String = num.toString();
			var batch:QuadBatch = new QuadBatch;
			var img:Image;
			for(var i:uint = 0; i<snum.length; i++)
			{
				img = new Image(ResManager.defaultAssets.getTexture("MTT_txt_"+snum.substr(i,1)));
				img.x = batch.width + 7;
				batch.addImage(img);
			}
			return batch;
		}
	}
}