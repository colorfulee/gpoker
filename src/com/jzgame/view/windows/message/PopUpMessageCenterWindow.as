package com.jzgame.view.windows.message
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.SystemColor;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.display.TabBarListItem;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.IScrollBar;
	import feathers.controls.List;
	import feathers.controls.SimpleScrollBar;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class PopUpMessageCenterWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    MessageCenterView
		 * data:    Nov 24, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _title:Image;
		private var _titleBack:Image;
		
		public var tabBar:List;
		private var _infoBack:Scale9Image;
		private var _list:List;
		public var dele:Button;
		public var read:Button;
		public var allCheck:Check;
		private var _tip:SLLabel = new SLLabel;
		public function PopUpMessageCenterWindow()
		{
			super();
			
			_isSole = false;
			
			init();
		}
		
		private function init():void
		{
			_title = new Image(ResManager.defaultAssets.getTexture("mailbox_txt_mailbox"));
			_title.x = 40;
			addChild(_title);
			
			tabBar = new List();
			tabBar.x = 25;
			tabBar.y = 100;
			tabBar.itemRendererProperties.height = 72;
			tabBar.itemRendererType = TabBarListItem;
			tabBar.dataProvider = new ListCollection(
				[
					{ label: LangManager.getText("500201") }
				]);
			addChild(tabBar);
			
			var tabBarLayout:VerticalLayout = new VerticalLayout();
			tabBarLayout.gap = 15;
			tabBar.minimumDragDistance = 0.1;
			tabBarLayout.useVirtualLayout = true;
			tabBar.layout = tabBarLayout;
			
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 675;
			_infoBack.height = 512;
			_infoBack.x = 260;
			_infoBack.y = 100;
			addChild(_infoBack);
			
			_list = new List;
			_list.itemRendererType = MessageListItem;
			_list.width  = 655;
			_list.height = 445;
			_list.x = 275;
			_list.y = 106;
			addChild(_list);
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = -7;
			_list.minimumDragDistance = 0.1;
			_list.itemRendererProperties.height = 95;
			_list.snapScrollPositionsToPixels = false;
			_list.layout = layout;
			_list.verticalScrollBarFactory = function():IScrollBar
			{
				var bar:SimpleScrollBar = new SimpleScrollBar();
				bar.customThumbStyleName = StyleProvider.CUSTOM_SIMPLEBAR_IN_MAIL;
				bar.direction = SimpleScrollBar.DIRECTION_VERTICAL;
//				bar.addEventListener("change",updateHandler);
				return bar;
			}
				
			dele = new Button();
			dele.x = 580;
			dele.y = 555;
			dele.label = LangManager.getText("300406");
			addChild(dele);
			
			read = new Button();
			read.label = LangManager.getText("300405");
			read.x = 380;
			read.y = 555;
			addChild(read);
			
			allCheck = new Check();
			allCheck.x = 280;
			allCheck.y = 565;
			allCheck.defaultLabelProperties.textFormat = StyleProvider.getTF(0x100f17,18);
			allCheck.label = LangManager.getText("300407");
			addChild(allCheck);
			
			_tip.setSize(680,50);
			_tip.setLocation(260,300);
			_tip.touchable = false;
			_tip.textRendererProperties.isHTML = true;
			_tip.text = HtmlTransCenter.getBoldStr( HtmlTransCenter.getHtmlStr(LangManager.getText("402919"),'100f17',24,HtmlTransCenter.Arial(),TextFormatAlign.CENTER) );
			addChild(_tip);
			_tip.visible = false;
		}
		
		private function updateHandler(e:Event):void
		{
			var bar:SimpleScrollBar = e.currentTarget as SimpleScrollBar
		}
		/**
		 * 设置数据 
		 * @param data
		 * 
		 */		
		public function setList(data:Array):void
		{
			var d:Array = [];
			_list.dataProvider = new ListCollection(data);
			
			if(data.length > 0)
			{
				_tip.visible = false;
			}else
			{
				_tip.visible = true;
			}
		}
		
		override public function get name():String
		{
			return WindowFactory.MESSAGE_WINDOW;
		}
	}
}