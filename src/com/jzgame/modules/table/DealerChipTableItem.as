package com.jzgame.modules.table
{
	import com.jzgame.common.utils.ResManager;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import feathers.controls.Label;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.display.Sprite;
	
	public class DealerChipTableItem extends Sprite
	{
		/***********
		 * name:    DealerChipTableItem
		 * data:    Nov 19, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale3Image;
		private var _text:Label;
		public function DealerChipTableItem()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			var s3:Scale3Textures = new Scale3Textures(ResManager.tableAssets.getTexture("s9_table_bg_mychips"),20,5);
			_back = new Scale3Image(s3);
			_back.width = 100;
			addChild(_back);
			
			_text = new Label();
			_text.width = 100;
			_text.textRendererProperties.textFormat = new TextFormat(HtmlTransCenter.Arial(),18,0xcacaca);
			_text.textRendererProperties.textFormat.align = TextFieldAutoSize.CENTER;
			addChild(_text);
		}
		
		/**
		 * 设置筹码数 
		 * @param v
		 * 
		 */		
		public function set num(v:Number):void
		{
			_text.text = v.toString();
			//			_text.width = _text.
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			_back.dispose();
		}
	}
}