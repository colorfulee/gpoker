package com.jzgame.view.windows.setting
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.windows.PopUpDefaultWindow;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import feathers.controls.Button;
	import feathers.controls.ToggleSwitch;
	import feathers.display.Scale9Image;
	
	import starling.display.Image;
	import starling.display.Shape;
	
	public class PopUpGameSettingWindow extends PopUpDefaultWindow
	{
		/***********
		 * name:    PopUpGameSettingWindow
		 * data:    Dec 10, 2015
		 * author:  jim
		 * des:
		 ***********/
		protected var _title:Image;
		private var _count:SLLabel;
		private var _countBack:Scale9Image;
		private var _countText:SLLabel;
		public var logout:Button;
		private var _setting:SLLabel;
		private var _settingBack:Scale9Image;
		private var _otherBack:Scale9Image;
		private var _line:Shape;
		private var _line2:Shape;
		private var _line3:Shape;
		public var musicToggle:ToggleSwitch;
		private var _music:SLLabel;
		public var effectToggle:ToggleSwitch;
		private var _effect:SLLabel;
		private var _other:SLLabel;
		
		private var _version:SLLabel;
		private var _versionLabel:SLLabel;
		public function PopUpGameSettingWindow()
		{
			super();
			
			mName = WindowFactory.GAME_SET_WINDOW;
		}
		
		override protected function init():void
		{
			super.init();
			
			_title = new Image(ResManager.defaultAssets.getTexture("setting_txt_title"));
			_title.x = 35;
			_title.y = 10;
			addChild(_title);

			_countBack = StyleProvider.commonRoundBack;
			_countBack.width = 892;
			_countBack.height = 60;
			_countBack.x = 24;
			_countBack.y = 120;
			addChild(_countBack);
			
			_count = new SLLabel();
			_count.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,24);
			_count.setLocation(26,84);
			_count.setSize(100,30);
			_count.text = LangManager.getText("500209");
			addChild(_count);
			
			_countText = new SLLabel();
			_countText.textRendererProperties.textFormat = StyleProvider.getTF(0xb3a7db,20);
			_countText.setLocation(32,130);
			_countText.setSize(100,30);
			_countText.text = LangManager.getText("500209");
			addChild(_countText);
			
			_setting = new SLLabel();
			_setting.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,24);
			_setting.setLocation(26,194);
			_setting.setSize(100,30);
			_setting.text = LangManager.getText("500209");
			addChild(_setting);
			
			_settingBack = StyleProvider.commonRoundBack;
			_settingBack.width = 892;
			_settingBack.height = 184;
			_settingBack.x = 24;
			_settingBack.y = 231;
			addChild(_settingBack);
			
			
			_line = new Shape;
			_line.graphics.beginFill(0x100f17,1);
			_line.graphics.drawRect(0,0,892,2);
			_line.graphics.endFill();
			_line.x = 24;
			_line.y = 296;
			addChild(_line);
			
			_line2 = new Shape;
			_line2.graphics.beginFill(0x100f17,1);
			_line2.graphics.drawRect(0,0,892,2);
			_line2.graphics.endFill();
			_line2.x = 24;
			_line2.y = 354;
			addChild(_line2);
			
			logout = new Button();
			logout.styleProvider = null;
			logout.defaultSkin = new Image(ResManager.defaultAssets.getTexture("setting_btn_logout1"));
			logout.downSkin = new Image(ResManager.defaultAssets.getTexture("setting_btn_logout2"));
			logout.defaultIcon = new Image(ResManager.defaultAssets.getTexture("setting_txt_logout1"));
			logout.downIcon = new Image(ResManager.defaultAssets.getTexture("setting_txt_logout2"));
			logout.x = 803;
			logout.y = 122;
			addChild(logout);
			
			_music = new SLLabel();
			_music.textRendererProperties.textFormat = StyleProvider.getTF(0xb3a7db,20);
			_music.setLocation(32,247);
			_music.setSize(100,30);
			_music.text = LangManager.getText("500210");
			addChild(_music);
			
			musicToggle = new ToggleSwitch();
			musicToggle.x = 803;
			musicToggle.y = 240;
			addChild(musicToggle);
			
			_effect = new SLLabel();
			_effect.textRendererProperties.textFormat = StyleProvider.getTF(0xb3a7db,20);
			_effect.setLocation(32,306);
			_effect.setSize(100,30);
			_effect.text = LangManager.getText("500211");
			addChild(_effect);
			
			effectToggle = new ToggleSwitch();
			effectToggle.x = 803;
			effectToggle.y = 305;
			addChild(effectToggle);
			
			_otherBack = StyleProvider.commonRoundBack;
			_otherBack.width = 892;
			_otherBack.height = 122;
			_otherBack.x = 24;
			_otherBack.y = 475;
			addChild(_otherBack);
			
			_line3 = new Shape;
			_line3.graphics.beginFill(0x100f17,1);
			_line3.graphics.drawRect(0,0,892,2);
			_line3.graphics.endFill();
			_line3.x = 24;
			_line3.y = 531;
			addChild(_line3);
			
			_other = new SLLabel();
			_other.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,24);
			_other.setLocation(26,431);
			_other.setSize(100,30);
			_other.text = LangManager.getText("500212");
			addChild(_other);
			
			_version = new SLLabel();
			_version.textRendererProperties.textFormat = StyleProvider.getTF(0xb3a7db,20);
			_version.setLocation(32,546);
			_version.setSize(100,30);
			_version.text = LangManager.getText("500213");
			addChild(_version);
			
			_versionLabel = new SLLabel();
			_versionLabel.textRendererProperties.textFormat = StyleProvider.getTF(0xb3a7db,20);
			_versionLabel.setLocation(823,546);
			_versionLabel.setSize(100,30);
			_versionLabel.text = 'V 0.0.1';
			addChild(_versionLabel);
		}
		
		public function setId(id:String):void
		{
			_countText.text = id;
		}
	}
}