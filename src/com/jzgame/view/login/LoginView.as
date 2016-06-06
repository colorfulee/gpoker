package com.jzgame.view.login
{
	import com.spellife.display.ASFButton;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class LoginView extends Sprite
	{
		/***********
		 * name:    LoginView
		 * data:    Nov 30, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _userId:TextField = new TextField;
		public var submit:ASFButton;
		public function LoginView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			this.graphics.beginFill(0x999999);
			this.graphics.drawRect(0,0,300,500);
			this.graphics.endFill();
			
			_userId = new TextField();
			_userId.type = TextFieldType.INPUT;
			_userId.width = 200;
			_userId.height = 50;
			_userId.border = true;
			_userId.restrict = "0-9";
			var tf:TextFormat = new TextFormat;
			tf.color = 0xffffff;
			tf.align = TextFormatAlign.CENTER;
			tf.font = "Arial";
			tf.size = 30;
			_userId.defaultTextFormat = tf;
			addChild(_userId);
			_userId.x = 50;
			_userId.y = 250;
			
			submit = new ASFButton("login" ,null);
//			btn.decoration = def.deco;
			submit.handler = login;
			submit.y = 350;
			submit.x = 150;
			addChild( submit );
		}
		
		public function get userId():String
		{
			return _userId.text;
		}
		
		private function login(e:MouseEvent):void
		{
			trace("1");
		}
	}
}