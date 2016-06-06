package com.jzgame.view.windows
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindow;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.events.Event;
	
	public class LessChipWindow extends PopUpWindow
	{
		/*auther     :jim
		* file       :LessChipWindow.as
		* date       :Apr 15, 2015
		* description:金钱不足弹窗
		*/
		//最底下背景图片
		private var _back:Scale9Image;
		private var _normalBg:Bitmap;
		private var _title:Label;
		
//		private var _exBit:Bitmap = new Bitmap;
		private var _text:Label;
		private var _callBack:Function;
		private var _confirm:Button;
		private var _cancel:Button;
		public function LessChipWindow()
		{
			super();
			_isSole = false;
			isStageTouchEnable = false;
			mName = WindowFactory.LESS_CHIP_WINDOW;
			init();
		}
		
		private function init():void
		{
			var rect:Rectangle = new Rectangle(26,26,1,1);
			var scaleBack:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup"),rect);
			_back = new Scale9Image(scaleBack);
			_back.width  = 531;
			_back.height = 328;
			addChild(_back);
			
			_title = new Label;
			_title.textRendererProperties.isHTML = true;
			_title.y = 18;
			_title.setSize(531,50);
			_title.text = HtmlTransCenter.getHtmlStr(
				LangManager.getText("202301"),"b3a7db",26,HtmlTransCenter.Arial(),
				TextFormatAlign.CENTER);
			addChild(_title);
			
			_text = new Label;
			_text.y = 130;
			_text.textRendererProperties.textFormat = StyleProvider.getTF(0xb3a7db,20,"",TextFormatAlign.CENTER);
			_text.setSize(531,80);
			addChild(_text);
			_text.text = LangManager.getText("202302");
			
			_confirm = new Button
			_confirm.x = 328;
			_confirm.y = 248;
			_confirm.label = LangManager.getText("202303");
			addChild(_confirm);
			
			_cancel = new Button;
			_cancel.x = 80;
			_cancel.y = 248;
			_cancel.label = LangManager.getText("202304");
			setClose(_cancel);
			addChild(_cancel);
			
			_confirm.addEventListener(Event.TRIGGERED, confirmHandler);
		}
		
		override public function show(...rests):void
		{
			super.show(rests);
			
			_callBack = rests[0];
		}
		
		/**
		 * 点击确定 
		 * @param e
		 * 
		 */		
		private function confirmHandler(e:Event):void
		{
			if(_callBack != null)
			{
				_callBack.apply();
			}
			
			this.closeWindow();
		}
		
		/**
		 * 关闭 
		 * 
		 */		
		override protected function initHide():void
		{
			_confirm.removeEventListener(MouseEvent.CLICK, confirmHandler);
			_back.dispose();
			_confirm.dispose();
//			_cancel.dispose();
			_callBack = null;
//			DisplayManager.disposeBitmap(_exBit);
			DisplayManager.clearItemStage(this);
		}
	}
}