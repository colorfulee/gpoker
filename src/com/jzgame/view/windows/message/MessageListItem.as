package com.jzgame.view.windows.message
{
	import com.adobe.utils.StringUtil;
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.message.MessageProxy;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.common.vo.MessageCenterVO;
	import com.jzgame.enmu.SystemColor;
	import com.jzgame.util.ItemStringUtil;
	import com.jzgame.view.display.FaceWithFrame;
	import com.spellife.util.HtmlTransCenter;
	import com.spellife.util.TimerManager;
	import com.starling.theme.StyleProvider;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class MessageListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    MessageListItem
		 * data:    Nov 26, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _back:Scale9Image;
//		private var _des:Label;
		private var _des:TextField;
		private var _underLine:Bitmap;
		private var _face:FaceWithFrame;
		//时间
		private var _happenTime:TextField;
		//		private var _data:SLLabel;
		private var _select:Check;
		
		private var _operateBtn:Button = new Button;
		private var _skip:Button = new Button;
		public function MessageListItem()
		{
			super();
		}
		
		override protected function initialize():void
		{
			styleProvider = null;
			
			var s9t:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_mailbox_bg_mails")
			,new Rectangle(45,25,1,1));
			_back = new Scale9Image(s9t);
			_back.x = 5;
			_back.width = 638;
//			_back.height = 94;
			addChild(_back);
			
			_face = new FaceWithFrame();
			_face.x = 20;
			_face.y = 20;
			_face.scaleX = _face.scaleY = .5;
//			DisplayManager.centerYByPoint(_face,80 - 10);
			addChild(_face);
			
			_happenTime = new TextField(100,85,"",HtmlTransCenter.Arial(),16,0x7e7c89);
			_happenTime.x = 370;
			_happenTime.vAlign = VAlign.BOTTOM
			addChild(_happenTime);
			
			hasLabelTextRenderer = false;
			_des = new TextField(445,94,"",HtmlTransCenter.Arial(),18,0x100f17);
			_des.x = 80;
			_des.hAlign = HAlign.LEFT;
			_des.color = 0x100f17;
			_des.fontSize = 18;
			
			addChild(_des);
			
			
			_skip = new Button();
			_skip.styleProvider = null;
			_skip.defaultSkin = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_confirm1"));
			_skip.defaultSkin.pivotX = 96;
			_skip.defaultSkin.scaleX = -1;
			_skip.downSkin = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_confirm2"));
			_skip.downSkin.pivotX = 96;
			_skip.downSkin.scaleX = -1;
			_skip.defaultIcon = new Image(ResManager.defaultAssets.getTexture("mailbox_txt_ignore1"));
			_skip.downIcon = new Image(ResManager.defaultAssets.getTexture("mailbox_txt_ignore2"));
//			_skip.iconOffsetX = -94;
			addChild(_skip);
			_skip.x = 536;
			_skip.y = 5;
			
			_operateBtn = new Button();
			_operateBtn.styleNameList.add(StyleProvider.CUSTOM_BUTTON_IN_MESSAGE);
			_operateBtn.defaultIcon = new Image(ResManager.defaultAssets.getTexture("mailbox_txt_confirm1"));
			_operateBtn.downIcon = new Image(ResManager.defaultAssets.getTexture("mailbox_txt_confirm2"));
			_operateBtn.x = 436 + 102;
			_operateBtn.y = 5;
			addChild(_operateBtn);
			
			_select = new Check();
			_select.y = 32;
			addChild(_select);
			
			this.addEventListener(starling.events.TouchEvent.TOUCH, touchHandler);
			_operateBtn.addEventListener(starling.events.Event.TRIGGERED,processMessage);
			_skip.addEventListener(starling.events.Event.TRIGGERED,skipMessage);
		}
		public function get isChcekSelected():Boolean
		{
			return _select.isSelected;
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function touchHandler(e:TouchEvent):void
		{
			if(e.getTouch(this,TouchPhase.ENDED) || e.getTouch(_select,TouchPhase.ENDED))
			{
				_select.isSelected = !_select.isSelected;
				SignalCenter.onShowMailItemSelected.dispatch(uint(data.id),_select.isSelected);
			}
		}
		/**
		 * 处理 
		 * @param e
		 * 
		 */		
		private function processMessage(e:starling.events.Event):void
		{
			HttpSendProxy.sendProcessSingleMessage(data.id);
		}
		/**
		 * 删除 
		 * @param e
		 * 
		 */		
		private function skipMessage(e:starling.events.Event):void
		{
			HttpSendProxy.sendDelMessage([data.id]);
		}
		/**
		 * 设置数据 
		 * @param value
		 * 
		 */		
		override public function set data(value:Object):void
		{
			super.data = value;
			_select.isSelected = false;
			var d:MessageCenterVO = MessageCenterVO(value);
			if(!d)return;
			SignalCenter.onShowMailItemInfoSelected.add(changeCheck);
			updateStatus(null);
		}
		/**
		 * 
		 * @param b
		 * 
		 */		
		private function changeCheck(b:Boolean):void
		{
			_select.isSelected = b;
		}
		
		/**
		 * 更新按钮状态 
		 * @param e
		 * 
		 */		
		private function updateStatus(e:flash.events.Event):void
		{
			var ddd:MessageCenterVO = MessageCenterVO(data);
			if(!ddd)return;
			_operateBtn.visible = false;
			_skip.visible = true;
			switch(ddd.type)
			{
				//901 好友请求
				case MessageProxy.ADD_FRIEND:
					_des.text = LangManager.getText("300404") +" "+ ddd.friendName +" "+ LangManager.getText("300403");
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("300401"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_face.setData(ddd.friendFBID);
					break;
				//902 收到好友礼物
				case MessageProxy.SEND_GIFT:
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_des.text = LangManager.getText("300408").replace("[playerName]",ddd.friendName);
					_face.setData(ddd.friendFBID);
					break;
				//903 向好友请求礼物
				case MessageProxy.ASK_GIFT:
					_operateBtn.visible = true;
					_skip.visible = false;
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("300411"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_des.text = LangManager.getText("300409").replace("[playerName]",ddd.friendName);
					_face.setData(ddd.friendFBID);
					break;
				//904 公告
				case MessageProxy.GLOBAL_MESSAGE:
					_des.text = ddd.text;
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_face.setData("");
					break;
				//现金购买 905
				case MessageProxy.CASH_BUY:
					if(ddd.itemId == "1")
					{
						_des.text = LangManager.getText("300424",ddd.itemNum);
					}else
					{
						_des.text = LangManager.getText("300425",ddd.itemNum);
					}
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_face.setData("");
					break;
				//				mtt报名 906 
				case MessageProxy.MTT_SIGN_IN:
					_des.text = LangManager.getText("300420",ddd.text);
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_face.setData("");
					break;
				//				mtt结果 907 
				case MessageProxy.MTT_RESULT:
					//					var bonus:Object = ddd.bonus;
					_des.text = LangManager.getText("300421",ddd.text,ItemStringUtil.getItemString(ddd.bonus));
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_face.setData("");
					break;
				//				升级礼包 908  
				case MessageProxy.UPDATE_GIFT:
					if(ddd.status == 1)
					{
//						_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
						_operateBtn.visible = true;
					}
					_des.text = LangManager.getText("300423",ddd.text,Configure.playerLevel.getBonusByLevel(ddd.text));
					_face.setData("");
					break;
				//				奖励todo 909 
				case MessageProxy.PRIZE_TODO:
					switch(ddd.dataType)
					{
						case 5:
							_des.text = LangManager.getText("402212");
							break;
						//邀请好友
						case 6:
							_des.text = LangManager.getText("402211");
							break;
						//点赞
						case 7:
							_des.text = LangManager.getText("402210");
							break;
						case 22:
							if(ddd.ext.hasOwnProperty("fb_id"))
							{
								_des.text = LangManager.getText("402333",ddd.ext.fb_first_name+ddd.ext.fb_last_name);
							}else
							{
								_des.text = LangManager.getText("402334",ddd.myName,"30K");
							}
							break;
						//						#type = 26   活动券回收
						//						ext = ['activity_id'=>xxx, 'type':xxx, 'ticket':xxx]
						case 26:
							_des.text = LangManager.getText("403188",ddd.ext.ticket);
							break;
						//#type = 105  spec_mtt退赛
						case 105:
							_des.text = LangManager.getText("403156");
							break;
					}
					if(ddd.status == 1)
					{
						//						_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
						_operateBtn.visible = true;
						_skip.visible = false;
					}else
					{
						_operateBtn.visible = false;
						_skip.visible = false;
					}
					_face.setData("");
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					break;
				//				好友邀请参加牌局 910 
				case MessageProxy.INVITE_ROUND:
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("300411"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_des.text = LangManager.getText("300409").replace("[playerName]",ddd.friendName);
					break;
				case MessageProxy.MTT_START:
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_des.text = LangManager.getText("300414");
					_face.setData("");
					break;
				case MessageProxy.SPE_MTT_START:
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_des.text = LangManager.getText("300414");
					_face.setData("");
					break;
				//大乐透913
				case MessageProxy.JACK_POT_PRIZE:
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_des.text = String(LangManager.getText("402918",ItemStringUtil.getItemString(ddd.bonus)));
					_face.setData("");
					break;
				//			spe	mtt报名 916 
				case MessageProxy.SPE_MTT_SIGN_IN:
					_des.text = String(LangManager.getText("300420",ddd.text));
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_face.setData("");
					break;
				//			spe	mtt结果 915 
				case MessageProxy.SPE_MTT_RESULT:
					//					var bonus:Object = ddd.bonus;
					_des.text = StringUtil.trim(LangManager.getText("300421",ddd.text,ItemStringUtil.getItemString(ddd.bonus)));
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(LangManager.getText("202021"),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_face.setData("");
					break;
				default:
//					_operateBtn.label = HtmlTransCenter.getHtmlStr(ddd.type.toString(),SystemColor.STR_GUIDE_BUTTON_TEXT,12);
					_face.setData("");
					break;
			}

			_happenTime.text = TimerManager.getTimerFormat(ddd.happenTime,"mm/dd");
//			if(ddd.status == MessageCenterVO.READ)
//			{
//				_operateBtn.visible = false;
//				_skip.visible = false;
//			}else
//			{
//				_skip.visible = true;
//				_operateBtn.visible = true;
//			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			SignalCenter.onShowMailItemInfoSelected.remove(changeCheck);
		}
	}
}