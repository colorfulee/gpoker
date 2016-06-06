package com.jzgame.view.windows.safeBox
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.spellife.display.PopUpWindow;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PopUpSafeBoxWindow extends PopUpWindow
	{
		/***********
		 * name:    PopUpSafeBoxWindow
		 * data:    Jan 5, 2016
		 * author:  jim
		 * des:
		 ***********/
		protected var _back:Scale9Image;
		protected var _titleBack:Image;
		protected var _title:Image;
		protected var _save:Button;
		protected var _out:Button;
		protected var _close:Button;
		protected var _inputBack:Scale9Image;
		
		protected var _tabBar:List;
		public var sure:Button;
		public var container:Sprite = new Sprite;
		public function PopUpSafeBoxWindow()
		{
			super();
			
			_isSole = false;
			init();
		}
		
		public function get tabBar():List
		{
			return _tabBar;
		}

		private function init():void
		{
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup")
				,new Rectangle(20,20,1,1));
			_back = new Scale9Image(s9);
			_back.width  = 912;
			_back.height = 570;
			addChild(_back);
			
			_titleBack = new Image(ResManager.defaultAssets.getTexture('details_bg_title'));
			addChild(_titleBack);
			
			_title = new Image(ResManager.defaultAssets.getTexture('details_txt_savebox'));
			_title.x = 10;
			_title.y = 10;
			addChild(_title);
			
			
			_tabBar = new List();
			_tabBar.x = 145;
			_tabBar.y = 55;
			_tabBar.itemRendererType = SafeBoxTabBarListItem;
			_tabBar.dataProvider = new ListCollection(
				[
					{ label: LangManager.getText('500244')},{ label: LangManager.getText('500245')}
					,{ label: LangManager.getText('500246')}
				]);
			addChild(_tabBar);
			
			var layout:HorizontalLayout = new HorizontalLayout();
			_tabBar.layout = layout;
			
			addChild(container);
			
//			_save = new Button();
//			_save.x = 145;
//			_save.y = 55;
//			_save.styleProvider = null;
//			_save.defaultSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save1-1'));
//			_save.downSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save1-2'));
//			addChild(_save);
//			
//			_out = new Button;
//			_out.styleProvider = null;
//			_out.defaultSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save2-1'));
//			_out.downSkin = new Image(ResManager.defaultAssets.getTexture('details_lable_save2-2'));
//			addChild(_out);
			
//			_out.x = 350;
//			_out.y = 55;
			
			_close = StyleProvider.closeButton;
			_close.x = 880;
			_close.y = 0;
			addChild(_close);
			
			setClose(_close);
			
			sure = new Button;
			sure.label = LangManager.getText('500243');
			sure.defaultLabelProperties.textFormat = StyleProvider.getTF(0x100f17,24);
			sure.x = 379;
			sure.y = 497;
			addChild(sure);
		}
	}
}