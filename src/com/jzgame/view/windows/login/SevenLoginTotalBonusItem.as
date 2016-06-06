package com.jzgame.view.windows.login
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.ItemStringUtil;
	import com.spellife.feathers.SLImageLoader;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.ColorMatrix;
	import com.starling.theme.StyleProvider;
	
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	
	public class SevenLoginTotalBonusItem extends Sprite
	{
		/***********
		 * name:    SevenLoginTotalBonusItem
		 * data:    Jul 23, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _name:SLLabel = new SLLabel;
		private var _image:SLImageLoader;
		private var _daysBack:Bitmap = new Bitmap;
		private var _index:SLLabel = new SLLabel;
		private var _reward:Image;
		private var _nameBack:Scale3Image;
		public function SevenLoginTotalBonusItem()
		{
			super();
			
			_nameBack = new Scale3Image(new Scale3Textures(ResManager.defaultAssets.getTexture('mission_bg_data'),30,1));
			_nameBack.width = 102;
			_nameBack.y = 100;
			_nameBack.x = -10;
			addChild(_nameBack);
			
			_image = new SLImageLoader(new Rectangle(26+9,18+25,90,0));
			addChild(_image);
			
			_index.setSize(110,30);
			_index.setLocation(0,100);
			_index.textRendererProperties.textFormat = StyleProvider.getTF(0xffffff,20);
			addChild(_index);
			
			_reward = new Image(ResManager.defaultAssets.getTexture("mission_icon_signin"));
			_reward.x = 38;
			_reward.y = 49;
			addChild(_reward);
			_reward.visible = false;
		}
		
		public function setData(bonus:String,day:String,status:uint):void
		{
			var id:String = bonus.split(AssetsCenter.COLON)[0];
			var num:String = bonus.split(AssetsCenter.COLON)[1];
			
			_name.text = ItemStringUtil.getItemDes((id) , num);
			
			_image.source = AssetsCenter.getImagePath(ItemStringUtil.getItemImage(id));
			_image.setToolTip(ItemStringUtil.getItemDesc(id));
			_index.text = LangManager.getText("500238",day);
			_reward.visible = false;
			switch(status)
			{
				case 0:
					_name.visible = true;
					_nameBack.visible = true;
					ColorMatrix.turnGray(_image);
					break;
				case 1:
					_nameBack.visible = false;
					_name.visible = false;
					_reward.visible = true;
					break;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			_image.setToolTip(null);
		}
	}
}