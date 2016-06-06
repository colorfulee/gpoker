package com.jzgame.view.windows.login
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.ItemStringUtil;
	import com.jzgame.view.display.DefaultDownToolTip;
	import com.spellife.feathers.SLImageLoader;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.ColorMatrix;
	import com.spellife.util.TimerManager;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	
	public class SignInDayListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    SignInDayListItem
		 * data:    Dec 18, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale9Image;
		private var _titleBack:Scale3Image;
		private var _image:SLImageLoader;
		private var _reward:Image;
		private var _num:SLLabel;
		private var _title:SLLabel;
		private var _todayBack:Image;
		
		public function SignInDayListItem()
		{
			super();
			
			hasLabelTextRenderer = false;
			
			init();
		}
		
		private function init():void
		{
			_back = new Scale9Image(new Scale9Textures(ResManager.defaultAssets.getTexture('s9_mission_bg_item'),new Rectangle(18,5,1,1)));
			_back.width = 123;
			addChild(_back);
			
			_todayBack = new Image(ResManager.defaultAssets.getTexture('mission_bg_light'));
			_todayBack.x = 3;
			addChild(_todayBack);
			
			_titleBack = new Scale3Image(new Scale3Textures(ResManager.defaultAssets.getTexture('s9_mission_bg_date3'),5,1));
			_titleBack.width = 81;
			_titleBack.y = -5;
			addChild(_titleBack);
			
			_image = new SLImageLoader(new Rectangle(62,63));
			addChild(_image);
			
			_num = new SLLabel();
			_num.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,20,'',TextFormatAlign.RIGHT);
			_num.setSize(106 , 30);
			_num.setLocation(5,125);
			addChild(_num);
			
			_title = new SLLabel();
			_title.setSize(100 , 30);
			_title.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,18);
			addChild(_title);
			
			_reward = new Image(ResManager.defaultAssets.getTexture('mission_icon_signin'));
			_reward.y = 20;
			_reward.x = 30;
			_reward.touchable = false;
			addChild(_reward);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!value)return;
			var id:String = data.bonus[0].split(AssetsCenter.COLON)[0];
			var num:String = data.bonus[0].split(AssetsCenter.COLON)[1];
			_num.text = ItemStringUtil.getItemDes(id,num);
			_image.source = AssetsCenter.getImagePath(ItemStringUtil.getItemImage(id));
			var current:String = TimerManager.getSysWeekDay();
			_image.setToolTip(new DefaultDownToolTip(ItemStringUtil.getItemDesc(id)));
			_reward.visible = false;
			_todayBack.visible = false;
			switch(data.status)
			{
				//					if(data.day > Number(current))
				//					{
				//						
				//					}else
				//					{
				//						ColorMatrix.turnGray(_image);
				//						DisplayManager.disposeBitmap(_reward);
				//					}
				//					break;
				//未登录
				case 0:
					if(data.day >= Number(current))
					{
						_titleBack.textures = new Scale3Textures(ResManager.defaultAssets.getTexture('s9_mission_bg_date1'),5,1);
					}else
					{
						
					}
					ColorMatrix.turnGray(_image);
					break;
				//登录可领奖
				case 1:
					if(data.day >= Number(current))
					{
						_todayBack.visible = true;
						_titleBack.textures = new Scale3Textures(ResManager.defaultAssets.getTexture('s9_mission_bg_date2'),5,1);
						ColorMatrix.turnNormal(_image);
					}else
					{
//						_reward.bitmapData = ResManager.getBitmapDataByName("20018_missIcon");
//						_reward.y = -10;
//						_reward.x = 5;
						ColorMatrix.turnGray(_image);
					}
					break;
				//已经领奖
				case 2:
					_titleBack.textures = new Scale3Textures(ResManager.defaultAssets.getTexture('s9_mission_bg_date1'),5,1);
					_reward.visible = true;
//					_text.visible = false;
//					_itemBack.visible = false;
//					_reward.y = -10;
//					_reward.x = 5;
//					_reward.bitmapData = ResManager.getBitmapDataByName("20018_getIcon");
					break;
			}
		}
		
		override public function set index(value:int):void
		{
			super.index = value;
			_title.text = LangManager.getText("500233",index + 1);
		}
		
		override public function dispose():void
		{
			super.dispose();
			_image.setToolTip(null);
		}
	}
}