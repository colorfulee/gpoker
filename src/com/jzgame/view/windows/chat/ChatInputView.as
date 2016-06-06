package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.TextInput;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ChatInputView extends Sprite
	{
		/***********
		 * name:    ChatInputView
		 * data:    Jan 13, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale9Image;
		private var _textField:TextInput;
		private var _label:SLLabel;
		public function ChatInputView()
		{
			super();
			
			init();
		}
		private function init():void
		{
			_back = new Scale9Image(new Scale9Textures(
				ResManager.defaultAssets.getTexture('s9_table_bg_shurukuang'),new Rectangle(10,10,1,1)));
			addChild(_back);
			_back.width = 280;
			_back.height = 64;
			
			_textField = new TextInput();
			_textField.maxChars = 30;
			_textField.width = 280;
			_textField.height = 64;
			_textField.textEditorProperties.fontFamily = HtmlTransCenter.Arial();
			_textField.textEditorProperties.fontSize = 18;
			_textField.textEditorProperties.color = 0xffffff;
//			_textField.width = ;
//			addChild(_textField);
			
			_label = new SLLabel();
			_label.textRendererProperties.textFormat = StyleProvider.getTF(0xffffff,18);
//			_label.setLocation();
			_label.setSize(280,64);
			addChild(_label);
			
			_label.addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		public function clearText():void
		{
			_label.text = '';
			_textField.text = "";
		}
		
		public function set text(value:String):void
		{
			_label.text = value;
//			_textField.text = value;
		}
		public function get text():String
		{
			return _label.text;
		}
		
		private function touchHandler(e:TouchEvent):void
		{
			if(e.getTouch(this,TouchPhase.ENDED))
			{
				SignalCenter.onChatShowInputTriggered.dispatch(_label.text);
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			_label.removeEventListener(TouchEvent.TOUCH, touchHandler);
		}
	}
}