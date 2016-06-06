package com.jzgame.view.display
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.view.windows.tips.UserExpTipView;
	import com.spellife.display.ProgressBar;
	import com.spellife.display.SLLabel;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	public class ExpInfoView extends Sprite
	{
		/*auther     :jim
		* file       :ExpInfoView.as
		* date       :Apr 3, 2015
		* description:经验条
		*/
		
		//等级
		public var lv:SLLabel;
		//经验
		public var experience:SLLabel;
		//经验条
		public var expProgress:ProgressBar;
		
		private var _expTip:UserExpTipView;
		private var _index:uint;
		public function ExpInfoView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			expProgress = new ProgressBar;
			expProgress.type = ProgressBar.MOVE_MASK;
			expProgress.setProgressImage(ResManager.getBitmapDataByName("20002_exp"));
			expProgress.setBarRect(new Rectangle(0,0,200,25));
			expProgress.value = .8;
			addChild(expProgress);
			
			lv = new SLLabel;
			lv.x = 5;
			lv.y = 1;
			lv.setSize(100,25);
			lv.text = "lv:20";
			addChild(lv);
			
			experience = new SLLabel;
			experience.x = 75;
			experience.y = 2;
			experience.setSize(100,25);
			experience.text = "30/100";
			addChild(experience);
			
			
			this.addEventListener(MouseEvent.ROLL_OVER,showTip);
			this.addEventListener(MouseEvent.ROLL_OUT,hideTip);
		}
		
		private function showTip(e:MouseEvent):void
		{
			_index = setTimeout(showTipHandler,500);
		}
		
		private function showTipHandler():void
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
			clearTimeout(_index);
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
			
			
			DisplayManager.clearItemStage(this);
		}
	}
}