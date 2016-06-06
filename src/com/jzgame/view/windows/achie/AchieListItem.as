package com.jzgame.view.windows.achie
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.vo.AchievementVO;
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindow;
	import com.spellife.display.PopUpWindowManager;
	import com.spellife.feathers.SLImageLoader;
	import com.spellife.util.ColorMatrix;
	
	import flash.events.Event;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class AchieListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    AchieListItem
		 * data:    Dec 14, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _icon:SLImageLoader;
		private var _finishTextImage:Image;
		private var _rewardBack:Scale3Image;
		public function AchieListItem()
		{
			super();
			
			hasLabelTextRenderer = false;
			
			_icon = new SLImageLoader;
			_icon.x = 10;
			_icon.y = 3;
			_icon.scale = 1.2;
			addChild(_icon);
			
			this.addEventListener(TouchEvent.TOUCH, showIconDetailHandler);
			
			
			_rewardBack = new Scale3Image(
				new Scale3Textures(
					ResManager.defaultAssets.getTexture('s9_achievement_bg_finish'),15,10));
			addChild(_rewardBack);
			_rewardBack.width = 88;
			_rewardBack.x = 10;
			_rewardBack.y = 60;
			
			_finishTextImage = new Image(ResManager.defaultAssets.getTexture('achievement_txt_finish'));
			_finishTextImage.y = 62;
			_finishTextImage.x = 35;
			addChild(_finishTextImage);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			if(!value)return;
			
			var vo:AchievementVO = AchievementVO(data);
			vo.addEventListener(Event.CHANGE,updateStatusHandler);
			
			_icon.source = AssetsCenter.getImagePath(vo.img);
			//如果完成
			if(vo.status == "1" || vo.status =="2")
			{
				_rewardBack.visible = true;
				_finishTextImage.visible = true;
				ColorMatrix.turnNormal(_icon);
			}else
			{
				_finishTextImage.visible = false;
				ColorMatrix.turnGray(_icon);
				_rewardBack.visible = false;
			}
		}
		/**
		 *  
		 * @param e
		 * 
		 */		
		private function showIconDetailHandler(e:TouchEvent):void
		{
			if(e.getTouch(this,TouchPhase.ENDED))
			{
				PopUpWindowManager.centerPopUpWindow(WindowFactory.addPopUpWindow(WindowFactory.ACHIE_DETAIL_WINDOW,null,AchievementVO(_data)) as PopUpWindow);
			}
		}
		/**
		 * 更新状态 
		 * @param e
		 */
		private function updateStatusHandler(e:Event):void
		{
			var vo:AchievementVO = AchievementVO(_data);
			
//			_reward.visible= vo.isMine;
//			if(vo.bonus == "")
//			{
//				_reward.visible = false;
//			}else
//			{
//				_reward.enabled = true;
//			}
//			
//			if(vo.status == "1")
//			{
//				//				if(vo.bonus == "")
//				//				{
//				//					_reward.visible = false;
//				//				}else
//				//				{
//				//					_reward.enabled = true;
//				//				}
//				_reward.enabled = true;
//			}else
//			{
//				_reward.enabled = false;
//			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			_icon.removeEventListener(TouchEvent.TOUCH, showIconDetailHandler);
		}
	}
}