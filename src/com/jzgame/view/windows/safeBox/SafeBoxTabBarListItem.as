package com.jzgame.view.windows.safeBox
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.text.TextFormatAlign;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Image;
	import starling.filters.BlurFilter;
	
	public class SafeBoxTabBarListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    SafeBoxTabBarListItem
		 * data:    Jan 6, 2016
		 * author:  jim
		 * des:
		 ***********/
		public function SafeBoxTabBarListItem()
		{
			super();
		}
		
		override public function set index(value:int):void
		{
			super.index = value;
			
			switch(value)
			{
				case 0:
					this.defaultSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save1-1'));
					this.downSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save1-2'));
					this.defaultSelectedSkin = new Image(ResManager.defaultAssets.getTexture("details_lable_save1-2"));
					this.defaultLabelProperties.textFormat = StyleProvider.getTF(0x777a9d,26);
					break;
				case 1:
					this.defaultSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save2-1'));
					this.downSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save2-2'));
					this.defaultSelectedSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save2-2'));
					this.defaultLabelProperties.textFormat = StyleProvider.getTF(0x777a9d,26);
					break;
				case 2:
					this.defaultSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save1-1'));
					this.downSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save1-2'));
					this.defaultSelectedSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save1-2'));
					this.defaultSkin.scaleX = -1;
					this.defaultSkin.pivotX = 206;
					this.defaultSelectedSkin.pivotX = 206;
					this.defaultSelectedSkin.scaleX = -1;
					this.defaultLabelProperties.textFormat = StyleProvider.getTF(0x777a9d,26);
					break;
			}
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
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