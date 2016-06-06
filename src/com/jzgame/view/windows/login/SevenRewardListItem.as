package com.jzgame.view.windows.login
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.util.ItemStringUtil;
	import com.spellife.feathers.SLImageLoader;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.TimerManager;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	public class SevenRewardListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    SevenLoginBonusListItem
		 * data:    Jul 23, 2015
		 * author:  jim
		 * des:     奖励
		 ***********/
		
		private var _image:SLImageLoader;
		private var _text:SLLabel = new SLLabel;
		public function SevenRewardListItem()
		{
			super();
			
			hasLabelTextRenderer = false;
			
			init();
		}
		
		private function init():void
		{
			_image = new SLImageLoader(new Rectangle(30 + 18,30 + 48,90));
			addChild(_image);
			
			_text = new SLLabel();
			_text.setSize(130,30);
			_text.setLocation(0,112);
			_text.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,20,"",TextFormatAlign.CENTER);
			addChild(_text);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!value)return;
			var id:String = data.bonus[0].split(AssetsCenter.COLON)[0];
			var num:String = data.bonus[0].split(AssetsCenter.COLON)[1];
			_text.text = ItemStringUtil.getItemDes(id,num);
			_image.source = AssetsCenter.getImagePath(ItemStringUtil.getItemImage(id));
			var current:String = TimerManager.getSysWeekDay();
			
			_image.visible = true;
		}
	}
}