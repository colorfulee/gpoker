package com.jzgame.modules.lobby
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.modules.friends.FriendsInfoView;
	import com.jzgame.modules.userInfo.UserInfoView;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class RoomView extends Sprite
	{
		private var _back:Image;
		private var _monkey:Image;
		public var addCashBtn:Button;
		public var taskBtn:Button;
		private var _userInfo:UserInfoView;
		private var _friendInfo:FriendsInfoView;
		//工具列表
		public var toolList:List;
		//比赛类型列表
		public var gameList:List;
		private var _bottom:Scale9Image;
		public function RoomView()
		{
			super();
			
			initView();
		}
		
		/**
		 * 
		 * ui开始
		 */		
		public function start():void
		{
			_userInfo = new UserInfoView;
			addChild(_userInfo);
			
			_friendInfo = new FriendsInfoView;
			_friendInfo.x = 5;
			_friendInfo.y = 268;
			addChild(_friendInfo);
		}
		
		private function initView():void
		{
			_back = new Image(ResManager.getTexture("lobbyBg"));
			_back.width = ReleaseUtil.STAGE_WIDTH;
			_back.height = ReleaseUtil.STAGE_HEIGHT;
			addChild(_back);
			
			var tx:Texture = ResManager.defaultAssets.getTexture("s9_lobby_bg_bottom");
			var s9:Scale9Textures = new Scale9Textures(tx,new Rectangle(85,10,2,2));
			_bottom = new Scale9Image(s9);
			_bottom.width = 940;
			_bottom.x = 10;
			_bottom.y = ReleaseUtil.STAGE_HEIGHT - 51;
			addChild(_bottom);
			
			_monkey = new Image(ResManager.defaultAssets.getTexture("lobby_bg_monkey"));
			_monkey.x = 260;
			_monkey.y = 50;
			addChild(_monkey);
			
			addCashBtn = new Button();
			//去除默认皮肤
			addCashBtn.styleProvider = null;
			addCashBtn.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Recharge1"));
			addCashBtn.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Recharge2"));
			addCashBtn.defaultIcon = new Image(ResManager.defaultAssets.getTexture("lobby_txt_Recharge"));
			addCashBtn.iconOffsetY = 30;
			addChild(addCashBtn);
			addCashBtn.x = 11;
			addCashBtn.y = 140;
			
			taskBtn = new Button();
			taskBtn.styleProvider = null;
			taskBtn.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_mission1"));
			taskBtn.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_mission2"));
			taskBtn.defaultIcon = new Image(ResManager.defaultAssets.getTexture("lobby_txt_mission"));
			taskBtn.iconOffsetY = 30;
			addChild(taskBtn);
			taskBtn.x = 136;
			taskBtn.y = 140;
			
//			normalBtn = new Button();
//			normalBtn.defaultSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Function1"));
//			normalBtn.downSkin = new Image(ResManager.defaultAssets.getTexture("lobby_btn_Function2"));
//			normalBtn.defaultIcon = new Image(ResManager.defaultAssets.getTexture("lobby_txt_Routine1"));
//			normalBtn.x = 590;
//			normalBtn.y = 130;
//			addChild(normalBtn);
			
			toolList = new List();
			toolList.styleProvider = null;
			toolList.width  = 800;
			toolList.height = 120;
			toolList.y = ReleaseUtil.STAGE_HEIGHT - 86;
			toolList.itemRendererType = ToolListItem;
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_JUSTIFY;
			layout.gap = 120;
			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
				layout.paddingLeft = 15;
			toolList.layout = layout;
			addChild(toolList);
			
			gameList = new List();
//			gameList.styleNameList.add(GroupedList.ALTERNATE_STYLE_NAME_INSET_GROUPED_LIST);
			gameList.styleProvider = null;
			gameList.width  = 385;
			gameList.height = 360;
			gameList.x = ReleaseUtil.STAGE_WIDTH-385;
			gameList.y = 30;
			gameList.itemRendererType = GamelListItem;
			var vlayout:VerticalLayout = new VerticalLayout();
			vlayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_JUSTIFY;
			vlayout.gap = 120;
			vlayout.paddingTop = vlayout.paddingRight = vlayout.paddingBottom =
				vlayout.paddingLeft = 15;
			gameList.layout = vlayout;
			addChild(gameList);
			gameList.addEventListener( FeathersEventType.RENDERER_ADD, list_rendererAddHandler );
			gameList.addEventListener( FeathersEventType.RENDERER_REMOVE, list_rendererRemoveHandler );
			
//			normalBtn.addEventListener(Event.TRIGGERED, triggedHandler);
		}
		
//		private function setExtraStyles( list:List ):void
//		{
//			button.iconPosition = Button.ICON_POSITION_TOP;
//			button.defaultIcon = new Image( texture );
//		}
//		
		private function list_rendererRemoveHandler( event:Event, itemRenderer:IListItemRenderer ):void
		{
			itemRenderer.removeEventListener( Event.TRIGGERED, itemRenderer_triggeredHandler );
		}
		
		private function list_rendererAddHandler(event:Event, itemRenderer:IListItemRenderer ):void
		{
			itemRenderer.addEventListener( Event.TRIGGERED, itemRenderer_triggeredHandler );
		}
		
		private var atlas:TextureAtlas = new TextureAtlas(ResManager.getTexture("anim"),ResManager.getXML("animXML"));
		private function itemRenderer_triggeredHandler(e:Event):void
		{
			var itemRenderer:IListItemRenderer = IListItemRenderer( e.currentTarget );
			SignalCenter.onGameTriggered.dispatch(itemRenderer.index);
			return;
			switch(itemRenderer.index)
			{
				case 1:
					for(var i:uint = 0; i<10;i++)
					{
						// 创建位图动画
						var random:Number = Math.random();
						var result:Number = uint(random * 100 % 3);
						var movie:MovieClip
						switch(result)
						{
							case 0:
								movie = new MovieClip(atlas.getTextures("anim"), 100);
								break;
							case 1:
								movie = new MovieClip(atlas.getTextures("hanim"), 120);
								break;
							case 2:
								movie = new MovieClip(atlas.getTextures("vanim"), 150);
								break;
						}
						
						//			movie.loop = false; // default: true
						movie.x = stage.stageWidth * Math.random();
						movie.y = stage.stageHeight * Math.random();
						movie.touchable = false;
						addChild(movie);
						// 控制播放
						movie.play();
						Starling.juggler.add(movie);
					}
					break;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			taskBtn.dispose();
			addCashBtn.dispose();
			_back.dispose();
		}
	}
}