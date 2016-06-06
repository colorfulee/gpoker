package com.jzgame.view.windows.userInfo
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.vo.AchievementVO;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	public class RecentAchieListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    RecentAchieListItem
		 * data:    Dec 7, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _imageLoader:ImageLoader;
		public function RecentAchieListItem()
		{
			super();
			
			hasLabelTextRenderer = false;
		}
		
		override protected function initialize():void
		{
			_imageLoader = new ImageLoader();
			_imageLoader.scale = .76;
			addChild(_imageLoader);
		}
		
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			var vo:AchievementVO = AchievementVO(data);
			
			if(vo)
			_imageLoader.source = AssetsCenter.getImagePath(vo.img);
		}
	}
}