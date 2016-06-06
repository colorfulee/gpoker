package com.starling.view
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.theme.MobileTheme;
	import com.starling.theme.StyleProvider;
	
	import flash.text.TextFormat;
	
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.data.ListCollection;
	import feathers.themes.StyleNameFunctionTheme;
	
	import lzm.starling.swf.Swf;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class StarlingGame extends Sprite
	{
		/*auther     :jim
		* fileStarlingMainlingMain.as
		* date       :Sep 15, 2014
		* description:
		*/
		protected var theme:StyleNameFunctionTheme;
		public var pop:Sprite = new Sprite;
		//提示层级
		public var tips:Sprite = new Sprite;
		public var container:Sprite = new Sprite;
		private var _btn:starling.display.Button
		public function StarlingGame()
		{
			super();
			Swf.init(this);
		}
		
		public function onAdded(e:Event=null):void 
		{
			//根据scale 缩放
			this.scale = ReleaseUtil.SCALEX;
//			var frameCount:int = 0;
//			var totalTime:Number = 0;
//			addEventListener(Event.ENTER_FRAME, function(event:EnterFrameEvent):void
//			{
//				totalTime += event.passedTime;
//				if (++frameCount % 60 == 0)
//				{
//					trace("fps: " + frameCount / totalTime);
//					frameCount = totalTime = 0;
//				}
//			});
			new StyleProvider();
			this.theme  =  new MobileTheme();
			addChild(container);
			addChild(pop);
			addChild(tips);
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			return ;
			Alert.show("its a test!","haha",new ListCollection(
				[
					{ label: "OK", triggered: bt },{ label: "CANCEL", triggered: bt }
				]) );
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				return new TextFieldTextRenderer();
			};
//			Texture.fromBitmap();
			var text:TextField = new TextField(400,300,"this is a test!");
			text.border = true;
			addChild(text);
			// set Starling feathers theme 
			this.theme = new StyleNameFunctionTheme();
//			_upgradeTowerBtn = new Button(Assets.ta.getTexture('upgradeTowerBtn'));
//			_upgradeTowerBtn.x = 580;
//			_upgradeTowerBtn.y = 520;
//			_canvas.addChild(_upgradeTowerBtn);
			var tx:Texture = ResManager.defaultAssets.getTexture("lobby_btn_mission1");
			var tx2:Texture = ResManager.defaultAssets.getTexture("lobby_btn_mission2");
//			var testBtn:starling.display.Button = new starling.display.Button(tx);
//			addChild(testBtn);
			var but:Button = new Button();
			but.y = 100;
			but.defaultSkin = new Quad(200,100,0xcccccc);
			but.downSkin = new Image(tx2);
			var tf:TextFieldTextRenderer = new TextFieldTextRenderer;
			tf.textFormat = new TextFormat("Arial",16);
			but.styleProvider = StyleProvider.customButtonStyles;
			
			but.styleProvider = null;
			but.labelFactory = function():ITextRenderer
			{
				return new TextFieldTextRenderer();
			}
			but.defaultLabelProperties.textFormat = new TextFormat( "_sans", 36, 0xffffff );
//			but.defaultLabelProperties.textFormat  = tf;
//			tf.text = "check!";
//			but.defaultLabelProperties.textFormat  = new BitmapFontTextFormat("Wizzta");
			but.label = "click memmm!";
//			but.styleNameList.add();
			addChild(but);
			but.validate();
			but.x = (this.stage.stageWidth - but.width ) *0.5;
			but.addEventListener(Event.TRIGGERED, bt);
			var label:Label = new Label();
			label.text = "Hi, I'm Feathers!\nHave a nice day.";
//			Callout.show(label, but);
			// add starling-based component
			// to show that this one will not(!) be monitored by
			// the robotlegs-starling-viewMap lib
		}
		
		private function bt(e:Event):void
		{
			trace(e.type);
		}
	}
}