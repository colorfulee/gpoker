package com.jzgame.mediator.windows.setting
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.model.UserModel;
	import com.jzgame.view.windows.setting.PopUpGameSettingWindow;
	
	import feathers.controls.ToggleSwitch;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class PopUpGameSettingWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpGameSettingWindowMediator
		 * data:    Dec 10, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpGameSettingWindow;
		[Inject]
		public var userModel:UserModel;
		public function PopUpGameSettingWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.musicToggle.addEventListener(Event.CHANGE, musicChange);
			view.effectToggle.addEventListener(Event.CHANGE, musicChange);
			view.setId(userModel.myInfo.userId.toString());
			view.musicToggle.isSelected = true;
			view.effectToggle.isSelected = true;
		}
		
		override public function destroy():void
		{
			view.musicToggle.removeEventListener(Event.CHANGE, musicChange);
			view.effectToggle.removeEventListener(Event.CHANGE, musicChange);
		}
		
		private function musicChange(e:Event):void
		{
			var target:ToggleSwitch = e.currentTarget as ToggleSwitch;
			if(target.isSelected)
			{
				target.onTrackProperties.defaultSkin = new Image(ResManager.defaultAssets.getTexture("setting_btn_on"));
			}else
			{
				target.onTrackProperties.defaultSkin = new Image(ResManager.defaultAssets.getTexture("setting_btn_off"));
			}
		}
	}
}