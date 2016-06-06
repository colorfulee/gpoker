package com.jzgame.view.windows.ringGame
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.util.NumUtil;
	import com.jzgame.vo.room.RingRoomInfoVO;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Button;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class RingGameListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    RingGameListItem
		 * data:    Dec 11, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _labelBack:Scale3Image;
		private var _max:SLLabel;
		private var _blinds:SLLabel;
		private var _online:SLLabel;
		private var _chip:Button;
		public function RingGameListItem()
		{
			super();
			
			init();
			
			hasLabelTextRenderer = false;
		}
		
		private function init():void
		{
			_labelBack = new Scale3Image(new Scale3Textures(ResManager.defaultAssets.getTexture('s9_RINGGAME_bg_blind'),10,20));
			_labelBack.width = 146;
			_labelBack.y = 165;
			_labelBack.x = 24;
			addChild(_labelBack);
			
			_chip = new Button;
			_chip.styleProvider = null;
			addChild(_chip);
			
			_max = new SLLabel();
			_max.textRendererProperties.textFormat = StyleProvider.getTF(0xffffff,24,"",TextFormatAlign.CENTER);
			_max.setSize(70,30);
			_max.touchable = false;
			_max.setLocation(27 + 34,35 + 28);
			addChild(_max);
			
			_online = new SLLabel();
			_online.touchable = false;
			_online.textRendererProperties.textFormat = StyleProvider.getTF(0xdfdfdf,14);
			_online.setSize(70,30);
			_online.setLocation(45 + 42,57 + 55);
			addChild(_online);
			
			_blinds = new SLLabel();
			_blinds.textRendererProperties.textFormat = StyleProvider.getTF(0xdfdfdf,16,"",TextFormatAlign.CENTER);
			_blinds.setSize(146,30);
			_blinds.setLocation(24,166);
			addChild(_blinds);
			
			_chip.addEventListener(Event.TRIGGERED,joinTableHandler);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			if(!value)return;
			var vo:RingRoomInfoVO = RingRoomInfoVO(data);
			
			_max.text = NumUtil.n2kb(vo.max);
			_online.text = vo.online.toString();
			_blinds.text = LangManager.getText("200013") + ':' +NumUtil.n2kb(vo.blinds) + " / " + NumUtil.n2kb(vo.blinds * 2);
//			roomId.htmlText = HtmlTransCenter.getHtmlStr(vo.id.toString(),SystemColor.STR_ROOM_LIST_ITEM_TEXT,14,HtmlTransCenter.Arial(),TextFormatAlign.CENTER);
//			roomName.htmlText = HtmlTransCenter.getHtmlStr(LangManager.getText(vo.tableName),SystemColor.STR_ROOM_LIST_ITEM_TEXT,14,"",TextFormatAlign.CENTER);
//			roomNum.htmlText = HtmlTransCenter.getHtmlStr(NumUtil.n2kb(vo.blinds)+"/"+NumUtil.n2kb(vo.blinds * 2),SystemColor.STR_ROOM_LIST_ITEM_TEXT,14,HtmlTransCenter.Arial(),TextFormatAlign.CENTER);
//			roomOnlineNum.htmlText = HtmlTransCenter.getHtmlStr(vo.online.toString() +"/"+vo.maxRole,SystemColor.STR_ROOM_LIST_ITEM_TEXT,14,HtmlTransCenter.realArial(),TextFormatAlign.CENTER);
//			roomMinClip.htmlText = HtmlTransCenter.getHtmlStr(NumUtil.n2kb(vo.minBuy),SystemColor.STR_ROOM_LIST_ITEM_TEXT,14,HtmlTransCenter.Arial(),TextFormatAlign.CENTER);
//			roomMaxClip.htmlText = HtmlTransCenter.getHtmlStr(NumUtil.n2kb(vo.maxBuy),SystemColor.STR_ROOM_LIST_ITEM_TEXT,14,HtmlTransCenter.Arial(),TextFormatAlign.CENTER);
//			_progress.value = vo.online / vo.maxRole;
		}
		
		override public function set index(value:int):void
		{
			super.index = value;
			
			switch(index)
			{
				case 0:
					_chip.defaultSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game1_1'));
					_chip.downSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game1_2'));
					break;
				case 1:
					_chip.defaultSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game2_1'));
					_chip.downSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game2_2'));
					break;
				case 2:
					_chip.defaultSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game3_1'));
					_chip.downSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game3_2'));
					break;
				case 3:
					_chip.defaultSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game4_1'));
					_chip.downSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game4_2'));
					break;
				case 4:
					_chip.defaultSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game5_1'));
					_chip.downSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game5_2'));
					break;
				case 5:
					_chip.defaultSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game6_1'));
					_chip.downSkin = new Image(ResManager.defaultAssets.getTexture('RING GAME_btn_game6_2'));
					break;
			}
		}
		
		private function joinTableHandler(e:Event):void
		{
			var vo:RingRoomInfoVO = RingRoomInfoVO(data);
			SignalCenter.onJoinTableTriggered.dispatch(uint(vo.rooms[0]));
		}
		override public function dispose():void
		{
			super.dispose();
			
			_chip.removeEventListener(Event.TRIGGERED,joinTableHandler);
		}
	}
}