package com.jzgame.view.windows.safeBox
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindow;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.TextInput;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class PopUpSafeBoxLoginWindow extends PopUpWindow
	{
		/***********
		 * name:    PopUpSafeBoxLoginWindow
		 * data:    Jan 5, 2016
		 * author:  jim
		 * des:     保险箱密码登录界面
		 ***********/
		protected var _back:Scale9Image;
		protected var _titleBack:Image;
		protected var _title:Image;
		protected var _inputBack:Scale9Image;
		protected var _sure:Button;
		protected var _findPass:Button;
		protected var _textInput:TextInput;
		protected var _textTip:SLLabel;
		public function PopUpSafeBoxLoginWindow()
		{
			super();
			_isSole = false;
			this.name = WindowFactory.SAFE_BOX_LOGIN_WINDOW;
			init();
		}
		
		private function init():void
		{
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup")
				,new Rectangle(20,20,1,1));
			_back = new Scale9Image(s9);
			_back.width  = 622;
			_back.height = 460;
			addChild(_back);
			
			_titleBack = new Image(ResManager.defaultAssets.getTexture('details_bg_title'));
			addChild(_titleBack);
			
			_title = new Image(ResManager.defaultAssets.getTexture('details_txt_savebox'));
			_title.x = 10;
			_title.y = 10;
			addChild(_title);
			
			_inputBack = StyleProvider.commonWhiteRoundBack;
			_inputBack.x = 47;
			_inputBack.y = 74;
			_inputBack.width  = 523;
			_inputBack.height = 247;
			addChild(_inputBack);
			
			_sure = new Button();
			_sure.x = 234;
			_sure.y = 360;
			addChild(_sure);
			_sure.label = LangManager.getText('500243');
			_sure.defaultLabelProperties.textFormat = StyleProvider.getTF(0x100f17,24);
			
			setClose(_sure);
			
			_textInput = new TextInput;
			_textInput.x = 246;
			_textInput.y = 118;
			_textInput.width = 254;
			_textInput.height = 57;
			_textInput.textEditorProperties.fontSize = 40;
			_textInput.textEditorProperties.color = 0x333333;
			_textInput.displayAsPassword = true;
//			_textInput.text = "Hello World";
//			_textInput.prompt = "Password";
			_textInput.paddingLeft = 20;
			_textInput.paddingTop = 5;
			_textInput.maxChars = 20;
			//限制输入字符
			_textInput.restrict = "0-9";
			addChild(_textInput);
			_textInput.backgroundSkin = new Scale9Image( new Scale9Textures((ResManager.defaultAssets.getTexture('s9_details_bg_shurukuang')),new Rectangle(20,15,1,1)) );
			
			_findPass = new Button();
			_findPass.styleProvider = null;
			_findPass.defaultSkin = new Image(ResManager.defaultAssets.getTexture('details_btn_password1'));
			_findPass.downSkin = new Image(ResManager.defaultAssets.getTexture('details_btn_password2'));
			_findPass.x = 353;
			_findPass.y = 222;
			_findPass.label = LangManager.getText('402353');
			_findPass.defaultLabelProperties.textFormat = StyleProvider.getTF(0xc5e4ea,22,"",'center',true);
			addChild(_findPass);
			
			_textTip = new SLLabel();
			_textTip.text = LangManager.getText('402348');
			_textTip.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,20);
			_textTip.setLocation(104,135);
			addChild(_textTip);
			
			_sure.addEventListener(Event.TRIGGERED, login);
		}
		
		override public function show(...rests):void
		{
			super.show(rests);
			
			_textInput.setFocus();
		}
		
		private function login(e:Event):void
		{
			HttpSendProxy.sendSafeBoxLoginInRequest(_textInput.text);
//			this.closeWindow();
		}
		
		override public function dispose():void
		{
			super.dispose();
			_sure.removeEventListener(Event.TRIGGERED, login);
		}
	}
}