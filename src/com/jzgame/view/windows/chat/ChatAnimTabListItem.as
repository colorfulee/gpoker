package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.ResManager;
	import com.starling.theme.StyleProvider;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Image;
	
	public class ChatAnimTabListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    ChatAnimTabListItem
		 * data:    Jan 12, 2016
		 * author:  jim
		 * des:
		 ***********/
		public function ChatAnimTabListItem()
		{
			super();
			
			defaultLabelProperties.textFormat = StyleProvider.getTF(0x413e4f,18);
			selectedUpLabelProperties.textFormat = StyleProvider.getTF(0x7b7ba8,18);
			selectedHoverLabelProperties.textFormat = StyleProvider.getTF(0x7b7ba8,18);
		}
		
		override public function set index(value:int):void
		{
			super.index = value;
			
			switch(value)
			{
				case 0:
					this.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_lable_normal1'));
					this.selectedUpSkin = new Image(ResManager.defaultAssets.getTexture('table_lable_normal2'));
					this.selectedHoverSkin = new Image(ResManager.defaultAssets.getTexture('table_lable_normal2'));
					break;
				case 1:
					this.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_lable_normal1'));
					this.defaultSkin.scaleX = -1;
					this.defaultSkin.pivotX = 123;
					this.selectedUpSkin = new Image(ResManager.defaultAssets.getTexture('table_lable_normal2'));
					this.selectedUpSkin.scaleX = -1;
					this.selectedUpSkin.pivotX = 123;
					this.selectedHoverSkin = new Image(ResManager.defaultAssets.getTexture('table_lable_normal2'));
					this.selectedHoverSkin.scaleX = -1;
					this.selectedHoverSkin.pivotX = 123;
					break;
			}
		}
	}
}