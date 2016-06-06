package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.ResManager;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class ChatAtView extends Sprite
	{
		/***********
		 * name:    ChatAtView
		 * data:    Jan 13, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale9Image;
		private var _list:List;
		private var _bottomBack:Scale9Image;
		public var send:Button;
		public var returnBack:Button;
		public var input:ChatInputView;
		public var clear:Button;
		public function ChatAtView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_back = new Scale9Image(new Scale9Textures(ResManager.defaultAssets.getTexture('s9_table_bg_liaotiandi'),new Rectangle(10,10,1,1)));
			_back.width = 488;
			_back.height = 572;
			addChild(_back);
			
			_list = new List();
			_list.itemRendererType = ChatAtListItem;
			addChild(_list);
			
			_list.width =  488;
			_list.height = 572;
			
			_bottomBack = new Scale9Image(new Scale9Textures(ResManager.defaultAssets.getTexture('s9_table_bg_shurukuang')
				,new Rectangle(15,18,1,1)));
			_bottomBack.width = 485;
			_bottomBack.height = 75;
			_bottomBack.y = 495;
			addChild(_bottomBack);
			
			returnBack = new Button();
			returnBack.styleProvider = null;
			returnBack.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_microphone1'));
			returnBack.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_microphone2'));
			
			returnBack.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_back1'));
			returnBack.downIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_back2'));
			addChild(returnBack);
			returnBack.y = 500;
			returnBack.x = 10;
			
			send = new Button();
			send.styleProvider = null;
			send.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_send1'));
			send.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_send2'));
			send.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_txt_send1'));
			send.downIcon = new Image(ResManager.defaultAssets.getTexture('table_txt_send1'));
			send.x = 368;
			send.y = 500;
			addChild(send);
			
			input = new ChatInputView();
			input.x = 80;
			input.y = 500;
			addChild(input);
			
			clear = new Button();
			clear.styleProvider = null;
			clear.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_btn_delete'));
			clear.x = 310;
			clear.y = 510;
			addChild(clear);
		}
		
		public function setList(arr:Array):void
		{
			_list.dataProvider = new ListCollection(arr);
		}
	}
}