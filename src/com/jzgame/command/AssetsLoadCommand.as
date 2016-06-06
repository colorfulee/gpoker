package com.jzgame.command
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.common.vo.ConfigVO;
	import com.jzgame.enmu.AssetsName;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.loader.AssetsLoader;
	import com.jzgame.loader.FileLoader;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import lzm.starling.STLConstant;
	import lzm.starling.swf.SwfAssetManager;
	
	import org.osflash.signals.Signal;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	import starling.textures.Texture;
	import starling.utils.formatString;
	
	public class AssetsLoadCommand extends Command
	{
		[Inject]
		public var eventDis:IEventDispatcher;
		
		private var items:Vector.<ConfigVO>;
		
		private var max:uint = 0;
		private var current:uint = 0;
		
		public var queue:LoaderMax;
		/**
		 * holds an array of objects
		 */
		private var callBackArray:Array;
		public var onProgress:Signal;
		public var onComplete:Signal;
		
		public function AssetsLoadCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			loadConfig();
			//如果为发布版本，需要加载版本号
			if(ReleaseUtil.RELEASE)
			{
//				loadVersion();
			}else
			{
			}
		}
		
		public function onProgressHandler(event:LoaderEvent):void {
//			Config.log(className, 'onProgressHandler', "progress: " + event.target.progress);
			onProgress.dispatch(event.target.progress);
		}
		
		public function onErrorHandler(event:LoaderEvent):void {
//			Config.logError(className, 'onErrorHandler', "error occured with " + event.target + ": " + event.text);
		}
		
//		//加载版本号配置文件
//		private function loadVersion():void
//		{
//			var fileLoader:FileRetryLoader = new FileRetryLoader();
//			fileLoader.addEventListener(Event.COMPLETE, versionEnoughHandler);
//			fileLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
//			
//			fileLoader.retryLoad(new FileRetryLoaderVO(FileType.BIN,AssetsCenter.getFullPath(ReleaseUtil.versionPath),null));
//		}
//		//版本号加载成功
//		private function versionEnoughHandler(e:Event):void
//		{
//			var fileLoader:FileRetryLoader = e.currentTarget as FileRetryLoader;
//			fileLoader.removeEventListener(Event.COMPLETE, versionEnoughHandler);
//			fileLoader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
//			var data:Object=fileLoader.data;
//			var xml:XML;
//			var bytes:ByteArray = ByteArray(data);
//			var object:Object = (AssetsCenter.transformBinToValueObject(bytes));
//			
//			var path:VersionObject;
//			for each(var item:Object in object)
//			{
//				path         = new VersionObject;
//				path.newPath = item.newPath;
//				path.oldPath = item.oldPath;
//				path.newPath = path.newPath.replace(new RegExp("\\\\","g"),"/");
//				path.oldPath = path.oldPath.replace(new RegExp("\\\\","g"),"/");
//				path.size    = item.size;
//				VersionDic.getInstance().addPathVersion(path.oldPath,path);
//			}
//			
//			loadConfig();
//		}

		//加载配置文件
		private function loadConfig():void
		{
			FileLoader.getInstance().addToLoad(AssetsCenter.getConfigPath(), onInitialAssetsLoadComplete);
		}
		
		/**
		 * Callback function when initialAssets.json finishes loading
		 * 
		 * @param CallBackObject cbo 
		 */
		public function onInitialAssetsLoadComplete(cbo:ConfigVO):void {
			var initAssets:Object = JSON.parse(String(cbo.data));
			max = initAssets.files.length;
			var obj:Object;
			var path:String;
			for(var i:int = 0; i < max; i++) {
				obj = initAssets.files[i];
				path = obj.file;
				path = path.replace('assets/',AssetsCenter.ASSETS)
				FileLoader.getInstance().addToLoad(path, onAssetLoadComplete, obj.id, false, false, obj)
			}
			FileLoader.getInstance().queue.load();
		}
		
		/**
		 * Callback function when loading initialAsseRts
		 * 
		 * @param CallBackObject cbo 
		 */
		public function onAssetLoadComplete(cbo:ConfigVO):void {
			max--;
//			Config.log('Assets', 'onAssetLoadComplete', 'LoadComplete: ' + cbo.name + " -- _itemsToLoad: " + _itemsToLoad);
			Tracer.info(cbo.id + " -- "+max);
			if(cbo.option != null 
				&& cbo.option.hasOwnProperty('convertToTexture') && cbo.option.convertToTexture) 
			{
				// Add a T to the end of the file id, and auto convert it from bitmap
				ResManager.addTexture(cbo.id,Texture.fromBitmap(cbo.data));
			}
			else 
			{
				switch(cbo.ext) {
					// EXTENSIONS
//						ResManager.font[cbo.id] = String(cbo.data);
//						break;
					case AssetsCenter.FNT:
					case AssetsCenter.XML:
						if(cbo.option != null 
							&& cbo.option.hasOwnProperty('convertToModel') && cbo.option.convertToModel) 
						{
							// Add a T to the end of the file id, and auto convert it from bitmap
							this.hasOwnProperty(cbo.id)
							{
								if(cbo.id=="lang")
								{
									LangManager.setData(cbo.data);
								}else
								{
									Configure.getConfig(cbo.id).setData(cbo.data);
//									this[cbo.id].setData(cbo.data);
								}
							}
						}else
						{
							ResManager.addXML(cbo.id,cbo.data);
						}
						break;
					
					case AssetsCenter.JPG:
					case AssetsCenter.PNG:
						ResManager.addBitmap(cbo.id,cbo.data);
						break;
					
					case AssetsCenter.JSN:
						break;
					
					case AssetsCenter.MP3:
						break;
				}
			}
			
			
			if(max == 0) {
//				loadJson();
//				对来自硬盘的文件进行排队(仅AIR）
				var file:File = File.applicationDirectory;
				AssetsLoader.getAssetManager().enqueue(AssetsName.EFFECT_COMU_20050,[file.resolvePath(formatString(AssetsCenter.ASSETS+"effects/20050/",STLConstant.scale))],50);
//					AssetsLoader.getAssetManager().enqueue((50003),[file.resolvePath(formatString(AssetsCenter.ASSETS+"effects/chat/"+(50003),STLConstant.scale))],50);
				var chatPath:String;
				for(var mm:uint = 1; mm<13;mm++)
				{
					chatPath = (50000+mm).toString();
					AssetsLoader.getAssetManager().enqueue(chatPath,[file.resolvePath(formatString(AssetsCenter.ASSETS+"effects/chat/"+chatPath)),STLConstant.scale]);
				}
				
				AssetsLoader.getAssetManager().loadQueue(effectLoaded);
			}
		}
		
		private function effectLoaded(p:Number):void
		{ 
			if(p == 1)
			{
				loadJson();
			}
		}
		
		private function progressHandler(e:ProgressEvent):void
		{
			eventDis.dispatchEvent(new SimpleEvent(EventType.LOADING_INFO,(e.bytesLoaded / e.bytesTotal)));
		}
		
		private function configErrorHandler(e:IOErrorEvent):void
		{
			trace('config xml load error Comand e:',e.toString());
		}
		
//		private function configEnoughHandler(e:Event):void
//		{
//			var fileLoader:FileRetryLoader = e.currentTarget as FileRetryLoader;
//			fileLoader.removeEventListener(Event.COMPLETE, configEnoughHandler);
//			fileLoader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
//			fileLoader.removeEventListener(IOErrorEvent.IO_ERROR, configErrorHandler);
//			
//			var data:Object=fileLoader.data;
//			var xml:XML;
//			if(ReleaseUtil.RELEASE)
//			{
//				var bytes:ByteArray = ByteArray(data);
//				var ob:Object = AssetsCenter.transformJSONToValueObject(bytes)
//				Configure.gameConfig.setDataVO(ob);
//			}else
//			{
//				xml = XML(data);
//				Configure.gameConfig.setData(xml);
//			}
//			
//			ResManager.init(Configure.gameConfig.getSourceDic());
//			
//			loadLoading();
//			
////			return;
//			//加载json配置文件
////			loadJson();
//		}
//		/**
//		 *加载loading界面素材 
//		 * 
//		 */		
//		private function loadLoading():void
//		{
//			var fileLoader:FileRetryLoader = new FileRetryLoader();
//			fileLoader.addEventListener(Event.COMPLETE, loadingEnoughHandler);
//			
//			if(ReleaseUtil.RELEASE)
//			{
//				Tracer.info(AssetsCenter.getLoadingPath()+AssetsCenter.getReleasePath(AssetsCenter.getLoadingPath()))
//				fileLoader.retryLoad(new FileRetryLoaderVO(FileType.BIN,AssetsCenter.getReleasePath(AssetsCenter.getLoadingPath())));
//			}else
//			{
//				fileLoader.retryLoad(new FileRetryLoaderVO(FileType.SWF,AssetsCenter.getFullPath(AssetsCenter.getLoadingPath()),null));
//			}
//		}
		
		private function loadJson():void
		{
			trace("i am from load json!");
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, jsonEnoughHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			
			var urlReq:URLRequest = new URLRequest();
			urlReq.method = URLRequestMethod.GET;
			urlReq.contentType = "application/octet-stream";
			urlReq.url = ExternalVars.getJsonSource() + "?"+Math.random();
			loader.load(urlReq);
		}
		/**
		 * 加载json成功 
		 * @param e
		 * 
		 */		
		private function jsonEnoughHandler(e:Event):void
		{
			var by:ByteArray = e.currentTarget.data;
			var resultStr:String = by.readUTFBytes(by.length);
//			var object:Object = com.adobe.serialization.json.JSON.decode(resultStr);
			var object:Object = JSON.parse(resultStr);
			for(var index:String in object)
			{
				if(index == Configure.TYPE_GUIDE_CONFIG || index==Configure.TYPE_TABLE_CONFIG)continue;
				var configHelper:IConfigHelper = Configure.getConfig(index);
				if(configHelper) 
				{
					configHelper.setJsonData(object[index]);
				}
				else
				{
					Tracer.error("configHelper未找到:"+index)
				}
			}
			trace("i am from finish load json!");
			SignalCenter.onInitialLoadComplete.dispatch();
		}
		
//		private function loadXML(item:ConfigVO):void
//		{
//			var fileLoader:FileRetryLoader = new FileRetryLoader();
//			fileLoader.addEventListener(Event.COMPLETE, xmlEnoughHandler);
//			fileLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
//			
//			if(ReleaseUtil.RELEASE)
//			{
//				Tracer.info('items.length:'+AssetsCenter.getReleasePath(item.link));
//				fileLoader.retryLoad(new FileRetryLoaderVO(FileType.BIN,AssetsCenter.getReleasePath(item.link),null,item));
//			}else
//			{
//				fileLoader.retryLoad(new FileRetryLoaderVO(FileType.XML,AssetsCenter.getFullPath(item.link),null,item));
//			}
//			
//			current++;
//			eventDis.dispatchEvent(new SimpleEvent(EventType.LOADING_NUM_INFO,current +"/" + max));
//			
//			switch(current)
//			{
//				case 10:
//					HttpSendProxy.timestamp(LogType.LOAD_PROGRESS, Math.floor( Number(current / max) * 100 ).toString());
//					break;
//				case 20:
//					HttpSendProxy.timestamp(LogType.LOAD_PROGRESS, Math.floor( Number(current / max) * 100 ).toString());
//					break;
//				case 30:
//					HttpSendProxy.timestamp(LogType.LOAD_PROGRESS, Math.floor( Number(current / max) * 100 ).toString());
//					break;
//				case 40:
//					HttpSendProxy.timestamp(LogType.LOAD_PROGRESS, Math.floor( Number(current / max) * 100 ).toString());
//					break;
//			}
//			
//		}
		
//		private function xmlEnoughHandler(e:Event):void
//		{
//			var fileLoader:FileRetryLoader = e.currentTarget as FileRetryLoader;
//			fileLoader.removeEventListener(Event.COMPLETE, xmlEnoughHandler);
//			fileLoader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
//			Tracer.info('fileLoader.params.id:'+fileLoader.params.id+":"+fileLoader.params.link);
//			var data:Object=fileLoader.data;
//			if(fileLoader.params.id == "language")
//			{
//				if(ReleaseUtil.RELEASE)
//				{
//					bytes = ByteArray(data);
//					LangManager.setDataVO(AssetsCenter.transformJSONToValueObject(bytes));
//				}
//				else
//				{
//					xml = XML(data);
//					LangManager.setData(xml);
//				}
//			}
//			else
//			{
//				var configHelper:IConfigHelper = Configure.getConfig(fileLoader.params.id);
//				if(configHelper)
//				{
//					var xml:XML;
//					var bytes:ByteArray
//					if(ReleaseUtil.RELEASE)
//					{
//						bytes = ByteArray(data);
//						configHelper.setDataVO(AssetsCenter.transformJSONToValueObject(bytes));
//					}
//					else
//					{
//						xml = XML(data);
//						configHelper.setData(xml);
//					}
//				}
//				else
//				{
//					Tracer.error("configHelper未找到:"+fileLoader.params.id)
//				}
//			}
//			
//			if(items.length == 0 )
//			{
//				items = null;
//				
//				//加载json配置文件
//				loadJson();
////				loadSWFAssets();
//			}else
//			{
//				var item:ConfigVO = items.shift();
//				loadXML(item);
//			}
//		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			trace('StartUpLoadXmlComand e:',e.toString());
		}
		
//		private function loadSWFAssets():void
//		{
//			items = Configure.gameConfig.dicSourcePre;
//			
//			var itemSwf:ConfigVO = items.shift();
//			loadSWF(itemSwf);
//		}
//		
//		private function nextSWF():void
//		{
//			if(items.length == 0)
//			{
//				items = null;
//				HttpSendProxy.timestamp(LogType.LOAD_PROGRESS, "100");
//				eventDis.dispatchEvent(new Event(EventType.GAME_START));
//				Tracer.error("swf versions ########:"+_swfVersion+"\n ######");
//			}else
//			{
//				loadSWF(items.shift());
//			}
//		}
		
		/**
		 * 转换二进制 
		 * @param bytes
		 * @param link
		 * 
		 */		
		private function converByteToMC(bytes:ByteArray,param:Object,callBack:Function = null):void
		{
			AssetsCenter.transformBinTOMC(bytes);
			
			var loader:Loader = new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			var lc:LoaderContext = new LoaderContext();
			lc.allowCodeImport = true;
			loader.loadBytes(bytes, lc);
			
			function loaded(e:Event):void
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaded);
				ResManager.addLoaderInfo((param.link),loader.contentLoaderInfo);
				ResManager.addSWF(param.id,loader.contentLoaderInfo);
				Tracer.info(param.link);
				if(callBack)
				{
					callBack.apply(this);
				}
			}
		}
		
		private var _swfVersion:String="";
//		private function loadSWF(item:ConfigVO):void
//		{
//			//			trace('loadSWF:',AssetsCenter.getFullPath(item.@link),movieClipProxy.hasLoaderInfo(AssetsCenter.getFullPath(item.@link)));
//			if(ResManager.hasLoaderInfo(AssetsCenter.getFullPath(item.link)))
//			{
//				nextSWF();
//			}else
//			{
//				var fileLoader:FileRetryLoader = new FileRetryLoader();
//				fileLoader.addEventListener(Event.COMPLETE, swfEnoughHandler);
//				fileLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
//				fileLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
//				if(ReleaseUtil.RELEASE)
//				{
//					_swfVersion+="swf item:"+item.link+":v:"+AssetsCenter.getReleasePath(item.link) + "\n";
//					fileLoader.retryLoad(new FileRetryLoaderVO(FileType.BIN,AssetsCenter.getReleasePath(item.link),new LoaderContext(false,ApplicationDomain.currentDomain),item));
//				}else
//				{
//					fileLoader.retryLoad(new FileRetryLoaderVO(FileType.SWF,AssetsCenter.getFullPath(item.link),new LoaderContext(false,ApplicationDomain.currentDomain),item));
//				}
//			}
//			
//			current++;
//			eventDis.dispatchEvent(new SimpleEvent(EventType.LOADING_NUM_INFO,current +"/" + max));
//			
//			switch(current)
//			{
//				case 10:
//					HttpSendProxy.timestamp(LogType.LOAD_PROGRESS, Math.floor( Number(current / max) * 100 ).toString());
//					break;
//				case 20:
//					HttpSendProxy.timestamp(LogType.LOAD_PROGRESS, Math.floor( Number(current / max) * 100 ).toString());
//					break;
//				case 30:
//					HttpSendProxy.timestamp(LogType.LOAD_PROGRESS, Math.floor( Number(current / max) * 100 ).toString());
//					break;
//				case 40:
//					HttpSendProxy.timestamp(LogType.LOAD_PROGRESS, Math.floor( Number(current / max) * 100 ).toString());
//					break;
//				case 50:
//					HttpSendProxy.timestamp(LogType.LOAD_PROGRESS, Math.floor( Number(current / max) * 100 ).toString());
//					break;
//			}
//		}
	}
}