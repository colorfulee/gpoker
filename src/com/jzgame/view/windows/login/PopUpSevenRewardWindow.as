package com.jzgame.view.windows.login
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.vo.SevenLoginBonus;
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindow;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.HtmlTransCenter;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class PopUpSevenRewardWindow extends PopUpWindow
	{
		/***********
		 * name:    PopUpSevenRewardWindow
		 * data:    Jul 24, 2015
		 * author:  jim
		 * des:
		 ***********/
		//最底下背景图片
		private var _back:Scale9Image;
		private var _normalBg:Bitmap;
		private var _title:SLLabel;
		//半透明背景
		private var _list:List;
		private var sureBtn:Button;
		public function PopUpSevenRewardWindow()
		{
			super();
			_isSole = false;
			_modalVisible = true;
			init();
		}
		private function init():void
		{
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup")
				,new Rectangle(20,20,1,1));
			_back = new Scale9Image(s9);
			_back.x = 0;
			_back.y = 0;
			_back.width  = 400;
			_back.height = 380;
			addChild(_back);
			
			_title = new SLLabel;
			_title.y = 18;
			_title.setSize(400,50);
			_title.textRendererProperties.isHTML = true;
			_title.text = HtmlTransCenter.getBoldStr( HtmlTransCenter.getHtmlStr(LangManager.getText("500237"),'b3a7db',24,HtmlTransCenter.Arial(),TextFormatAlign.CENTER) );
			addChild(_title);
			
			_list = new List();
			_list.itemRendererType = SevenRewardListItem;
			_list.itemRendererProperties.width = 140;
			_list.itemRendererProperties.height = 140;
			_list.width = 376;
			_list.height = 141;
			var layout:HorizontalLayout = new HorizontalLayout;
			layout.gap = 15;
			_list.layout = layout;
			
			var value:Rectangle = new Rectangle(0,0,376,141);
			_list.x = 31;
			_list.y = 82;
			addChild(_list);
			
			sureBtn = new Button();
			sureBtn.defaultLabelProperties.isHTML = true;
			sureBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("402941"),'b3a7db',16);
			sureBtn.x = 130;
			sureBtn.y = 290;
			addChild(sureBtn);
			
			sureBtn.addEventListener(Event.TRIGGERED, checkItem);
		}
		
		override public function show(...rests):void
		{
			super.show(rests);
			var daily:Array = rests[0];
			var total:Array = rests[1];
			var list:Array = [];
			var data:SevenLoginBonus;
			if(daily.length > 0)
			{
				data = Configure.sevenLoginBonus.getItemById(daily[0]);
				data.status = 1;
				list.push(data);
			}
			if(total.length > 0)
			{
				for(var i:String in total)
				{
					data = Configure.sevenLoginTotalBonus.getItemById(total[i]);
					data.status = 1;
					list.push(data);
				}
			}
			
			switch(list.length)
			{
				case 1:
					_list.x = 151;
					break;
				case 2:
					_list.x = 71;
					break;
				case 3:
					_list.x = 71;
					break;
				case 4:
					_list.x = 21;
					break;
			}
			_list.dataProvider = new ListCollection(list);
		}
		/**
		 * 打开道具 
		 * @param e
		 * 
		 */		
		private function checkItem(e:Event):void
		{
			this.closeWindow();
			
			PopUpWindowManager.centerPopUpWindow(WindowFactory.addPopUpWindow(WindowFactory.PACK_WINDOW) as DisplayObject);
		}
		
		override public function get name():String
		{
			return WindowFactory.SEVEN_LOGIN_REWARD_WINDOW;
		}
		
		override protected function initHide():void
		{
			sureBtn.removeEventListener(MouseEvent.CLICK, checkItem);
		}
	}
}