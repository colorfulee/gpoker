package com.jzgame.modules.table
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.modules.operate.OperateView;
	import com.jzgame.modules.table.ui.TableUIView;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class TableView extends Sprite
	{
		/***********
		 * name:    TableView
		 * data:    Nov 17, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Image;
		private var _table:Image;
		private var _tableShade:Image;
		public var handCardContainer:Sprite = new Sprite;
		public var cardContainer:Sprite = new Sprite;
		public var arrowContainer:Sprite = new Sprite;
		//邀请层
		public var inviteContainer:Sprite = new Sprite;
		//庄icon
		public var roleButton:Image;
		//====
		private var dealContainer:Sprite = new Sprite;
		private var _tableUI:TableUIView;
		private var _operate:OperateView;
		private var _players:PlayersView;
		private var _chips:ChipView;
		public function TableView()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			_back = new Image(ResManager.getTexture("tableBack"));
			addChild(_back);
			
			_table = new Image(ResManager.getTexture("tableImg"));
			DisplayManager.centerByStage(_table);
			_table.y += 35;
			addChild(_table);
			
			_tableShade = new Image(ResManager.getTexture("tableShadeBack"));
//			_tableShade.x = 33;
//			_tableShade.y = 130;
			addChild(_tableShade);
			
			addChild(cardContainer);
			addChild(arrowContainer);
			addChild(inviteContainer);
		}
		
		public function start():void
		{
			_operate = new OperateView;
			_operate.x = 5;
			_operate.y = ReleaseUtil.STAGE_HEIGHT - 50;
			addChild(_operate);
			
			_players = new PlayersView;
			addChild(_players);
			
			addChild(handCardContainer);
			
			_chips = new ChipView();
			addChild(_chips);
			addChild(dealContainer);
			_tableUI = new TableUIView;
			addChild(_tableUI);
			
			roleButton = new Image(ResManager.tableAssets.getTexture("table_icon_dealer"));
			dealContainer.addChild(roleButton);
		}
	}
}