package com.jzgame.view.display
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.view.windows.tips.UserExpTipView;
	import com.spellife.display.ProgressBar;
	import com.spellife.display.SLLabel;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class ExpSmallInfoView extends Sprite
	{
		/*auther     :jim
		* file       :ExpSmallInfoView.as
		* date       :Apr 29, 2015
		* description:桌子内部经验条
		*/
		//等级
		public var lv:SLLabel;
		//经验
		public var experience:SLLabel;
		//经验条
		public var expProgress:ProgressBar;
		private var _rightImage:Bitmap = new Bitmap;
		private var _expTip:UserExpTipView;
		
		private var _delay:Number = 0;
		public function ExpSmallInfoView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			expProgress = new ProgressBar;
			expProgress.type = ProgressBar.MOVE_MASK;
			expProgress.setProgressImage(ResManager.getBitmapDataByName("20000_userTipLittleProgress"));
			expProgress.setProgressBgImage(ResManager.getBitmapDataByName("20000_userTipLittleBg"));
			expProgress.setBarRect(new Rectangle(0,0,192,19));
			addChild(expProgress);
			_rightImage.bitmapData = ResManager.getBitmapDataByName("20000_userTipLittleBgEx");
			_rightImage.x = 192 + 10;
			_rightImage.y = 3;
			_rightImage.scaleX = -1;
			addChild(_rightImage);
			lv = new SLLabel;
			lv.x = 5;
			lv.y = -1;
			lv.setSize(100,25);
			lv.text = "lv:20";
			addChild(lv);
			
			experience = new SLLabel;
			experience.x = 75;
			experience.y = -1;
			experience.setSize(100,25);
			experience.text = "30/100";
			addChild(experience);
			
			
			this.addEventListener(MouseEvent.ROLL_OVER,showTip);
			this.addEventListener(MouseEvent.ROLL_OUT,hideTip);
		}
		
		private function showTip(e:MouseEvent):void
		{
			_delay = setTimeout(show,500);
		}
		
		private function show():void
		{
			_expTip = new UserExpTipView;
			_expTip.y = experience.y + 20;;
			var p:Point = this.localToGlobal(new Point(0,_expTip.y));
			
			var centerX:Number = (p.x + _expTip.width) - stage.stageWidth;
			if(centerX > 0)
			{
				_expTip.x -= centerX ;
			}
			if(p.x < 0 )
			{
				_expTip.x -= p.x;
			}
			
			
			addChild(_expTip);
		}
		
		private function hideTip(e:MouseEvent):void
		{
			clearTimeout(_delay);
			
			if(_expTip && _expTip.parent)
			{
				_expTip.parent.removeChild(_expTip);
			}
		}
		/**
		 * 销毁 
		 * 
		 */		
		public function dispose():void
		{
			this.removeEventListener(MouseEvent.ROLL_OVER,showTip);
			this.removeEventListener(MouseEvent.ROLL_OUT,hideTip);
			
			DisplayManager.disposeBitmap(_rightImage);
			DisplayManager.clearItemStage(this);
		}
	}
}