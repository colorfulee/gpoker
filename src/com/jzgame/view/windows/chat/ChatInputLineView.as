package com.jzgame.view.windows.chat
{
	import com.jzgame.common.model.NetSendProxy;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.enmu.ReleaseUtil;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ChatInputLineView extends Sprite
	{
		/***********
		 * name:    ChatInputLineView
		 * data:    Jan 14, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale9Image ;
		public var returnBack:Button;
		public var input:ChatMessageInputView;
		public var clear:Button;
		public var send:Button;
		public var sound:Button;
		public function ChatInputLineView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_back = new Scale9Image(new Scale9Textures(ResManager.defaultAssets.getTexture('s9_table_bg_shurukuang')
				,new Rectangle(15,18,1,1)));
			_back.width = ReleaseUtil.STAGE_WIDTH;
			_back.height = 75;
			_back.y = 0;
			addChild(_back);
			
			returnBack = new Button();
			returnBack.styleProvider = null;
			returnBack.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_microphone1'));
			returnBack.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_microphone2'));
			
			returnBack.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_back1'));
			returnBack.downIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_back2'));
			addChild(returnBack);
			returnBack.y = 10;
			returnBack.x = 10;
			
			input = new ChatMessageInputView();
			input.x = 75;
			input.y = 10;
			addChild(input);
			
			clear = new Button();
			clear.styleProvider = null;
			clear.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_btn_delete'));
			clear.x = 633;
			clear.y = 10;
			addChild(clear);
			
			send = new Button();
			send.styleProvider = null;
			send.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_send1'));
			send.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_send2'));
			send.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_txt_send1'));
			send.downIcon = new Image(ResManager.defaultAssets.getTexture('table_txt_send1'));
			send.x = 833;
			send.y = 10;
			addChild(send);
			
			sound = new Button();
			sound.styleProvider = null;
			sound.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_send1'));
			sound.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_send2'));
			sound.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_txt_send1'));
			sound.downIcon = new Image(ResManager.defaultAssets.getTexture('table_txt_send1'));
			sound.x = 703;
			sound.y = 10;
			addChild(sound);
			
			returnBack.addEventListener(Event.TRIGGERED, returnHandler);
			clear.addEventListener(Event.TRIGGERED, clearHandler);
			send.addEventListener(Event.TRIGGERED, sendHandler);
		}
		
		public function setFocus():void
		{
			input.setFocus();
		}
		public function set text(t:String):void
		{
			input.text = t;
		}
		private function returnHandler(e:Event):void
		{
			this.removeFromParent(true);
		}
		/**
		 * 清空 
		 * @param e
		 * 
		 */		
		private function clearHandler(e:Event):void
		{
			text = '';
		}
		/**
		 * 发送 
		 * @param e
		 * 
		 */		
		private function sendHandler(e:Event):void
		{
			SignalCenter.onChatInputSendTriggered.dispatch(input.text);
		}
		/**
		 * 析构 
		 * 
		 */		
		override public function dispose():void
		{
			super.dispose();
			send.removeEventListener(Event.TRIGGERED, sendHandler);
			returnBack.removeEventListener(Event.TRIGGERED, returnHandler);
			clear.removeEventListener(Event.TRIGGERED, clearHandler);
		}
	}
}