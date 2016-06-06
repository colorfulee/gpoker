package com.jzgame.mediator.windows.safeBox
{
	import com.jzgame.model.UserModel;
	import com.jzgame.view.windows.safeBox.SafeBoxSaveView;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	public class SafeSaveViewMediator extends StarlingMediator
	{
		/***********
		 * name:    SafeSaveViewMediator
		 * data:    Jan 7, 2016
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:SafeBoxSaveView;
		[Inject]
		public var userModel:UserModel;
		public function SafeSaveViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			view.setMoney(userModel.myInfo.chip_box, userModel.myInfo.uMoney.toNumber());
		}
		
		override public function destroy():void
		{
		}
	}
}