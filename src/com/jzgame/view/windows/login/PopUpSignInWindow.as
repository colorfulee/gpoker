package com.jzgame.view.windows.login
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.WindowFactory;
	import com.jzgame.view.display.StarlingProgressBar;
	import com.spellife.display.PopUpWindow;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class PopUpSignInWindow extends PopUpWindow
	{
		/***********
		 * name:    PopUpSignInWindow
		 * data:    Dec 18, 2015
		 * author:  jim
		 * des:     签到系统
		 ***********/
		protected var _back:Scale9Image;
		protected var _titleBack:Image;
		protected var _frame:Image;
		protected var _rightFrame:Image;
		protected var _close:Button;
		protected var _title:Image;
		public var signBtn:Button;
		public var descBtn:Button;
		private var _infoBack:Scale9Image;
		private var _dayList:List;
		private var _progress:StarlingProgressBar;
		
		private var _first:SevenLoginTotalBonusItem;
		private var _second:SevenLoginTotalBonusItem;
		private var _third:SevenLoginTotalBonusItem;
		
		private var _secondTitle:Image;
		private var _secondTitleLeftBack:Image;
		private var _secondTitleRightBack:Image;
		
		public function PopUpSignInWindow()
		{
			super();
			
			mName = WindowFactory.DAILY_BONUS_WINDOW;

			_isSole = false;
			
			init();
		}
		
		protected function init():void
		{
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup")
				,new Rectangle(20,20,1,1));
			_back = new Scale9Image(s9);
			_back.x = 3;
			_back.y = 10;
			_back.width  = 953;
			_back.height = 620;
			addChild(_back);
			_frame = new Image(ResManager.defaultAssets.getTexture("common_bg_pattern"));
			_frame.x = 0;
			_frame.y = 110;
			addChild(_frame);
			_rightFrame = new Image(ResManager.defaultAssets.getTexture("common_bg_pattern"));
			_rightFrame.scaleX = -1;
			_rightFrame.scaleY = -1;
			_rightFrame.x = _rightFrame.width + 158;
			_rightFrame.y = _rightFrame.height;
			addChild(_rightFrame);
			
			_titleBack = new Image(ResManager.defaultAssets.getTexture('mission_bg_signin'));
			_titleBack.x = 253;
			addChild(_titleBack);
			
			_title = new Image(ResManager.defaultAssets.getTexture('mission_txt_sign'));
			_title.x = 390;
			_title.y = 10;
			addChild(_title);
			
			_close = StyleProvider.closeButton;
			_close.x = 900 + 5;
			_close.y = 0;
			addChild(_close);
			
			setClose(_close);
			
			var sinfo9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_bg_itembg"),new Rectangle(20,20,1,1));
			_infoBack = new Scale9Image(sinfo9);
			_infoBack.width  = 918;
			_infoBack.height = 527;
			_infoBack.x = 20;
			_infoBack.y = 76;
			addChild(_infoBack);
			
			signBtn = new Button();
			signBtn.styleProvider = null;
			signBtn.x = 375;
			signBtn.y = 280;
			addChild(signBtn);
			signBtn.defaultSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_myitem1"));
			signBtn.downSkin = new Image(ResManager.defaultAssets.getTexture("details_btn_myitem2"));
			signBtn.defaultIcon = new Image(ResManager.defaultAssets.getTexture("mission_txt_signin3-1"));
			signBtn.downIcon = new Image(ResManager.defaultAssets.getTexture("mission_txt_signin3-2"));
			signBtn.disabledIcon = new Image(ResManager.defaultAssets.getTexture("mission_txt_signin3-3"));
			signBtn.disabledSkin = new Image(ResManager.defaultAssets.getTexture("mission_btn_signin"));
			
			descBtn = new Button();
			descBtn.styleProvider = null;
			descBtn.x = 18;
			descBtn.y = 25;
			descBtn.downSkin = new Image(ResManager.defaultAssets.getTexture("mission_btn_explain2"));
			descBtn.defaultSkin = new Image(ResManager.defaultAssets.getTexture("mission_btn_explain1"));
			descBtn.defaultLabelProperties.textFormat = StyleProvider.getTF(0x6c6384,20);
			descBtn.label = LangManager.getText('500239');
			addChild(descBtn);
			
			_dayList = new List();
			_dayList.itemRendererType = SignInDayListItem;
			_dayList.itemRendererProperties.width = 123;
			_dayList.width  = 925;
			_dayList.height = 180;
			_dayList.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			_dayList.x = 20;
			_dayList.y = 100;
			
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.gap = 10;
			layout.paddingTop = 5;
			_dayList.layout = layout;
			addChild(_dayList);
			
			
			_secondTitleLeftBack = new Image(ResManager.defaultAssets.getTexture("mission_bg_line"));
			_secondTitleLeftBack.x = 284 + 18;
			_secondTitleLeftBack.y = 381;
			addChild(_secondTitleLeftBack);
			
			_secondTitleRightBack = new Image(ResManager.defaultAssets.getTexture("mission_bg_line"));
			_secondTitleRightBack.y = 381;
			_secondTitleRightBack.x = 648;
			_secondTitleRightBack.scaleX = -1;
			addChild(_secondTitleRightBack);
			
			_secondTitle = new Image(ResManager.defaultAssets.getTexture('mission_txt_login'));
			_secondTitle.x = 418;
			_secondTitle.y = 370;
			addChild(_secondTitle);
			
			_progress = new StarlingProgressBar(ResManager.defaultAssets.getTexture("mission_bg_jindutiao2"),
				ResManager.defaultAssets.getTexture("mission_bg_jindutiao1")
				);
			_progress.setLocation(71,503);
			_progress.type = StarlingProgressBar.MOVE_MASK;
			_progress.touchable = false;
			_progress.setBarRect(new Rectangle(0,0,760,23));
			_progress.value = 0;
			addChild(_progress);
			
			
			_first = new SevenLoginTotalBonusItem;
			_first.x = 166 + 20 + 160;
			_first.y = 450 + 7;
			addChild(_first);
			
			_second = new SevenLoginTotalBonusItem;
			_second.x = 372 + 20 + 160;
			_second.y = 450 + 7;
			addChild(_second);
			
			_third = new SevenLoginTotalBonusItem;
			_third.x = 586 + 11 + 180;
			_third.y = 450 + 7;
			addChild(_third);
		}
		
		public function setData(t:uint):void
		{
			var list:Array = Configure.sevenLoginBonus.getItemLists();
			_dayList.dataProvider = new ListCollection(list);
			
			list = Configure.sevenLoginTotalBonus.getItemLists();
			
			_first.setData(list[0].bonus,list[0].day,list[0].status);
			_second.setData(list[1].bonus,list[1].day,list[1].status);
			_third.setData(list[2].bonus,list[2].day,list[2].status);
			
			_progress.value =  (t / 7);
			
			if(t>=3)
			{
			}
			
			if(t>=5)
			{
			}
		}
	}
}