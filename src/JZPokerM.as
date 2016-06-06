package
{
	import com.freshplanet.ane.AirFacebook.Facebook;
	import com.freshplanet.ane.AirFacebook.FacebookPermissionEvent;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.context.MainContext;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.view.login.LoginView;
	import com.spellife.display.ASFButton;
	
	import flash.desktop.NativeApplication;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import starling.core.Starling;
	
	public class JZPokerM extends Sprite
	{
		/***********
		 * name:    JZPokerM
		 * data:    Nov 3, 2015
		 * author:  jim
		 * des:
		 ***********/
		[SWF(width="960", height="640", frameRate="50", backgroundColor="#ffffff")]
		private var starling:Starling;
		private var _mainContext:MainContext;
		public function JZPokerM()
		{
			super();
			
			this.addEventListener(Event.ENTER_FRAME,update);
		}
		
		private function update(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME,update);
			trace("realStart:",Facebook.isSupported);
			trace("stage info:",stage.fullScreenWidth,stage.fullScreenHeight);
			trace("phone info:",ReleaseUtil.runningOnAndroid(),ReleaseUtil.runningOnIphone());
			trace("Capabilities.isDebugger()",Capabilities.isDebugger,Capabilities.playerType,Capabilities.version);
			var os:String = Capabilities.manufacturer;
			trace("phone info:",os,os.indexOf('android'),os.indexOf('Android'));
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//			stage.setOrientation(StageOrientation.ROTATED_RIGHT);
//			if(Capabilities.playerType == "Desktop")
//			{
//				ReleaseUtil.RELEASE = false;
//			}
			var info:LoaderInfo = this.stage.loaderInfo;
			new AssetsCenter(info.parameters.assets_path,ExternalVars.language);
			if(Facebook.isSupported)
			{
				if(Facebook.getInstance())
				{
					Facebook.getInstance().init(ExternalVars.appID,true);
					//_facebook.publishInstall(APP_ID);
					//					setTimeout(checkSession, 1000);
				}
			}
			
			if(ReleaseUtil.runningOnAndroid() || ReleaseUtil.runningOnIphone())
			{
				initLoginView();
			}else
			{
				_mainContext = new MainContext();
				addChild(_mainContext);
			}
			
			NativeApplication.nativeApplication
				.addEventListener(InvokeEvent.INVOKE,
					function invokeHandler(event:InvokeEvent):void{
						if(event.arguments.length>0){
//							doSomething(event.arguments[0]);
						}
					});
//			testPartyTrack();
		}
		
//		private var _track:PartyTrackAPI;
//		private function testPartyTrack():void
//		{
//			_track = new PartyTrackAPI()
//			trace("test start!：",_track.isInit());
//			//			_track.hello("test start!");
//			_track.hello('i am from start!');
//			_track.start(6882,'6ee0dfe4cfdd208dab3cd14d8915d830');
//			trace("start end!：");
//			//_track.hello(result);
//		}
		
		private var _login:LoginView = new LoginView();
		/**
		 *登录界面 
		 * 
		 */
		private function initLoginView():void
		{
			var deviceSize:Rectangle = new Rectangle(0, 0,
				Math.max(stage.fullScreenWidth, stage.fullScreenHeight),
				Math.min(stage.fullScreenWidth, stage.fullScreenHeight));
			var guiSize:Rectangle = new Rectangle(0, 0, 960, 640);
			var appScale:Number = 1;
			var appSize:Rectangle = guiSize.clone();
			var appLeftOffset:Number = 0;
			//这里要寻找sacle大的，即时超框也不要黑边
			// if device is wider than GUI's aspect ratio, height determines scale
			if ((deviceSize.width/deviceSize.height) < (guiSize.width/guiSize.height)) {
				appScale = deviceSize.height / guiSize.height;
				appSize.width = deviceSize.width / appScale;
				appLeftOffset = Math.round((appSize.width - guiSize.width) / 2);
			} 
				// if device is taller than GUI's aspect ratio, width determines scale
			else {
				appScale = deviceSize.width / guiSize.width;
				appSize.height = deviceSize.height / appScale;
				appLeftOffset = 0;
			}
			
			_login.scaleX = _login.scaleY = appScale;
			_login.x = (stage.fullScreenWidth - _login.width) *0.5;
			_login.y = (stage.fullScreenHeight - _login.height) *0.5;
			_login.submit.addEventListener(MouseEvent.CLICK, subMitHandler);
			this.addChild(_login);
		}
		
		private function subMitHandler(e:MouseEvent):void
		{
			ExternalVars.userID = uint(_login.userId);
			_login.submit.removeEventListener(MouseEvent.CLICK, subMitHandler);
			this.removeChild(_login);
			_mainContext = new MainContext();
			addChild(_mainContext);
		}
		
		public static var ALLOW_DISABLED_BUTTON_CLICK:Boolean = false;
		
		private var btnsList:Vector.<ASFButton>;
		private var btns:Object;
		
		private var statusBar:Sprite;
		private var statusConnected:TextField;
		private var statusPermissions:TextField;
		
		public function testStart():void
		{
			// init the ANE
			Facebook.getInstance().init( ExternalVars.appID ,true);
			Facebook.getInstance().logEnabled = true;
			
			createUI(
				{id:"connect",			label: "Connect",										handler: onBtnConnect,		scheme:ASFButton.BLUE},
				
				// those need connection
				{id:"graph_og_like",	label: "like freshplanet.com",		deco:"[OG]",		handler: onBtnGraphOG,		scheme:ASFButton.BLUE, cond:isSessionOpened },
				
				// You don't need to be connected to use those functionalities
				// it will call the native app or mFacebook in a webview
				// your user will have to be connected (or otherwise to login) in the app or in a browser
				{id:"dialog_status",	label: "Share a status",			deco:"[Dialog]",	handler: onBtnShareStatus,	scheme:ASFButton.BLUE},
				{id:"dialog_link",		label: "Share a link", 				deco:"[Dialog]",	handler: onBtnShareLink,	scheme:ASFButton.BLUE},
				{id:"dialog_og",		label: "Share an OpenGraph object",	deco:"[Dialog]",	handler: onBtnShareOG,		scheme:ASFButton.BLUE},
				{id:"web_dialog",		label: "Web Share Dialog", 			deco:"[Dialog]",	handler: onBtnWebShare,		scheme:ASFButton.BLUE}
			);
			
			if(isSessionOpened())
				onSessionOpened(true,null,null);
			
		}
		
		// ------------------
		private function isSessionOpened():Boolean{
			return Facebook.getInstance().isSessionOpen;
		}
		
		// ------------------
		// opening session
		private function onBtnConnect(e:Event):void
		{
			Facebook.getInstance().openSessionWithReadPermissions([], onSessionOpened);
		}
		
		private function onBtnDisconnect(e:Event):void
		{
			Facebook.getInstance().closeSessionAndClearTokenInformation();
			btnsList[0].text = "Connect";
			btnsList[0].handler = onBtnConnect;
			
			refresh(); //deactivate btns
		}
		
		private function onSessionOpened(success:Boolean, userCancelled:Boolean, error:String):void
		{
			
			if (!success && error)
			{
				trace("Session opening error:", error);
				return;
			}
			
			if(success)
			{
				btnsList[0].text = "Disconnect";
				btnsList[0].handler = onBtnDisconnect;
				
				refresh(); //activate btns
			}
			
		}
		
		private static const ALLOWED_PERMISSIONS:Array = ["publish_actions"];
		private function onRequirePermission(permissions:Array, callback:Function):void
		{
			for ( var i:int = 0; i<permissions.length; ++i)
			{
				// you should take great care of the permissions you are requesting
				if(ALLOWED_PERMISSIONS.indexOf(permissions[i]) < 0)
					permissions.splice(i,1);
			}
			
			if(permissions.length > 0)
			{
				Facebook.getInstance().reauthorizeSessionWithPublishPermissions(permissions, callback)
			}
		}
		
		// ----------------
		// 
		private function onBtnGraphOG(e:Event):void
		{
			var ogObject:Object = {
				object:"http://freshplanet.com"
			};
			
			var path:String = "me/og.likes";
			
			function callGraphPath():void{
				Facebook.getInstance().requestWithGraphPath(path, ogObject, "POST",
					function(data:Object):void
					{
						trace(JSON.stringify(data));
					});
			}
			
			// handle permission missing
			function onPermissionMissing(e:FacebookPermissionEvent):void
			{
				Facebook.getInstance().removeEventListener(FacebookPermissionEvent.PERMISSION_NEEDED, onPermissionMissing);
				onRequirePermission(e.permissions, function(success:Boolean, userCancelled:Boolean, error:String):void{
					if(success)
						callGraphPath();
				});
			}
			Facebook.getInstance().addEventListener(FacebookPermissionEvent.PERMISSION_NEEDED, onPermissionMissing);
			
			callGraphPath();
			
		}
		
		// ------------------
		// showing dialogs
		private function onBtnShareStatus(e:Event):void
		{
			if(Facebook.getInstance().canPresentShareDialog())
				Facebook.getInstance().shareStatusDialog( errorHandler );
			else
				Facebook.getInstance().webDialog("feed", null, errorHandler);
		}
		
		private function onBtnShareLink(e:Event):void
		{
			if(Facebook.getInstance().canPresentShareDialog())
				Facebook.getInstance().shareLinkDialog( "http://freshplanet.com/", null, null, null, null, errorHandler );
			else
				Facebook.getInstance().webDialog( "feed", { 'link':"http://freshplanet.com" }, errorHandler );
		}
		
		private function onBtnShareOG(e:Event):void
		{
			
			var ogObject:Object = {
				object:"http://freshplanet.com"
			};
			var canPresentDialog:Boolean = Facebook.getInstance().canPresentOpenGraphDialog( "og.like", ogObject );
			
			if(canPresentDialog)
				Facebook.getInstance().shareOpenGraphDialog( "og.likes", ogObject, "object", null, errorHandler );
			
		}
		
		private function onBtnWebShare(e:Event):void
		{
			Facebook.getInstance().webDialog( "feed", { 'link':"http://freshplanet.com" }, errorHandler );
		}
		
		
		private function errorHandler(data:Object):void{
			
			trace(JSON.stringify(data));
			
		}
		
		
		// ------------------
		// UI stuff, nothing to see here
		
		private function createUI( ...btnsDef ):void
		{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.color = 0xAAAAAA;
			const w:Number = stage.fullScreenWidth;
			
			statusBar = new Sprite();
			statusBar.x = statusBar.y = 0;
			statusConnected = new TextField();
			statusConnected.defaultTextFormat = new TextFormat( "Arial", 14, 0x999999, false, false, false, null, null, TextFormatAlign.LEFT );
			statusConnected.filters = [new DropShadowFilter(2,45,0,.3,1,1,1,1)];
			statusPermissions = new TextField();
			statusConnected.defaultTextFormat = new TextFormat( "Arial", 14, 0x999999, false, false, false, null, null, TextFormatAlign.RIGHT );
			statusConnected.filters = [new DropShadowFilter(2,45,0,.3,1,1,1,1)];
			statusBar.addChild(statusConnected);
			statusBar.addChild(statusPermissions);
			addChild(statusBar);
			
			btnsList = new Vector.<ASFButton>();
			
			for each( var def:Object in btnsDef )
			{
				var btn:ASFButton = new ASFButton( def.label, def.cond );
				btn.decoration = def.deco;
				btn.handler = def.handler;
				addChild( btn );
				btnsList.push( btn );
			}
			
			refresh();
			stage.addEventListener(Event.RESIZE, draw);
			
		}
		
		private function refresh(e:Event=null):void
		{
			statusConnected.text = isSessionOpened() ? "Connected" : "Not Connected";
			
			draw();
		}
		
		private function draw(e:Event=null):void
		{
			
			const dpi:Number = Capabilities.screenDPI;
			const contentScale:Number = dpi/163;
			const cs:Number = contentScale;
			const w:Number = stage.fullScreenWidth/contentScale;
			
			statusBar.graphics.clear();
			statusBar.graphics.beginFill(0xFFFFFF);
			statusBar.graphics.drawRect(0, 0, w*cs, 50*cs);
			statusConnected.x = statusConnected.y = 10*cs;
			statusConnected.width = 1.1*statusConnected.textWidth;
			statusConnected.height = 1.2*statusConnected.textHeight;
			statusPermissions.y = 10*cs;
			statusPermissions.width = 1.1*statusPermissions.textWidth;
			statusPermissions.height = 1.2*statusPermissions.textHeight;
			statusPermissions.x = statusBar.width - (statusPermissions.width + 10*cs);
			
			var prevY:Number = statusBar.y + statusBar.height + 10*cs;
			
			for each ( var btn:ASFButton in btnsList )
			{
				btn.size = new Rectangle(0,0,(w-40)*cs, 40*cs);
				btn.x = (w/2)*cs;
				btn.y = prevY + btn.height/2;
				prevY = btn.y + btn.height/2 + 10;
			}
			
		}
		
	}
}