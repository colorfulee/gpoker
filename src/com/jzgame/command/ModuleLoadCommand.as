package com.jzgame.command
{
	import com.jzgame.common.events.ModuleEvent;
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.loader.FileLoader;
	import com.jzgame.util.WindowFactory;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ModuleLoadCommand extends Command
	{
		public function ModuleLoadCommand()
		{
			super();
		}
		
		[Inject]
		public var event:ModuleEvent;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var moduleName:String;
		
		override public function execute():void
		{
			moduleName = event.moduleName;
			loadResource();
		}
		
		private function loadResource():void
		{
			WindowFactory.addPopUpWindow(WindowFactory.LOAD_RESOURCE);
			if(ReleaseUtil.RELEASE)
			{
				FileLoader.getInstance().addToLoad(AssetsCenter.getReleasePath(moduleName),completeHandler);
			}else
			{
				FileLoader.getInstance().addToLoad(AssetsCenter.getFullPath(moduleName),completeHandler);
			}
			eventDispatcher.dispatchEvent(new SimpleEvent(EventType.LOADING_NUM_INFO,1 +"/" + 1));
		}
		
		private function completeHandler(event:Event):void
		{
//			PopUpWindowManager.removePopUpWindow(PopUpWindowManager.getWindow(WindowFactory.LOAD_RESOURCE));
			var display:DisplayObject;
//			if(ReleaseUtil.RELEASE)
//			{
//				converByteToMC(fileLoader.data as ByteArray,display);
//			}else
//			{
//				display = (event.currentTarget as FileRetryLoader).loaderInfo.content;
//				var moduleEvent:ModuleEvent = new ModuleEvent(ModuleEvent.MODULE_LOAD_COMPLETE);
//				moduleEvent.moduleName = moduleName;
//				moduleEvent.module = display;
//				eventDispatcher.dispatchEvent(moduleEvent);
//			}
//			eventDispatcher.dispatchEvent( new SimpleEvent(EventType.SHOW_LUCKY_WHEEL_GAME,display));
			event
		}
		
		/**
		 * 转换二进制 
		 * @param bytes
		 * @param link
		 * 
		 */		
		private function converByteToMC(bytes:ByteArray,display:DisplayObject):void
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
				display = loader.contentLoaderInfo.content;
				
				var moduleEvent:ModuleEvent = new ModuleEvent(ModuleEvent.MODULE_LOAD_COMPLETE);
				moduleEvent.moduleName = moduleName;
				moduleEvent.module = display;
				eventDispatcher.dispatchEvent(moduleEvent);
			}
		}
		
		private function progressHandler(event:ProgressEvent):void
		{
			eventDispatcher.dispatchEvent(new SimpleEvent(EventType.LOADING_INFO,(event.bytesLoaded / event.bytesTotal)));
		}
	}
}