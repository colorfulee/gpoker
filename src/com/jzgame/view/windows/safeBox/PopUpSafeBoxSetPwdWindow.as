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
	
	public class PopUpSafeBoxSetPwdWindow extends PopUpWindow
	{
		/***********
		 * name:    PopUpSafeBoxLoginWindow
		 * data:    Jan 5, 2016
		 * author:  jim
		 * des:     保险箱密码登录界面
		 ***********/
		protected var _back:Scale9Image;
		protected var _titleBack:Image;
		protected var _inputBack:Scale9Image;
		protected var _sure:Button;
		protected var _title:Image;
		protected var _tip1:SLLabel;
		protected var _textInput:TextInput;
		protected var _tip2:SLLabel;
		protected var _textInput2:TextInput;
		protected var _topIcon:Image;
		protected var _centerIcon:Image;
		public function PopUpSafeBoxSetPwdWindow()
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
			
			_tip1 = new SLLabel();
			_tip1.text = LangManager.getText('402348');
			_tip1.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,20);
			_tip1.setLocation(104,135);
			addChild(_tip1);
			
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
			_textInput.restrict = "a-zA-Z0-9";
			addChild(_textInput);
			_textInput.backgroundSkin = new Scale9Image( new Scale9Textures((ResManager.defaultAssets.getTexture('s9_details_bg_shurukuang')),new Rectangle(20,15,1,1)) );
			
			_tip2 = new SLLabel();
			_tip2.text = LangManager.getText('402349');
			_tip2.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,20);
			_tip2.setLocation(104,241);
			addChild(_tip2);
			
			_textInput2 = new TextInput;
			_textInput2.x = 246;
			_textInput2.y = 228;
			_textInput2.width = 254;
			_textInput2.height = 57;
			_textInput2.textEditorProperties.fontSize = 40;
			_textInput2.textEditorProperties.color = 0x333333;
			_textInput2.displayAsPassword = true;
//			_textInput.text = "Hello World";
//			_textInput.prompt = "Password";
			_textInput2.paddingLeft = 20;
			_textInput2.paddingTop = 5;
			_textInput2.maxChars = 20;
			//限制输入字符
			_textInput2.restrict = "a-zA-Z0-9";
			addChild(_textInput2);
			_textInput2.backgroundSkin = new Scale9Image( new Scale9Textures((ResManager.defaultAssets.getTexture('s9_details_bg_shurukuang')),new Rectangle(20,15,1,1)) );
			

			_topIcon = new Image(ResManager.defaultAssets.getTexture('details_icon_right'));
			_topIcon.x = 508;
			_topIcon.y = 128;
			_topIcon.visible = false;
			_centerIcon = new Image(ResManager.defaultAssets.getTexture('details_icon_right'));
			_centerIcon.x = 508;
			_centerIcon.y = 235;
			_centerIcon.visible = false;
			addChild(_centerIcon);
			addChild(_topIcon);
			_sure.addEventListener(Event.TRIGGERED, setPwd);
		}
		
		private function setPwd(e:Event):void
		{
			_topIcon.visible = true;
			_centerIcon.visible = true;
			if(_textInput.text.length < 6)
			{
				_topIcon.texture = ResManager.defaultAssets.getTexture("details_icon_wrong");
				return;
			}else
			{
				_topIcon.texture = ResManager.defaultAssets.getTexture("details_icon_right");
			}
			
			if(_textInput2.text.length < 6)
			{
				_centerIcon.texture = ResManager.defaultAssets.getTexture("details_icon_wrong");
				return;
			}
			
			if(_textInput.text == _textInput2.text)
			{
				_topIcon.texture = ResManager.defaultAssets.getTexture("details_icon_right");
				_centerIcon.texture = ResManager.defaultAssets.getTexture("details_icon_right");
				
				this.closeWindow();
				
				HttpSendProxy.sendSafeBoxSetPasswardRequest(_textInput.text);
			}else
			{
				_topIcon.texture = ResManager.defaultAssets.getTexture("details_icon_right");
				_centerIcon.texture = ResManager.defaultAssets.getTexture("details_icon_wrong");
			}
//			this.closeWindow();
		}
		
		override public function dispose():void
		{
			super.dispose();
			_sure.removeEventListener(Event.TRIGGERED, setPwd);
		}
	}
}