package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.ResManager;
	
	import feathers.controls.Button;
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Image;
	
	public class ChatDetailTabListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    ChatDetailTabListItem
		 * data:    Jan 11, 2016
		 * author:  jim
		 * des:
		 ***********/
		public function ChatDetailTabListItem()
		{
			super();
			
			hasLabelTextRenderer = false;
		}
		
		override protected function initialize():void
		{
			styleProvider = null;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			if(!value)return;
		}
		
		override public function set index(value:int):void
		{
			super.index = value;
			
			switch(index+1)
			{
				case 1:
					this.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_expression1'));
					this.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_expression2'));
					this.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_expression1'));
					this.selectedUpIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_expression2'));
					this.selectedUpSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_expression2'));
					this.selectedHoverIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_expression2'));
					this.selectedHoverSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_expression2'));
					break;
				case 2:
					this.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_history1'));
					this.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_history2'));
					this.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_shortcut1'));
					this.selectedUpIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_shortcut2'));
					this.selectedUpSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_expression2'));
					this.selectedHoverIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_shortcut2'));
					this.selectedHoverSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_expression2'));
					break;
				case 3:
					this.defaultSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_expression1'));
					this.downSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_expression2'));
					this.selectedUpIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_history2'));
					this.defaultIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_history1'));
					this.selectedUpSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_expression2'));
					this.selectedHoverIcon = new Image(ResManager.defaultAssets.getTexture('table_icon_history2'));
					this.selectedHoverSkin = new Image(ResManager.defaultAssets.getTexture('table_btn_expression2'));
					break;
			}
		}
	}
}