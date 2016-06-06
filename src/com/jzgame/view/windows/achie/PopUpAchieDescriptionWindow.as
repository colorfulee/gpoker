package com.jzgame.view.windows.achie
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.vo.AchievementVO;
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindow;
	import com.spellife.feathers.SLImageLoader;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	public class PopUpAchieDescriptionWindow extends PopUpWindow
	{
		/***********
		 * name:    PopUpAchieDescriptionWindow
		 * data:    Jan 4, 2016
		 * author:  jim
		 * des:     具体描述
		 ***********/
		protected var _back:Scale9Image;
		protected var _close:Button;
		protected var _icon:SLImageLoader;
		protected var _title:Label;
		protected var _count:Label;
		protected var _des:Label;
		protected var _suer:Button;
		public function PopUpAchieDescriptionWindow()
		{
			super();
			
			_isSole = false;
			
			this.name = WindowFactory.ACHIE_DETAIL_WINDOW;
			
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup")
				,new Rectangle(20,20,1,1));
			_back = new Scale9Image(s9);
			_back.x = 3;
			_back.y = 10;
			_back.width  = 550;
			_back.height = 280;
			addChild(_back);
			
			_close = StyleProvider.closeButton;
			_close.x = 440 + 80;
			_close.y = 0;
			addChild(_close);
			
			setClose(_close);
			
			
			_icon = new SLImageLoader();
			_icon.x = 50;
			_icon.y = 50;
			addChild(_icon);
			
			_title = new Label;
			_title.setSize(460,55);
			_title.textRendererProperties.textFormat = StyleProvider.getTF(0xffffff,22,HtmlTransCenter.Arial());
			addChild(_title);
			_title.x = 150;
			_title.y = 50;
			
			_count = new Label;
			_count.setSize(460,155);
			_count.textRendererProperties.textFormat = StyleProvider.getTF(0xb3a7db,20,HtmlTransCenter.Arial());
			addChild(_count);
			_count.x = 150;
			_count.y = 80;
			
			_des = new Label;
			_des.setSize(460,155);
			_des.textRendererProperties.textFormat = StyleProvider.getTF(0xb3a7db,20,HtmlTransCenter.Arial());
			addChild(_des);
			_des.x = 150;
			_des.y = 110;
			
			_suer = new Button();
			_suer.label = LangManager.getText('500240');
			_suer.x = 215;
			_suer.y = 200;
			addChild(_suer);
			
			setClose(_suer);
		}
		
		override public function show(...rests):void
		{
			super.show(rests);
			
			var vo:AchievementVO = AchievementVO(rests[0]);
			
			if(vo.status == '1' || vo.status == '2')
			{
				if(vo.current < Number(vo.point))
				{
					vo.current = Number(vo.point);
				}
			}
			_icon.source = AssetsCenter.getImagePath(vo.img);
			_title.text = vo.name;
			_count.text = LangManager.getText('500241')+vo.current+'/'+vo.point;
			_des.text = LangManager.getText('500242')+vo.achi_desc.replace("[num]",vo.point);
		}
	}
}