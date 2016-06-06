package com.jzgame.view.windows.task
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Image;
	import starling.filters.BlurFilter;
	
	public class TaskTitleItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    TaskTitleItem
		 * data:    Dec 1, 2015
		 * author:  jim
		 * des:     任务导航
		 ***********/
		protected var _desLabel:Label;
		public function TaskTitleItem()
		{
			super();
			
			hasLabelTextRenderer = false;
		}
		
		override protected function initialize():void
		{
			styleProvider = null;
			this.defaultSkin = new Image(ResManager.defaultAssets.getTexture("common_able_buy1"));
			this.downSkin = new Image(ResManager.defaultAssets.getTexture("common_lable_buy2"));
			this.defaultSelectedSkin = new Image(ResManager.defaultAssets.getTexture("common_lable_buy2"));
			
			_desLabel = new Label;
			_desLabel.width = 203;
			_desLabel.height = 30;
			_desLabel.textRendererProperties.textFormat = StyleProvider.getTF(0xcff4ff,26,HtmlTransCenter.Arial(),TextFormatAlign.CENTER);
			_desLabel.text = LangManager.getText("500101");
			_desLabel.filter = BlurFilter.createGlow(0x2a5d92,1,2); 
			addChild(_desLabel);
			DisplayManager.centerYByPoint(_desLabel,70);
		}
		
		override public function dispose():void
		{
			super.dispose();
			if(_desLabel)
			_desLabel.dispose();
			_desLabel = null;
			_data = null;
			_owner = null;
		}
	}
}