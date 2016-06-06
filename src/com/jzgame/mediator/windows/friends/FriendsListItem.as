package com.jzgame.mediator.windows.friends
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.common.vo.GameFriendVO;
	import com.jzgame.enmu.AssetsName;
	import com.jzgame.util.NumUtil;
	import com.jzgame.view.display.FaceWithFrame;
	import com.spellife.feathers.SLLabel;
	import com.spellife.util.TimerManager;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class FriendsListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    FriendsListItem
		 * data:    Dec 8, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale9Image;
		private var _face:FaceWithFrame;
		private var _name:SLLabel;
		private var _time:SLLabel;
		private var _chip:SLLabel;
		private var _chipIcon:Image;
		private var _join:Button;
		private var _invite:Button;
		private var _offLine:Image;
		public function FriendsListItem()
		{
			super();
		}
		
		override protected function initialize():void
		{
			styleProvider = null;
			hasLabelTextRenderer = false;
			
			var s9t:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_mailbox_normalbg_mails")
				,new Rectangle(15,15,1,1));
			_back = new Scale9Image(s9t);
			_back.width = 638;
			_back.height = 94;
			addChild(_back);
			
			_face = new FaceWithFrame();
			_face.x = 10;
			_face.y = 10;
			_face.scaleX = _face.scaleY = .6;
			//			DisplayManager.centerYByPoint(_face,80 - 10);
			addChild(_face);
			
			_name = new SLLabel();
			_name.setLocation(100,10);
			_name.setSize(300,30);
			_name.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,18);
			addChild(_name);
			
			_chip = new SLLabel();
			_chip.setLocation(130,38);
			_chip.setSize(300,30);
			_chip.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,16);
			addChild(_chip);
			
			_chipIcon = new Image(ResManager.defaultAssets.getTexture(AssetsName.ASSET_20000_CLIP_ICON));
			_chipIcon.x = 100;
			_chipIcon.y = 36;
			addChild(_chipIcon);
			
			_time = new SLLabel();
			_time.setLocation(100,68);
			_time.setSize(300,30);
			_time.textRendererProperties.textFormat = StyleProvider.getTF(0x7e7c89,16);
			addChild(_time);
			
			_join = new Button();
			_join.styleProvider = null;
			_join.x = 435;
			_join.y = 8;
			_join.defaultSkin = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_confirm1"));
			_join.downSkin = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_confirm2"));
			_join.defaultIcon = new Image(ResManager.defaultAssets.getTexture("friends_txt_join1"));
			_join.downIcon = new Image(ResManager.defaultAssets.getTexture("friends_txt_join2"));
			_join.defaultSkin.pivotX = 96;
			_join.defaultSkin.scaleX = -1;
			_join.downSkin.pivotX = 96;
			_join.downSkin.scaleX = -1;
			addChild(_join);
			
			_invite = new Button();
			_invite.styleNameList.add(StyleProvider.CUSTOM_BUTTON_IN_MESSAGE);
			_invite.x = 540;
			_invite.y = 8;
			_invite.defaultIcon = new Image(ResManager.defaultAssets.getTexture("friends_txt_invite1"));
			_invite.downIcon = new Image(ResManager.defaultAssets.getTexture("friends_txt_invite2"));
			addChild(_invite);
			
			_offLine = new Image(ResManager.defaultAssets.getTexture("friends_txt_leave"));
			_offLine.x = 519;
			_offLine.y = 36;
			addChild(_offLine);
			
			_face.addEventListener(TouchEvent.TOUCH, showInfoHandler);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!value)return;
			var fvo:GameFriendVO = GameFriendVO(data);
			_face.setData(fvo.fb_id);
			_chip.text = ": "+NumUtil.n2kb(fvo.chip);
			_name.text = fvo.name;
			//如果上次登录时间为7天前，则出现召回按钮
			if(TimerManager.getCurrentSysTime() - fvo.last_login_time > 604800)
			{
				
			}else
			{
			}
			_time.text = TimerManager.getRecentDayFormat(fvo.last_login_time);
			
			_join.visible = false;
			_invite.visible = false;
			_offLine.visible = false;
			switch(fvo.status)
			{
				case GameFriendVO.LOBBY:
					_invite.visible = true;
					break;
				case GameFriendVO.TABLE:
					_invite.visible = true;
					_join.visible = true;
					break;
				case GameFriendVO.OFF_LINE:
					_offLine.visible = true;
					break;
			}
		}
		
		private function showInfoHandler(e:TouchEvent):void
		{
			if(e.getTouch(_face,TouchPhase.ENDED))
			{
				SignalCenter.onShowFriendInfoTriggered.dispatch(GameFriendVO(data).id);
			}
		}
	}
}