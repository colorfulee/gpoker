package com.jzgame.context
{
	import com.jzgame.bundle.MyBundle;
	import com.jzgame.enmu.ReleaseUtil;
	import com.starling.view.StarlingGame;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageOrientation;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
	import robotlegs.bender.framework.impl.Context;
	
	import starling.core.Starling;
	
	public class MainContext extends Sprite
	{
		private var _context:Context;
		private var _starling:Starling;
		public function MainContext()
		{
			super();
//			_starling = starling;
			
			this.mouseEnabled = this.mouseChildren = false;
			this.showLaunchImage();
			addEventListener(Event.ADDED_TO_STAGE, start);
		}
		
		private function start(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, start);
			
			var deviceSize:Rectangle = new Rectangle(0, 0,
				Math.max(stage.fullScreenWidth, stage.fullScreenHeight),
				Math.min(stage.fullScreenWidth, stage.fullScreenHeight));

			var dpi:Number = Capabilities.screenDPI;
			var dpWide:Number = stage.fullScreenWidth * 160 / dpi;
			var inchesWide:Number = stage.fullScreenWidth / dpi;
			
			var serverString:String = unescape(Capabilities.serverString);
			var reportedDpi:Number = Number(serverString.split("&DP=", 2)[1]);
			
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
//			// scale the entire interface
//			base.scale = appScale;
//			
//			// map stays at the top left and fills the whole screen
//			base.map.x = 0;
//			
//			// menus are centered horizontally
//			base.menus.x = appLeftOffset;
//			
//			// crop some menus which are designed to run off the sides of the screen
//			base.scrollRect = appSize;
			
//			this.scaleX = this.scaleY = appScale;
			
			ReleaseUtil.SCALEX = ReleaseUtil.SCALEY = appScale;
			
			initStarling();
			
			init();
		}
		
		/**
		 * 加载图片 
		 * 
		 */		
		private function showLaunchImage():void
		{
			trace("Capabilities.screenResolutionX:",Capabilities.screenResolutionX,"Capabilities.screenResolutionY:",Capabilities.screenResolutionY);
			var filePath:String;
			var isPortraitOnly:Boolean = false;
			trace("Capabilities.manufacturer:",Capabilities.manufacturer,ReleaseUtil.runningOnIphone(),ReleaseUtil.runningOnAndroid());
			if(ReleaseUtil.runningOnIphone())
			{
				var isCurrentlyPortrait:Boolean = this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
				if(Capabilities.screenResolutionX == 1242 && Capabilities.screenResolutionY == 2208)
				{
					//iphone 6 plus
					filePath = isCurrentlyPortrait ? "Default-414w-736h@3x.png" : "Default-414w-736h-Landscape@3x.png";
				}
				else if(Capabilities.screenResolutionX == 1536 && Capabilities.screenResolutionY == 2048)
				{
					//ipad retina
					filePath = isCurrentlyPortrait ? "Default-Portrait@2x.png" : "Default-Landscape@2x.png";
				}
				else if(Capabilities.screenResolutionX == 768 && Capabilities.screenResolutionY == 1024)
				{
					//ipad classic
					filePath = isCurrentlyPortrait ? "Default-Portrait.png" : "Default-Landscape.png";
				}
				else if(Capabilities.screenResolutionX == 750)
				{
					//iphone 6
					isPortraitOnly = true;
					filePath = "Default-375w-667h@2x.png";
				}
				else if(Capabilities.screenResolutionX == 640)
				{
					//iphone retina
					isPortraitOnly = true;
					if(Capabilities.screenResolutionY == 1136)
					{
						filePath = "Default-568h@2x.png";
					}
					else
					{
						filePath = "Default@2x.png";
					}
				}
				else if(Capabilities.screenResolutionX == 320)
				{
					//iphone classic
					isPortraitOnly = true;
					filePath = "Default.png";
				}
			}else
			{
				filePath = ("Default-568h@2x.png");
			}
			trace("filePath:",filePath);
			if(filePath)
			{
				var file:File = File.applicationDirectory.resolvePath(filePath);
				trace("file:",file.exists);
				if(file.exists)
				{
					var bytes:ByteArray = new ByteArray();
					var stream:FileStream = new FileStream();
					stream.open(file, FileMode.READ);
					stream.readBytes(bytes, 0, stream.bytesAvailable);
					stream.close();
					this._launchImage = new Loader();
					this._launchImage.loadBytes(bytes);
					this.addChild(this._launchImage);
					//					this._savedAutoOrients = this.stage.autoOrients;
//					this.stage.autoOrients = false;
//					if(isPortraitOnly)
//					{
//						this.stage.setOrientation(StageOrientation.DEFAULT);
//					}
				}
			}
		}
		
		private var _launchImage:Loader;
		
		private function init():void
		{
			_context = new Context().install( MyBundle,SignalCommandMapExtension ).configure(new ContextView(this) ,_starling) as Context;
		}
		
		/**
		 * configure and start Starling
		 */
		private function initStarling():void {
			_starling = new Starling(StarlingGame,stage);
			//屏幕的实际尺寸
			var sx:int =  stage.fullScreenWidth;
			var sy:int =  stage.fullScreenHeight;
			//屏幕的要缩放成的尺寸,根据制作尺寸按照实际尺寸缩放(即960/640 根据比例变成的大小)
			var guiSize:Rectangle = new Rectangle(0, 0, 960, 640);
			ReleaseUtil.STAGE_WIDTH = sx /  ReleaseUtil.SCALEX;
			ReleaseUtil.STAGE_HEIGHT = sy /  ReleaseUtil.SCALEY;
			ReleaseUtil.STAGE_FULL_WIDTH = stage.fullScreenWidth;
			ReleaseUtil.STAGE_FULL_HEIGHT = stage.fullScreenHeight;
			
			//窗口要设置成实际尺寸分辨率
			_starling.viewPort = new Rectangle(0,0,sx,sy);
			trace("=====",stage.fullScreenWidth,stage.fullScreenHeight,stage.stageWidth,stage.stageHeight,ReleaseUtil.SCALEX,ReleaseUtil.SCALEY,ReleaseUtil.STAGE_WIDTH,ReleaseUtil.STAGE_HEIGHT);
			_starling.showStats = true;
			_starling.antiAliasing = 1;
			_starling.start();
			//场景要设置成实际尺寸分辨率
			_starling.stage.stageWidth = sx ;
			_starling.stage.stageHeight = sy ;
			
			
			var bt:Bitmap = new Bitmap();
			if(this._launchImage)
			{
				_launchImage.y = 640;
				_launchImage.rotation = -90 ;
				this._starling.addEventListener("rootCreated", starling_rootCreatedHandler);
			}
		}
		
		private function starling_rootCreatedHandler(event:Object):void
		{
			if(this._launchImage)
			{
				this.removeChild(this._launchImage);
				this._launchImage.unloadAndStop(true);
				this._launchImage = null;
//				this.stage.autoOrients = this._savedAutoOrients;
			}
		}
	}
}