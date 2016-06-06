package com.jzgame.view.windows.userInfo
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.AssetsName;
	import com.jzgame.enmu.SystemColor;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.display.FaceWithFrame;
	import com.spellife.display.PopUpWindow;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.ProgressBar;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PlayerInfoInGameView extends PopUpWindow
	{
		/***********
		 * name:    PlayerInfoInGameView
		 * data:    Dec 17, 2015
		 * author:  jim
		 * des:
		 ***********/
		//玩家id
		public var userId:uint;
		public var seat:uint;
		protected var _back:Scale9Image;
		public var vipBtn:Button;
		private var _close:Button;
		public var userName:Label;
		public var lv:SLLabel;
		public var face:FaceWithFrame;
		private var _moneyIcon:Image;
		public var moneyLable:SLLabel;
		public var exp:SLLabel;
		public var expProgress:ProgressBar;
		private var _infoBack:Scale9Image;
		
		public var maxRound:SLLabel;
		public var maxChip:SLLabel;
		public var maxWin:SLLabel;
		public var winRate:SLLabel;
		public var maxHand:SLLabel;
		public var maxHandList:List;
		public var addFriend:Button;
		public var atFriend:Button;
		public function PlayerInfoInGameView()
		{
			super();
			
			mName = WindowFactory.OTHER_USER_INFO_WINDOW;
			_isSole = false;
			init();
		}
		
		protected function init():void
		{
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup")
				,new Rectangle(20,20,1,1));
			_back = new Scale9Image(s9);
			_back.x = 3;
			_back.y = 10;
			_back.width  = 700;
			_back.height = 490;
			addChild(_back);
			
			_close = StyleProvider.closeButton;
			_close.x = 650 + 5;
			addChild(_close);
			
			setClose(_close);
			
			userName = new Label();
			userName.x = 169;
			userName.y = 26;
			userName.textRendererProperties.textFormat =  StyleProvider.getTF(SystemColor.WHITE,22, HtmlTransCenter.Arial());
			userName.text = "my name";
			addChild(userName);
			
			face = new FaceWithFrame();
			face.x = 30;
			face.y = 30;
			addChild(face);
			
			vipBtn = new Button();
			vipBtn.styleProvider = null;
			vipBtn.x = 442 - 400;
			vipBtn.y = 5;
			addChild(vipBtn);
			
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
			
			moneyLable = new SLLabel;
			moneyLable.setSize(180,26);
			moneyLable.setLocation(198,72);
			moneyLable.textRendererProperties.textFormat =  StyleProvider.getTF(SystemColor.LIGHT_WHITE_TEXT,20, HtmlTransCenter.Arial());
			addChild(moneyLable);
			
			_infoBack = StyleProvider.commonRoundBack;
			_infoBack.width  = 480;
			_infoBack.height = 152;
			_infoBack.x = 15;
			_infoBack.y = 150;
			addChild(_infoBack);
			
			maxRound = new SLLabel();
			maxRound.setSize(240,30);
			maxRound.setLocation(20,156);
			maxRound.textRendererProperties.textFormat = StyleProvider.getTF(0x948aa6,22);
			addChild(maxRound);
			
			winRate = new SLLabel();
			winRate.setSize(280,30);
			winRate.setLocation(20,190);
			winRate.textRendererProperties.textFormat = StyleProvider.getTF(0x948aa6,22);
			addChild(winRate);
			
			maxHand = new SLLabel();
			maxHand.setSize(280,30);
			maxHand.setLocation(20,230);
			maxHand.textRendererProperties.textFormat = StyleProvider.getTF(0x948aa6,22);
			addChild(maxHand);
			
			maxChip = new SLLabel();
			maxChip.setSize(280,30);
			maxChip.setLocation(270,156);
			maxChip.textRendererProperties.textFormat = StyleProvider.getTF(0x948aa6,22);
			addChild(maxChip);
			
			maxWin = new SLLabel();
			maxWin.setSize(280,30);
			maxWin.setLocation(270,190);
			maxWin.textRendererProperties.textFormat = StyleProvider.getTF(0x948aa6,22);
			addChild(maxWin);
			
			maxHandList = new List();
			maxHandList.setSize(300,86);
			maxHandList.itemRendererType = BestCardListItem;
			maxHandList.itemRendererProperties.width = 58;
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.gap = 5;
			maxHandList.layout = layout;
			maxHandList.x = 20;
			maxHandList.y = 260;
			addChild(maxHandList);
			maxHandList.scale = .5;
			
			addFriend = new Button();
			addFriend.x = 514;
			addFriend.y = 155;
			addChild(addFriend);
			
			atFriend = new Button();
			atFriend.x = 514;
			atFriend.y = 248;
			atFriend.label = LangManager.getText('500230');
			addChild(atFriend);
		}
		
		override public function show(...rests):void
		{
			super.show(rests);
			userId = rests[0];
			seat = rests[1];
		}
	}
}