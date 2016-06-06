package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.ResManager;
	import com.spellife.feathers.SLLabel;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class ChatView extends Sprite
	{
		/***********
		 * name:    ChatView
		 * data:    Jan 8, 2016
		 * author:  jim
		 * des:
		 ***********/
		public var chatBtn:Button;
		private var _back:Scale9Image;
		private var _message:SLLabel;
		public function ChatView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_back = new Scale9Image(new Scale9Textures(ResManager.defaultAssets.getTexture('s9_table_bg_liaotiandi'),new Rectangle(10,10,1,1)));
			_back.width = 375;
			_back.height = 60;
			addChild(_back);
			
			chatBtn = new Button();
			chatBtn.styleProvider = null;
			chatBtn.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_chat1'));
			chatBtn.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_chat2'));
			chatBtn.y = 5;
			addChild(chatBtn);
			
			
			_message = new SLLabel;
			_message.setLocation(66,10);
			_message.setSize(300,30);
			addChild(_message);
		}
		
		public function receiveMessage(name:String,message:String):void
		{
			_message.text = name + " : "+message;
		}
	}
}