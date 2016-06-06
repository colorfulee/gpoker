package com.jzgame.view.windows.safeBox
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.TextInput;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Sprite;
	
	public class SafeInfoView extends Sprite
	{
		/***********
		 * name:    SafeInfoView
		 * data:    Jan 7, 2016
		 * author:  jim
		 * des:
		 ***********/
		protected var _inputBack:Scale9Image;
		protected var _tip1:SLLabel;
		protected var _tip2:SLLabel;
		protected var _tip3:SLLabel;
		protected var _tip4:SLLabel;
		protected var _textInput:TextInput;
		protected var _textInput2:TextInput;
		protected var _textInput3:TextInput;
		protected var _errortip:SLLabel;
		public function SafeInfoView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_inputBack = StyleProvider.commonWhiteRoundBack;
			_inputBack.width  = 813;
			_inputBack.height = 317;
			addChild(_inputBack);
			
			_tip1 = new SLLabel();
			_tip1.text = LangManager.getText('500248');
			_tip1.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,20);
			_tip1.setLocation(136,40);
			addChild(_tip1);
			
			_tip2 = new SLLabel();
			_tip2.text = LangManager.getText('500249');
			_tip2.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,20);
			_tip2.setLocation(136,139);
			addChild(_tip2);
			
			_tip3 = new SLLabel();
			_tip3.text = LangManager.getText('500250');
			_tip3.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,20);
			_tip3.setLocation(136,260);
			addChild(_tip3);
			
			_tip4 = new SLLabel();
			_tip4.text = LangManager.getText('500251');
			_tip4.textRendererProperties.textFormat = StyleProvider.getTF(0xab5780,20);
			_tip4.setLocation(323,201);
			addChild(_tip4);
			
			_errortip = new SLLabel();
			_errortip.width = 120;
			_errortip.textRendererProperties.textFormat = StyleProvider.getTF(0xab5780,20);
			_errortip.setLocation(613,128);
			addChild(_errortip);
			
			_textInput = new TextInput;
			_textInput.x = 281;
			_textInput.y = 23;
			_textInput.width = 254;
			_textInput.height = 57;
			_textInput.textEditorProperties.fontSize = 40;
			_textInput.textEditorProperties.color = 0x333333;
			_textInput.displayAsPassword = true;
			//			_textInput.text = "Hello World";
			//			_textInput.prompt = "Password";
			_textInput.paddingLeft = 20;
			_textInput.paddingTop = 5;
			_textInput.maxChars = 20;
			//限制输入字符
			_textInput.restrict = "a-zA-Z0-9";
			addChild(_textInput);
			_textInput.backgroundSkin = new Scale9Image( new Scale9Textures((ResManager.defaultAssets.getTexture('s9_details_bg_shurukuang')),new Rectangle(20,15,1,1)) );
			
			_textInput2 = new TextInput;
			_textInput2.x = 281;
			_textInput2.y = 118;
			_textInput2.width = 254;
			_textInput2.height = 57;
			_textInput2.textEditorProperties.fontSize = 40;
			_textInput2.textEditorProperties.color = 0x333333;
			_textInput2.displayAsPassword = true;
			//			_textInput.text = "Hello World";
			//			_textInput.prompt = "Password";
			_textInput2.paddingLeft = 20;
			_textInput2.paddingTop = 5;
			_textInput2.maxChars = 20;
			//限制输入字符
			_textInput2.restrict = "a-zA-Z0-9";
			addChild(_textInput2);
			_textInput2.backgroundSkin = new Scale9Image( new Scale9Textures((ResManager.defaultAssets.getTexture('s9_details_bg_shurukuang')),new Rectangle(20,15,1,1)) );
			
			_textInput3 = new TextInput;
			_textInput3.x = 281;
			_textInput3.y = 242;
			_textInput3.width = 254;
			_textInput3.height = 57;
			_textInput3.textEditorProperties.fontSize = 40;
			_textInput3.textEditorProperties.color = 0x333333;
			_textInput3.displayAsPassword = true;
			//			_textInput.text = "Hello World";
			//			_textInput.prompt = "Password";
			_textInput3.paddingLeft = 20;
			_textInput3.paddingTop = 5;
			_textInput3.maxChars = 20;
			//限制输入字符
			_textInput3.restrict = "a-zA-Z0-9";
			addChild(_textInput3);
			_textInput3.backgroundSkin = new Scale9Image( new Scale9Textures((ResManager.defaultAssets.getTexture('s9_details_bg_shurukuang')),new Rectangle(20,15,1,1)) );
		}
		
		public function set error(value:String):void
		{
			_errortip.text = value;
		}
		
		public function getOldPsd1():String
		{
			return _textInput.text;
		}
		
		public function getOldPsd2():String
		{
			return _textInput2.text;
		}
			
		public function getNewPsd():String
		{
			return _textInput3.text;
		}
	}
}