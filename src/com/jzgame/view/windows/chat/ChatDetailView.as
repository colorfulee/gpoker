package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindow;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ChatDetailView extends PopUpWindow
	{
		/***********
		 * name:    ChatDetailView
		 * data:    Jan 8, 2016
		 * author:  jim
		 * des:     聊天详细界面
		 ***********/
		private var _back:Scale9Image;
		public var tabBar:List;
		public var container:Sprite = new Sprite;
		
		private var _bottomBack:Scale9Image;
		public var input:ChatInputView;
		private var _soundBtn:Button;
		private var _atBtn:Button;
		public var send:Button;
		public function ChatDetailView()
		{
			super();
			
			this.name = WindowFactory.CHAT_DETAIL_WINDOW;
			_motionEffect = null;
			_isSole = false;
//			_isModal = false;
			init();
		}
		
		private function init():void
		{
			_back = new Scale9Image(new Scale9Textures(ResManager.defaultAssets.getTexture('s9_table_bg_liaotiandi'),new Rectangle(10,10,1,1)));
			_back.width = 488;
			_back.height = 572;
			addChild(_back);
			
			tabBar = new List();
			tabBar.itemRendererType = ChatDetailTabListItem;
			tabBar.itemRendererProperties.height = 166;
			var layout:VerticalLayout = new VerticalLayout();
			tabBar.layout = layout;
			addChild(tabBar);
			tabBar.x = 5;
			tabBar.y = 5;
			tabBar.dataProvider = new ListCollection([1,2,3]);
			
			addChild(container);
			
			_bottomBack = new Scale9Image(new Scale9Textures(ResManager.defaultAssets.getTexture('s9_table_bg_shurukuang')
				,new Rectangle(15,18,1,1)));
			_bottomBack.width = 485;
			_bottomBack.height = 75;
			_bottomBack.y = 495;
			addChild(_bottomBack);
			
			
			_soundBtn = new Button();
			_soundBtn.styleProvider = null;
			_soundBtn.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_microphone1'));
			_soundBtn.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_microphone1'));
			_soundBtn.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_microphone2'));
			_soundBtn.downIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_microphone2'));
			_soundBtn.y = 502;
			addChild(_soundBtn);
			
			input = new ChatInputView();
			input.x = 80;
			input.y = 500;
			addChild(input);
			
			_atBtn = new Button();
			_atBtn.styleProvider = null;
			_atBtn.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_@'));
			_atBtn.x = 288;
			_atBtn.y = 510;
			addChild(_atBtn);
			
			send = new Button();
			send.styleProvider = null;
			send.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_send1'));
			send.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_send2'));
			send.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_txt_send1'));
			send.downIcon = new Image(ResManager.defaultAssets.getTexture('table_txt_send1'));
			send.x = 368;
			send.y = 500;
			addChild(send);
			
			_atBtn.addEventListener(Event.TRIGGERED, atHandler);
		}
		
		override public function show(...rests):void
		{
			super.show(rests);
			
			this.x = this.width * 0.5;
			
			this.scale = 1;
			
		}
		private function atHandler(e:Event):void
		{
			var at:ChatAtView = new ChatAtView();
			addChild(at);
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
	}
}