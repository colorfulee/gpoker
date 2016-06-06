package com.jzgame.modules.table.ui
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.view.windows.chat.ChatView;
	import com.jzgame.view.windows.online.OnlineView;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class TableUIView extends Sprite
	{
		/***********
		 * name:    TableUIView
		 * data:    Nov 18, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var roomLabel:Label;
		public var toolButton:Button;
		public var toolView:TableToolView;
		public var online:OnlineView;
		public var chat:ChatView;
		public function TableUIView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			roomLabel = new Label;
			roomLabel.width = 200;
			roomLabel.x = 80;
			roomLabel.y = 5;
			addChild(roomLabel);
			roomLabel.textRendererProperties.textFormat = StyleProvider.getTF(0x655b76,16,HtmlTransCenter.Arial());
			roomLabel.textRendererProperties.textFormat.bold = true;
			
			toolButton = new Button();
			toolButton.styleProvider = null;
			toolButton.defaultSkin = new Image(ResManager.tableAssets.getTexture('table_btn_menu1'));
			toolButton.downSkin = new Image(ResManager.tableAssets.getTexture('table_btn_menu2'));
			addChild(toolButton);
			
			toolView = new TableToolView;
			toolView.visible = false;
			addChild(toolView);
		}
		
		public function start():void
		{
			online = new OnlineView();
			online.x = ReleaseUtil.STAGE_WIDTH - 130;
			online.y = ReleaseUtil.STAGE_HEIGHT - 140;
			addChild(online);
			
			chat = new ChatView;
			chat.y = ReleaseUtil.STAGE_HEIGHT - chat.height;
			addChild(chat);
		}
	}
}