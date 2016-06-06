package com.jzgame.view.windows.userInfo
{
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import starling.display.Sprite;
	
	public class MttInfoView extends Sprite
	{
		/***********
		 * name:    MttInfoView
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var time:SLLabel;
		public var champTime:SLLabel;
		public var lastTime:SLLabel;
		public var lastRank:SLLabel;
		public function MttInfoView()
		{
			super();
			
			init();
		}
		private function init():void
		{
			time = new SLLabel();
			time.setSize(380,30);
			time.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(time);
			time.x = 20;
			time.y = 24;
			
			champTime = new SLLabel();
			champTime.setSize(380,30);
			champTime.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(champTime);
			champTime.x = 20;
			champTime.y = 95;
			
			lastTime = new SLLabel();
			lastTime.setSize(380,30);
			lastTime.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(lastTime);
			lastTime.x = 20;
			lastTime.y = 165;
			
			lastRank = new SLLabel();
			lastRank.setSize(380,30);
			lastRank.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(lastRank);
			lastRank.x = 20;
			lastRank.y = 228;
		}
	}
}