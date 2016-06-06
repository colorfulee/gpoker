package com.jzgame.modules.table
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.ResManager;
	import com.starling.theme.StyleProvider;
	
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class CardTypeView extends Sprite
	{
		/***********
		 * name:    CardTypeView
		 * data:    Nov 23, 2015
		 * author:  jim
		 * des:     牌型
		 ***********/
		private var _progress:ProgressBar;
		private var _label:Label;
		public function CardTypeView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_progress = new ProgressBar();
			_progress.styleProvider = null;
			_progress.backgroundSkin = new Image(ResManager.tableAssets.getTexture("table_bg_cardtype1"));
			
			var fillSkin:Scale3Image = new Scale3Image( new Scale3Textures(ResManager.tableAssets.getTexture("table_bg_cardtype2"),10,10) );
			fillSkin.width = 0;
			_progress.fillSkin = fillSkin;
			addChild(_progress);
			
			
			_progress.minimum = 0;
			_progress.maximum = 100;
			_label = new Label();
			_label.width = 108;
			_label.textRendererProperties.textFormat = StyleProvider.getTF(0xffffff,18,'',TextFormatAlign.CENTER);
			addChild(_label);
		}
		/**
		 * 设置牌型名称 
		 * @param t
		 */		
		public function setText(t:String):void
		{
			_label.text = t;
		}
		/**
		 * 设置牌型 
		 * @param v
		 */		
		public function setProgress(v:Number):void
		{
			_progress.value = v;
		}
		
		/**
		 * 重置 
		 * 
		 */		
		public function reset():void
		{
			setProgress(0);
			setText("");
		}
		
		override public function dispose():void
		{
			super.dispose();
			_progress.dispose();
			DisplayManager.clearItemStage(this);
		}
	}
}