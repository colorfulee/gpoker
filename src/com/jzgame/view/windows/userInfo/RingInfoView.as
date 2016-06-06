package com.jzgame.view.windows.userInfo
{
	import com.jzgame.common.utils.LangManager;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import feathers.controls.List;
	import feathers.layout.HorizontalLayout;
	
	import starling.display.Sprite;

	public class RingInfoView extends Sprite
	{
		/***********
		 * name:    RingInfoView
		 * data:    Dec 7, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var max:SLLabel;
		public var maxWin:SLLabel;
		public var win:SLLabel;
		public var maxHand:SLLabel;
		public var maxHandList:List;
		public var winRate:SLLabel;
		public var champ:SLLabel;
		public var firstLogin:SLLabel;
		public var recentLogin:SLLabel;
		public var friends:SLLabel;
		public function RingInfoView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			max = new SLLabel();
			max.setSize(280,30);
			max.setLocation(20,20);
			max.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(max);
			
			maxWin = new SLLabel();
			maxWin.setSize(280,30);
			maxWin.setLocation(20,68);
			maxWin.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(maxWin);
			
			win = new SLLabel();
			win.setSize(280,30);
			win.setLocation(20,115);
			win.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(win);
			
			maxHand = new SLLabel();
			maxHand.setSize(280,30);
			maxHand.setLocation(20,160);
			maxHand.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			maxHand.text = LangManager.getText("300839");
			addChild(maxHand);
			
			maxHandList = new List();
			maxHandList.setSize(300,86);
			maxHandList.itemRendererType = BestCardListItem;
			maxHandList.itemRendererProperties.width = 58;
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.gap = 2;
			maxHandList.layout = layout;
			maxHandList.x = 20;
			maxHandList.y = 190;
			addChild(maxHandList);
			
			winRate = new SLLabel();
			winRate.setSize(280,30);
			winRate.setLocation(330,20);
			winRate.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(winRate);
			
			champ = new SLLabel();
			champ.setSize(280,30);
			champ.setLocation(330,68);
			champ.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(champ);
			
			firstLogin = new SLLabel();
			firstLogin.setSize(280,30);
			firstLogin.setLocation(330,115);
			firstLogin.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(firstLogin);
			
			recentLogin = new SLLabel();
			recentLogin.setSize(280,30);
			recentLogin.setLocation(330,160);
			recentLogin.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(recentLogin);
			
			friends = new SLLabel();
			friends.setSize(280,30);
			friends.setLocation(330,210);
			friends.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(friends);
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			max = null;
			maxWin = null;
			win = null;
			maxHand = null;
			winRate = null;
			champ = null;
			firstLogin = null;
			recentLogin = null;
			friends = null;
		}
	}
}