package com.jzgame.view.windows.userInfo
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.AssetsName;
	import com.jzgame.enmu.SystemColor;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.display.FaceWithFrame;
	import com.jzgame.view.display.TabBarListItem;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.ProgressBar;
	import feathers.data.ListCollection;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PopUpUserDetailWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    PopUpUserInfoWindow
		 * data:    Dec 4, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var vipBtn:Button;
		
		private var _glodIcon:Image;
		public var goldLable:SLLabel;
		private var _moneyIcon:Image;
		public var moneyLable:SLLabel;
		public var face:FaceWithFrame;
		public var userName:Label;
		public var playerId:SLLabel;
		public var lv:SLLabel;
		public var exp:SLLabel;
		public var expProgress:ProgressBar;
		public var tabBar:List;
		public var recentAchie:List;
		public var rectentBack:Scale3Image;
		public var addCash:Button;
		public var round:Button;
		public var viewPack:Button;
		public var addFriend:Button;
		public var delFriend:Button;
		public var safeBox:Button;
		//我的成就进度
		public var myAchie:SLLabel;
		
		private var _infoBack:Scale9Image;
		public var infoContainer:Sprite = new Sprite;
		public function PopUpUserDetailWindow()
		{
			super();
			
			mName = WindowFactory.PLAYER_INFO_WINDOW;
		}
		override protected function init():void
		{
			super.init();
			
			hasDefaultTitleBack = false;
			
			userName = new Label();
			userName.x = 169;
			userName.y = 26;
			userName.textRendererProperties.textFormat =  StyleProvider.getTF(SystemColor.WHITE,22, HtmlTransCenter.Arial());
			userName.text = "my name";
			addChild(userName);
			
			playerId = new SLLabel();
			playerId.setLocation(760,25);
			playerId.setSize(100,30);
			playerId.textRendererProperties.textFormat =  StyleProvider.getTF(0x534f69,16, HtmlTransCenter.Arial());
			playerId.text = "my name";
			addChild(playerId);
			
			
			lv = new SLLabel();
			lv.setLocation(160,116);
			lv.setSize(100,30);
			lv.textRendererProperties.textFormat =  StyleProvider.getTF(0x996bb9,18, HtmlTransCenter.Arial());
			lv.text = "lv";
			addChild(lv);
			
			expProgress = new ProgressBar();
			expProgress.minimum = 0;
			expProgress.maximum = 100;
			expProgress.value = 10;
			expProgress.x = 215;
			expProgress.y = 125;
			addChild( expProgress );
			
			exp = new SLLabel();
			exp.setLocation(215,120);
			exp.setSize(250,30);
			exp.text = "exp";
			exp.textRendererProperties.isHTML = true;
			addChild(exp);
			
			_moneyIcon = new Image(ResManager.defaultAssets.getTexture(AssetsName.ASSET_20000_CLIP_ICON));
			_moneyIcon.x = 160;
			_moneyIcon.y = 72;
			addChild(_moneyIcon);
			
			goldLable = new SLLabel;
			goldLable.setSize(180,26);
			goldLable.setLocation(380,72);
			goldLable.textRendererProperties.textFormat = StyleProvider.getTF(SystemColor.LIGHT_WHITE_TEXT,20, HtmlTransCenter.Arial());
			addChild(goldLable);
			
			_glodIcon = new Image(ResManager.defaultAssets.getTexture(AssetsName.ASSET_20000_GOLD_ICON));
			_glodIcon.x = 340;
			_glodIcon.y = 72;
			addChild(_glodIcon);
			
			moneyLable = new SLLabel;
			moneyLable.setSize(180,26);
			moneyLable.setLocation(198,72);
			moneyLable.textRendererProperties.textFormat =  StyleProvider.getTF(SystemColor.LIGHT_WHITE_TEXT,20, HtmlTransCenter.Arial());
			addChild(moneyLable);
			
			face = new FaceWithFrame();
			face.x = 30;
			face.y = 30;
			addChild(face);
			
			vipBtn = new Button();
			vipBtn.styleProvider = null;
			vipBtn.x = 412;
			vipBtn.y = 15;
			addChild(vipBtn);
			
			addCash = StyleProvider.addCashButton;
			addCash.x = 525;
			addCash.y = 70;
			addChild(addCash);
			
			var s3:Scale3Textures = new Scale3Textures(ResManager.defaultAssets.getTexture("s9_details_bg_achieve1"),10,30);
			rectentBack = new Scale3Image(s3);
			rectentBack.width = 343;
			rectentBack.x = 40;
			rectentBack.y = 490;
			addChild(rectentBack);
			
			recentAchie = new List;
			recentAchie.x = 50;
			recentAchie.y = 500;
			recentAchie.width = 343;
			recentAchie.height = 99;
			var lay:HorizontalLayout = new HorizontalLayout;
			lay.gap = 10;
			recentAchie.layout = lay;
			recentAchie.itemRendererType = RecentAchieListItem;
			recentAchie.itemRendererProperties.width = 76; 
			addChild(recentAchie);
			
			myAchie = new SLLabel();
			myAchie.setLocation(121,563);
			myAchie.setSize(200,30);
			myAchie.textRendererProperties.isHTML = true;
			//			myAchie.textRendererProperties.textFormat =  StyleProvider.getTF(0x534f69,16, HtmlTransCenter.Arial());
			myAchie.text = "my achie";
			addChild(myAchie);
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 672;
			_infoBack.height = 303;
			_infoBack.x = 255;
			_infoBack.y = 170;
			addChild(_infoBack);
			
			addChild(infoContainer);
			
			
			tabBar = new List();
			tabBar.x = 35;
			tabBar.y = 170;
			tabBar.itemRendererProperties.height = 72;
			tabBar.itemRendererType = TabBarListItem;
			tabBar.dataProvider = new ListCollection(
				[
					{ label: LangManager.getText("500107") },
					{ label: LangManager.getText("500108") }
				]);
			addChild(tabBar);
			
			var tabBarLayout:VerticalLayout = new VerticalLayout();
			tabBarLayout.gap = 30;
			tabBar.minimumDragDistance = 0.1;
			tabBarLayout.useVirtualLayout = true;
			tabBar.layout = tabBarLayout;
			
			
			round = new Button;
			round.styleProvider = null;
			round.defaultSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_myitem1"));
			round.downSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_myitem2"));
			round.defaultIcon = new Image(ResManager.defaultAssets.getTexture("details_txt_recording1"));
			round.downIcon = new Image(ResManager.defaultAssets.getTexture("details_txt_recording2"));
			round.x = 455;
			round.y = 504;
			addChild(round);
			round.visible = false;
			
			viewPack = new Button;
			viewPack.styleProvider = null;
			viewPack.defaultSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_myitem1"));
			viewPack.downSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_myitem2"));
			viewPack.defaultIcon = new Image(ResManager.defaultAssets.getTexture("details_txt_myitem1"));
			viewPack.downIcon = new Image(ResManager.defaultAssets.getTexture("details_txt_myitem2"));
			viewPack.x = 714;
			viewPack.y = 504;
			addChild(viewPack);
			viewPack.visible = false;
			
			addFriend = new Button;
			addFriend.styleProvider = null;
			addFriend.defaultSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_myitem1"));
			addFriend.downSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_myitem2"));
			addFriend.defaultIcon = new Image(ResManager.defaultAssets.getTexture("details_txt_addfriends1"));
			addFriend.downIcon = new Image(ResManager.defaultAssets.getTexture("details_txt_addfriends2"));
			addFriend.x = 714 - 190;
			addFriend.y = 504;
			addChild(addFriend);
			addFriend.visible = false;
			
			delFriend = new Button;
			delFriend.styleProvider = null;
			delFriend.defaultSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_myitem1"));
			delFriend.downSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_myitem2"));
			delFriend.defaultIcon = new Image(ResManager.defaultAssets.getTexture("details_txt_addfriends1"));
			delFriend.downIcon = new Image(ResManager.defaultAssets.getTexture("details_txt_addfriends2"));
			delFriend.x = 714 - 190;
			delFriend.y = 504;
			addChild(delFriend);
			delFriend.visible = false;
			
			safeBox = new Button;
			safeBox.styleProvider = null;
			safeBox.defaultSkin = new Image(ResManager.defaultAssets.getTexture("details_icon_savebox1"));
			safeBox.downSkin = new Image(ResManager.defaultAssets.getTexture("details_icon_savebox2"));
			safeBox.x = 80-36;
			safeBox.y = 380;
			addChild(safeBox);
		}
		
		override public function dispose():void
		{
			super.dispose();
			tabBar = null;
		}
	}
}