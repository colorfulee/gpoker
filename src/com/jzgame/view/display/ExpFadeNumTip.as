package com.jzgame.view.display
{
	import com.greensock.TweenMax;
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.enmu.SystemColor;
	import com.spellife.display.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.display.Sprite;
	
	public class ExpFadeNumTip extends Sprite
	{
		/*auther     :jim
		* file       :ExpFadeTipView.as
		* date       :May 22, 2015
		* description:
		*/
		private var _text:SLLabel = new SLLabel;
		public function ExpFadeNumTip()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_text.color = SystemColor.GREEN_TEXT;
			_text.font = HtmlTransCenter.Arial();
			_text.size = 16;
			_text.setTextBold(true);
			_text.setSize(100,30);
			addChild(_text);
		}
		
		public function show(num:Number):void
		{
			_text.text = "+"+num.toString()+ " EXP";
			TweenMax.to(this,2,{alpha:0.5,y:this.y - 50,onComplete:tipNumComplete});
		}
		
		private function tipNumComplete():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
				DisplayManager.clearItemStage(this);
			}
		}
	}
}