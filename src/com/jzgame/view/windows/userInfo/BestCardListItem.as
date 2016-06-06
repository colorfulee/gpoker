package com.jzgame.view.windows.userInfo
{
	import com.jzgame.modules.table.PokerItemView;
	import com.jzgame.util.CardInfoUtil;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	public class BestCardListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    BestCardListItem
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _poker:PokerItemView;
		public function BestCardListItem()
		{
			super();
			hasLabelTextRenderer = false;
			_poker = new PokerItemView;
			addChild(_poker);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!value)return;
			_poker.setData(CardInfoUtil.praseCardInfo(Number(value)));
		}
	}
}