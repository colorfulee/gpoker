package com.jzgame.modules.userInfo
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.AssetsName;
	import com.jzgame.enmu.SystemColor;
	import com.jzgame.view.display.FaceWithFrame;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import feathers.controls.Label;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class UserInfoView extends Sprite
	{
		/***********
		 * name:    UserInfoView
		 * data:    Nov 16, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _faceBg:Image;
		public var userName:Label;
		private var _glodIcon:Image;
		public var goldLable:SLLabel;
		private var _moneyIcon:Image;
		public var moneyLable:SLLabel;
		public var face:FaceWithFrame;
		public function UserInfoView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_faceBg = new Image(ResManager.defaultAssets.getTexture("lobby_bg_Personalinformation"));
			addChild(_faceBg);
			face = new FaceWithFrame();
			face.x = 5;
			face.y = 5;
			addChild(face);
			userName = new Label();
//			userName.styleProvider = null;
			userName.x = 135;
			userName.textRendererProperties.textFormat =  StyleProvider.getTF(SystemColor.LIGHT_ORANGE_TEXT,16, HtmlTransCenter.Arial());
			userName.text = "my name";
			addChild(userName);
			
			_moneyIcon = new Image(ResManager.defaultAssets.getTexture(AssetsName.ASSET_20000_CLIP_ICON));
			_moneyIcon.x = 125;
			_moneyIcon.y = 33;
			addChild(_moneyIcon);
			
			goldLable = new SLLabel;
//			goldLable.styleProvider = null;
			goldLable.setSize(180,26);
			goldLable.setLocation(151,64);
			goldLable.textRendererProperties.textFormat = StyleProvider.getTF(SystemColor.LIGHT_WHITE_TEXT,16, HtmlTransCenter.Arial());
			addChild(goldLable);
			
			_glodIcon = new Image(ResManager.defaultAssets.getTexture(AssetsName.ASSET_20000_GOLD_ICON));
			_glodIcon.x = 125;
			_glodIcon.y = 63;
			addChild(_glodIcon);
			
			moneyLable = new SLLabel;
//			moneyLable.styleProvider = null;
			moneyLable.setSize(180,26);
			moneyLable.setLocation(151,34);
			moneyLable.textRendererProperties.textFormat =  StyleProvider.getTF(SystemColor.LIGHT_WHITE_TEXT,16, HtmlTransCenter.Arial());
			addChild(moneyLable);
			
		}
		
		public function setFace(s:String):void
		{
			face.setData(s);
		}
	}
}