package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.ResManager;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.TextInput;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Sprite;
	
	public class ChatMessageInputView extends Sprite
	{
		/***********
		 * name:    ChatInputView
		 * data:    Jan 13, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale9Image;
		private var _textField:TextInput;
		public function ChatMessageInputView()
		{
			super();
			
			init();
		}
		private function init():void
		{
			_back = new Scale9Image(new Scale9Textures(
				ResManager.defaultAssets.getTexture('s9_table_bg_shurukuang'),new Rectangle(10,10,1,1)));
			addChild(_back);
			_back.width = 620;
			_back.height = 64;
			
			_textField = new TextInput();
			_textField.maxChars = 30;
			_textField.width = 616;
			_textField.height = 64;
			_textField.textEditorProperties.fontFamily = HtmlTransCenter.Arial();
			_textField.textEditorProperties.fontSize = 18;
			_textField.textEditorProperties.color = 0xffffff;
//			_textField.width = ;
			addChild(_textField);
		}
		
		public function clearText():void
		{
			_textField.text = "";
		}
		
		public function set text(value:String):void
		{
			_textField.text = value;
		}
		public function get text():String
		{
			return _textField.text;
		}
		public function setFocus():void
		{
			_textField.setFocus();
		}
	}
}