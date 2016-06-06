package com.jzgame.view.windows.rounds
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.modules.table.PokerItemView;
	import com.jzgame.util.CardInfoUtil;
	import com.jzgame.vo.PreRoundInfoVO;
	import com.jzgame.vo.PreRoundPlayerInfoVO;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	import com.spellife.util.TimerManager;
	import com.starling.theme.StyleProvider;
	
	import flash.text.TextFormatAlign;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	public class RoundListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    RoundListItem
		 * data:    Dec 14, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale3Image;
		private var _index:SLLabel;
		private var _time:SLLabel;
		private var _result:SLLabel;
		private var _timeBack:Scale3Image;
		private var _poker1:PokerItemView;
		private var _poker2:PokerItemView;
		public function RoundListItem()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			hasLabelTextRenderer = false;
				
			_back = new Scale3Image(new Scale3Textures(ResManager.defaultAssets.getTexture('s9_recording_bg_review'),40,10));
			addChild(_back);
			_back.width = 644;
			
			_index = new SLLabel();
			_index.setLocation(100,8);
			_index.setSize(140,30);
			_index.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(_index);
			
			_poker1 = new PokerItemView;
			_poker1.y = -5;
			addChild(_poker1);
			_poker2 = new PokerItemView;
			_poker2.x = 60;
			_poker2.y = 63;
			_poker2.pivotX = 50;
			_poker2.pivotY = 60;
			_poker2.rotation = Math.PI * 15 / 180;
			addChild(_poker2);
			
			_timeBack = new Scale3Image(new Scale3Textures(ResManager.defaultAssets.getTexture('s9_recording_bg_time'),20,3));
			_timeBack.width = 75;
			_timeBack.y = 54;
			addChild(_timeBack);
			
			_time = new SLLabel();
			_time.setLocation(0,56);
			_time.setSize(75,30);
			_time.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,16,'',TextFormatAlign.CENTER);
			addChild(_time);
			
			_result = new SLLabel();
			_result.setLocation(445,15);
			_result.setSize(175,30);
			_result.textRendererProperties.isHTML = true;
			_result.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,16);
			addChild(_result);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!value)return;
			var vo:PreRoundInfoVO = value  as PreRoundInfoVO;
			_time.text = TimerManager.getSpeDes(vo.date);
			
			var myVo:PreRoundPlayerInfoVO = vo.myRoundInfo;
			_poker1.setData(CardInfoUtil.praseCardInfo(myVo.card[0]));
			_poker2.setData(CardInfoUtil.praseCardInfo(myVo.card[1]));
			
			var last:Number = (myVo.win);
			if(last >= 0)
			{
				_result.text = LangManager.getText('500225') + HtmlTransCenter.getFontStr("+" + last,'19932a',18);
			}else
			{
				_result.text = LangManager.getText('500225') + HtmlTransCenter.getFontStr("" + last,'d41313',18);
			}
		}
		
		override public function set index(value:int):void
		{
			super.index = value;
			
			_index.text = LangManager.getText("500224",value + 1);
		}
	}
}