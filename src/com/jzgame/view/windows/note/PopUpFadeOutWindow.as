package com.jzgame.view.windows.note
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.effects.FadeOutWindowEffect;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindow;
	import com.spellife.util.HtmlTransCenter;
	import com.spellife.util.RealGameTimer;
	
	import flash.events.TimerEvent;
	
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.display.Shape;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	
	public class PopUpFadeOutWindow extends PopUpWindow
	{
		/***********
		 * name:    PopUpFadeOutWindow
		 * data:    Jan 5, 2016
		 * author:  jim
		 * des:
		 ***********/
		protected var _alpha:Shape;
		protected var _back:Scale3Image;
		protected var _text:TextField;
		private var _timer:RealGameTimer;
		public function PopUpFadeOutWindow()
		{
			super();
			
			this.name = WindowFactory.FADE_TIP_WINDOW;
			
			_isModal = false;
			_isSole = false;
			_isStageTouchEnable = false;
			_motionEffect = new FadeOutWindowEffect();
			
			init();
		}
		
		private function init():void
		{
			_alpha = new Shape();
			_alpha.visible = false;
			_alpha.graphics.beginFill(0);
			_alpha.graphics.drawRect(0,0,ReleaseUtil.STAGE_WIDTH,10);
			_alpha.graphics.endFill();
			addChild(_alpha);
			
			_back = new Scale3Image(new Scale3Textures(ResManager.defaultAssets.getTexture('s9_table_bg_tips1'),20,10));
			addChild(_back);
			
			_text = new TextField(100,30,"",HtmlTransCenter.Arial(),24,0xf6a530,true);
			_text.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			addChild(_text);
			
			_timer = new RealGameTimer(3000);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
		}
		
		override public function show(...rests):void
		{
			super.show(rests);
			
			_text.text = rests[0];
			_text.y = 3;
			_text.x = Math.floor((ReleaseUtil.STAGE_WIDTH - _text.width) * 0.5);
			_back.width = _text.width + 50;
			_back.x = Math.floor((ReleaseUtil.STAGE_WIDTH - _back.width) * 0.5);
			_timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			
			this.closeWindow();
		}
		
		override public function dispose():void
		{
			super.dispose();
			_timer.removeEventListener(TimerEvent.TIMER,timerHandler);
		}
	}
}