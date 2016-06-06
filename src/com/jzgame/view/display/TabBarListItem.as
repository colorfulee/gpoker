package com.jzgame.view.display
{
	import com.jzgame.common.utils.ResManager;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.text.TextFormatAlign;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Image;
	import starling.filters.BlurFilter;
	
	public class TabBarListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    TabBarListItem
		 * data:    Dec 4, 2015
		 * author:  jim
		 * des:
		 ***********/
		public function TabBarListItem()
		{
			super();
		}
		
		override protected function initialize():void
		{
			styleProvider = null;
			
			this.defaultSkin = new Image(ResManager.defaultAssets.getTexture("common_able_buy1"));
			this.downSkin = new Image(ResManager.defaultAssets.getTexture("common_lable_buy2"));
			this.defaultSelectedSkin = new Image(ResManager.defaultAssets.getTexture("common_lable_buy2"));
		}
		
		override public function set isSelected(value:Boolean):void
		{
			super.isSelected = value;
			
			if(value)
			{
				this.defaultLabelProperties.textFormat = StyleProvider.getTF(0xcff4ff,26,HtmlTransCenter.Arial(),TextFormatAlign.CENTER);
				this.defaultLabelProperties.filter = BlurFilter.createGlow(0x2a5d92,1,2); 
			}else
			{
				this.defaultLabelProperties.filter = null; 
				this.defaultLabelProperties.textFormat = StyleProvider.getTF(0x777a9d,26,HtmlTransCenter.Arial(),TextFormatAlign.CENTER);
			}
		}
	}
}