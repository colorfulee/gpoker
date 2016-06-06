package com.jzgame.modules.friends
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class FriendsInfoView extends Sprite
	{
		/***********
		 * name:    FriendsInfoView
		 * data:    Nov 16, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Image;
		public var invite:Button;
		public function FriendsInfoView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			invite = new Button;
			invite.styleProvider = null;
			invite.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_addfriend1"));
			invite.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_addfriend2"));
			addChild(invite);
			
			invite.labelFactory = function():ITextRenderer
			{
				return new TextFieldTextRenderer();
			}
				
			var tf:TextFormat = StyleProvider.getTF(0xb3a7db,16,HtmlTransCenter.Arial());
			tf.bold = true;
			invite.defaultLabelProperties.textFormat = tf;
			
			invite.label = LangManager.getText("500002");
		}
	}
}