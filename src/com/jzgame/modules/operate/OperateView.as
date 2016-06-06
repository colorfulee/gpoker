package com.jzgame.modules.operate
{
	import com.jzgame.common.utils.ResManager;
	
	import feathers.controls.Button;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class OperateView extends Sprite
	{
		/***********
		 * name:    OperateView
		 * data:    Nov 18, 2015
		 * author:  jim
		 * des:
		 ***********/
		//3倍大盲
		public var blind3Button:Button;
		//4倍大盲
		public var blind4Button:Button;
		//1倍底池
		public var blind1Button:Button;
		//弃牌
		public var foldButton:Button;
		//跟注
		public var followButton:Button;
		//加注
		public var raiseButton:Button;
		
		//查看或者弃牌
		public var checkFoldButton:Button;
		//自动看牌
		public var autoCheckButton:Button;
		//自动跟注
		public var autoCallButton:Button;
		public var opeList1:PreOpeButton;
		public var opeList2:PreOpeButton;
		public var opeList3:PreOpeButton;
		//加注
		public var raiseSlider:RaiseSlider;
		
		public var waitingContainer:Sprite = new Sprite;
		public var container:Sprite = new Sprite;
		
		public var trigged:Signal = new Signal(Button);
		public function OperateView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			addChild(container);
			addChild(waitingContainer);
			
			raiseSlider = new RaiseSlider();
			raiseSlider.x = 466;
			raiseSlider.y = -raiseSlider.height + 70;
			container.addChild(raiseSlider);
			raiseSlider.visible = false;
			
			blind3Button = new Button();
			blind3Button.styleProvider = null;
			blind3Button.defaultSkin = new Image(ResManager.tableAssets.getTexture("table_btn_pot1"));
			blind3Button.downSkin = new Image(ResManager.tableAssets.getTexture("table_btn_pot2"));
			blind3Button.defaultIcon = new Image(ResManager.tableAssets.getTexture("table_txt_3xbigblind1"));
			blind3Button.downIcon = new Image(ResManager.tableAssets.getTexture("table_txt_3xbigblind2"));
			container.addChild(blind3Button);
			blind3Button.x = 0;
			blind3Button.y = 0;
			
			blind4Button = new Button();
			blind4Button.styleProvider = null;
			blind4Button.defaultSkin = new Image(ResManager.tableAssets.getTexture("table_btn_pot1"));
			blind4Button.downSkin = new Image(ResManager.tableAssets.getTexture("table_btn_pot2"));
			blind4Button.defaultIcon = new Image(ResManager.tableAssets.getTexture("table_txt_4xbigblind1"));
			blind4Button.downIcon = new Image(ResManager.tableAssets.getTexture("table_txt_4xbigblind2"));
			container.addChild(blind4Button);
			blind4Button.x = 160;
			blind4Button.y = 0;
			
			blind1Button = new Button();
			blind1Button.styleProvider = null;
			blind1Button.defaultSkin = new Image(ResManager.tableAssets.getTexture("table_btn_pot1"));
			blind1Button.downSkin = new Image(ResManager.tableAssets.getTexture("table_btn_pot2"));
			blind1Button.defaultIcon = new Image(ResManager.tableAssets.getTexture("table_txt_1xpot1"));
			blind1Button.downIcon = new Image(ResManager.tableAssets.getTexture("table_txt_1xpot2"));
			container.addChild(blind1Button);
			blind1Button.x = 160 * 2;
			blind1Button.y = 0;
			
			foldButton = new Button();
			foldButton.styleProvider = null;
			foldButton.defaultSkin = new Image(ResManager.tableAssets.getTexture("table_btn_Fold1"));
			foldButton.downSkin = new Image(ResManager.tableAssets.getTexture("table_btn_Fold2"));
			foldButton.defaultIcon = new Image(ResManager.tableAssets.getTexture("table_txt_fold1"));
			foldButton.downIcon = new Image(ResManager.tableAssets.getTexture("table_txt_fold2"));
			container.addChild(foldButton);
			foldButton.x = 160 * 3;
			foldButton.y = 0;
			
			followButton = new Button();
			followButton.styleProvider = null;
			followButton.defaultSkin = new Image(ResManager.tableAssets.getTexture("table_btn_call1"));
			followButton.downSkin = new Image(ResManager.tableAssets.getTexture("table_btn_call2"));
			followButton.defaultIcon = new Image(ResManager.tableAssets.getTexture("table_txt_call1"));
			followButton.downIcon = new Image(ResManager.tableAssets.getTexture("table_txt_call2"));
			container.addChild(followButton);
			followButton.x = 160 * 4;
			followButton.y = 0;
			
			
			raiseButton = new Button();
			raiseButton.styleProvider = null;
			raiseButton.defaultSkin = new Image(ResManager.tableAssets.getTexture("table_btn_raise1"));
			raiseButton.downSkin = new Image(ResManager.tableAssets.getTexture("table_btn_raise2"));
			raiseButton.defaultIcon = new Image(ResManager.tableAssets.getTexture("table_txt_rase1"));
			raiseButton.downIcon = new Image(ResManager.tableAssets.getTexture("table_txt_rase2"));
			container.addChild(raiseButton);
			raiseButton.x = 160 * 5;
			raiseButton.y = 0;
			
			opeList1 = new PreOpeButton();
			opeList1.defaultIcon = new Image(ResManager.tableAssets.getTexture("table_txt_checkorfold1"));
			opeList1.downIcon = new Image(ResManager.tableAssets.getTexture("table_txt_checkorfold2"));
			opeList1.x = 300 + 120;
			opeList1.iconOffsetX = 10;
			opeList1.name = '1';
			waitingContainer.addChild( opeList1 );
			
			opeList2 = new PreOpeButton();
			opeList2.defaultIcon = new Image(ResManager.tableAssets.getTexture("table_txt_autocheck1"));
			opeList2.downIcon = new Image(ResManager.tableAssets.getTexture("table_txt_check2"));
			opeList2.x = 480 + 120;
			opeList2.iconOffsetX = 10;
			opeList2.name = '2';
			waitingContainer.addChild( opeList2 );
			
			opeList3 = new PreOpeButton();
			opeList3.defaultIcon = new Image(ResManager.tableAssets.getTexture("table_txt_autocall1"));
			opeList3.downIcon = new Image(ResManager.tableAssets.getTexture("table_txt_autocall2"));
			opeList3.x = 660 + 120;
			opeList3.iconOffsetX = 10;
			opeList3.name = '3';
			waitingContainer.addChild( opeList3 );
			
			blind3Button.addEventListener(Event.TRIGGERED, operate);
			blind4Button.addEventListener(Event.TRIGGERED, operate);
			blind1Button.addEventListener(Event.TRIGGERED, operate);
			foldButton.addEventListener(Event.TRIGGERED, operate);
			followButton.addEventListener(Event.TRIGGERED, operate);
			raiseButton.addEventListener(Event.TRIGGERED, operate);
			
			
			hideAll();
		}
		/**
		 * 操作事件 
		 * @param ev
		 * 
		 */		
		private function operate(ev:Event):void
		{
			trigged.dispatch(ev.currentTarget);
		}
		/**
		 * 弃牌 
		 * 
		 */	
		public function fold():void
		{
			hideAll();
		}
		/**
		 *站起来 
		 * 
		 */		
		public function standUp():void
		{
			waitingContainer.visible = false;
			container.visible = false;
		}
		
		/**
		 * 是否是我自己的回合
		 * @param value
		 * 
		 */		
		public function set myTurn(value:Boolean):void
		{
			hideAll();
			
			if(value)
			{
				container.visible = true;
				waitingContainer.visible = false;
			}else
			{
				waitingContainer.visible = true;
				container.visible = false;
			}
		}
		
		/**
		 * 自己坐下  
		 * @param showJackPotBet  是否显示
		 * 
		 */			
		public function sitDown(showJackPotBet:Boolean = false):void
		{
			hideAll();
//			
			if(showJackPotBet)
			{
//				_jackPotBetView.visible = true;
			}else
			{
//				waitingContainer.visible = true;
			}
		}
		/**
		 * 等待开局 
		 * 
		 */		
		public function waitStart():void
		{
			hideAll();
			waitingContainer.visible = true;
		}
		/**
		 * 
		 * 
		 */		
		public function unselectAll():void
		{
			opeList1.nonSelect();
			opeList3.nonSelect();
			opeList2.nonSelect();
		}
		
		private function hideAll():void
		{
			waitingContainer.visible =  false;
			container.visible = false;
		}
		
		override public function dispose():void
		{
			blind3Button.removeEventListener(Event.TRIGGERED, operate);
			blind4Button.removeEventListener(Event.TRIGGERED, operate);
			blind1Button.removeEventListener(Event.TRIGGERED, operate);
			foldButton.removeEventListener(Event.TRIGGERED, operate);
			followButton.removeEventListener(Event.TRIGGERED, operate);
			raiseButton.removeEventListener(Event.TRIGGERED, operate);
			super.dispose();
		}
	}
}