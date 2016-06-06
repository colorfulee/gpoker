package com.jzgame.view.windows.pack
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.common.vo.PackageItemConfigVO;
	import com.jzgame.vo.configs.GiftConfigVO;
	import com.jzgame.vo.configs.ItemConfigVO;
	import com.jzgame.vo.configs.VipConfigVO;
	import com.spellife.display.PopUpWindow;
	import com.spellife.feathers.SLImageLoader;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.ScrollText;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.events.Event;
	
	
	public class PackDetailWindow extends PopUpWindow
	{
		/***********
		 * name:    PackDetailView
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:     道具详细页面
		 ***********/
		protected var _back:Scale9Image;
		protected var _close:Button;
		private var _tu:ImageLoader;
		private var _name:Label;
		private var _storage:Label;
		private var _desc:ScrollText;
		private var _descBack:Scale9Image;
		private var _use:Button ;
		private var _send:Button ;
		private var _id:String;
		public function PackDetailWindow()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup")
				,new Rectangle(20,20,1,1));
			_back = new Scale9Image(s9);
			_back.x = 3;
			_back.y = 10;
			_back.width  = 691;
			_back.height = 488;
			addChild(_back);
			
			_close = StyleProvider.closeButton;
			_close.x = 639 + 5;
			_close.y = 0;
			addChild(_close);
			
			setClose(_close);
			
			_name = new Label;
			_name.setSize(170,30);
			_name.x = 176;
			_name.y = 60;
			_name.textRendererProperties.textFormat = StyleProvider.getTF(0xdadada,18,HtmlTransCenter.Arial());
			addChild(_name);
			
			_storage = new Label;
			_storage.setSize(170,30);
			_storage.x = 176;
			_storage.y = 110;
			_storage.textRendererProperties.isHTML = true;
			addChild(_storage);
			
			_tu = new SLImageLoader();
			_tu.x = 40;
			_tu.y = 40;
			addChild(_tu);
			
			_descBack = StyleProvider.commonRoundBack;
			_descBack.width = 641;
			_descBack.height = 222;
			_descBack.x = 21;
			_descBack.y = 176;
			addChild(_descBack);
			
			_desc = new ScrollText;
			_desc.isHTML = true;
			_desc.textFormat = StyleProvider.getTF(0x948aa6,22);
			_desc.setSize(641,222);
			_desc.x = 25;
			_desc.y = 176;
			addChild(_desc);
			
			_use = new Button();
			_use.x = 140;
			_use.y = 418;
			_use.label = LangManager.getText("300827");
			addChild(_use);
			
			_use.addEventListener(Event.TRIGGERED, useItemHandler);
		}
		
		override public function show(...rests):void
		{
			super.show(rests);
			
			var id:String = rests[0];
			_id = id;
			var num:Number = rests[1];
			var isMine:Boolean = rests[2];
			_storage.text = HtmlTransCenter.getFontStr(LangManager.getText("500105"),"b3a7db",20) + HtmlTransCenter.getFontStr(num.toString(),"84c368",20);
			switch(Configure.getItemType(id))
			{
				case Configure.ITEM:
					var iitemVO:ItemConfigVO = Configure.itemConfig.getItemById(id);
					_tu.source = AssetsCenter.getImagePath(iitemVO.img);
					_name.text = iitemVO.name;
					_desc.text = iitemVO.des;
					_tu.x = 25;
					if(iitemVO.manual == 1)
					{
						_use.visible = false;
					}else
					{
						_use.visible = true;
						
						_use.visible = isMine;
					}
					break;
				case Configure.GIFT:
					var itemVO:GiftConfigVO = Configure.giftConfig.getItemById(id);
					_name.text = itemVO.name;
					_tu.source = ResManager.defaultAssets.getTexture("store_icon_hot");
					_desc.text = itemVO.desc;
					_tu.x = 40;
					break;
				case Configure.PACK:
					var packitem:PackageItemConfigVO = Configure.packItemConfig.getItemById(id);
					_tu.source = AssetsCenter.getImagePath(packitem.img);
					_name.text = packitem.name;
					_desc.text = packitem.desc;
					_tu.x = 25;
					_use.visible = isMine;
					break;
				case Configure.VIP:
					var vitemVO:VipConfigVO = Configure.vipConfig.getItemById(id);
					_tu.source = AssetsCenter.getImagePath(vitemVO.img);
					_name.text = vitemVO.name;
					_desc.text = vitemVO.desc;
					_tu.x = 25;
					
					_use.visible = true;
					_use.visible = isMine;
					break;
			}
		}
		/**
		 * 使用 
		 * @param e
		 * 
		 */		
		private function useItemHandler(e:Event):void
		{
			SignalCenter.onUsePackItem.dispatch(_id);
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			_use.removeEventListener(Event.TRIGGERED, useItemHandler);
		}
	}
}