package com.jzgame.view.windows.friends
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.display.TabBarListItem;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PopUpFriendsWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    PopUpFriendsWindow
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:
		 ***********/
		protected var _title:Image;
		public var tabBar:List;
		private var _infoBack:Scale9Image;
		private var _list:List;
		private var _invite:Button;
		private var _showInvite:Boolean = false;
		public function PopUpFriendsWindow()
		{
			super();
			
			mName = WindowFactory.FRIENDS_WINDOW;
		}
		
		override protected function init():void
		{
			super.init();
			
			_title = new Image(ResManager.defaultAssets.getTexture("friends_txt_title"));
			_title.x = 35;
			_title.y = 10;
			addChild(_title);
			
			tabBar = new List();
			tabBar.x = 25;
			tabBar.y = 106;
			tabBar.itemRendererType = TabBarListItem;
			tabBar.dataProvider = new ListCollection(
				[
					{ label: LangManager.getText("500207") }
				]);
			addChild(tabBar);
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 675;
			_infoBack.height = 512;
			_infoBack.x = 240;
			_infoBack.y = 100;
			addChild(_infoBack);
			
			tabBar.selectedIndex= 0;
			
			_list = new List;
			_list.itemRendererType = FriendsListItem;
			_list.width  = 648;
			_list.height = 500;
			_list.x = 255;
			_list.y = 106;
			addChild(_list);
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 10;
			_list.minimumDragDistance = 0.1;
			layout.useVirtualLayout = true;
			_list.itemRendererProperties.height = 94;
			_list.snapScrollPositionsToPixels = false;
			_list.layout = layout;
			
			
			_invite = new Button();
			_invite.styleProvider = null;
			_invite.defaultSkin = new Image(ResManager.defaultAssets.getTexture('friends_btn_invitefacebook1'));
			_invite.defaultIcon = new Image(ResManager.defaultAssets.getTexture('friends_txt_invite'));
			_invite.iconOffsetX = 20;
			_invite.x = 30;
			_invite.y = 500;
			addChild(_invite);
		}
		
		override public function show(...rests):void
		{
			super.show(rests);
			
			if(rests[0])
			{
				_showInvite = true;
			}
		}
		/**
		 *  
		 * @param arr
		 * 
		 */		
		public function setList(arr:Array):void
		{
			for(var i:String in arr)
			{
				arr[i].showInvite = _showInvite;
			}
			_list.dataProvider = new ListCollection(arr);
		}
	}
}