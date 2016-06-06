package com.jzgame.command
{
	import com.jzgame.common.events.SimpleEvent;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.enmu.EventType;
	import com.jzgame.enmu.ReleaseUtil;
	import com.jzgame.events.HandleDynamicSWFLoadCompleteEvent;
	import com.spellife.display.FileRetryLoader;
	import com.spellife.display.FileType;
	import com.spellife.vo.FileRetryLoaderVO;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandleSWFLoadCommand extends Command
	{
		/*auther     :jim
		* file       :HandleSWFLoadCommand.as
		* date       :Apr 16, 2015
		* description:动态加载swf的执行
		*/
		[Inject]
		public var event:HandleSWFLoadEvent;
		[Inject]
		public var eventDis:IEventDispatcher;
		public function HandleSWFLoadCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if(ResManager.hasLoaderInfo(AssetsCenter.getFullPath(event.sourceLink)))
			{
				eventDis.dispatchEvent(new HandleDynamicSWFLoadCompleteEvent(event.sourceId));
			}else
			{
				var fileLoader:FileRetryLoader = new FileRetryLoader();
				fileLoader.addEventListener(Event.COMPLETE, swfEnoughHandler);
				fileLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				fileLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				if(ReleaseUtil.RELEASE)
				{
					fileLoader.retryLoad(new FileRetryLoaderVO(FileType.BIN,AssetsCenter.getReleasePath(event.sourceLink),new LoaderContext(false,ApplicationDomain.currentDomain),event));
				}else
				{
					fileLoader.retryLoad(new FileRetryLoaderVO(FileType.SWF,AssetsCenter.getFullPath(event.sourceLink),new LoaderContext(false,ApplicationDomain.currentDomain),event));
				}
			}
			
//			current++;
			eventDis.dispatchEvent(new SimpleEvent(EventType.LOADING_NUM_INFO,1 +"/" + 1));
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			trace('HandleSWFLoadCommand e:',e.toString());
		}
		
		private function swfEnoughHandler(e:Event):void
		{
			var fileLoader:FileRetryLoader = e.currentTarget as FileRetryLoader;
			fileLoader.removeEventListener(Event.COMPLETE, swfEnoughHandler);
			fileLoader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			fileLoader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			if(ReleaseUtil.RELEASE)
			{
				converByteToMC(fileLoader.data as ByteArray,fileLoader.params);
			}else
			{
				ResManager.addLoaderInfo((fileLoader.params.sourceLink),fileLoader.loaderInfo);
				ResManager.addSWF(fileLoader.params.sourceId,fileLoader.loaderInfo);
				
				eventDis.dispatchEvent(new HandleDynamicSWFLoadCompleteEvent(fileLoader.params.sourceId));
			}
//			nextSWF();
		}
		
		/**
		 * 转换二进制 
		 * @param bytes
		 * @param link
		 * 
		 */		
		private function converByteToMC(bytes:ByteArray,param:Object):void
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
				ResManager.addLoaderInfo((param.sourceLink),loader.contentLoaderInfo);
				ResManager.addSWF(param.sourceId,loader.contentLoaderInfo);
				
				eventDis.dispatchEvent(new HandleDynamicSWFLoadCompleteEvent(param.sourceId));
			}
		}
		
		private function progressHandler(e:ProgressEvent):void
		{
			eventDis.dispatchEvent(new SimpleEvent(EventType.LOADING_INFO,(e.bytesLoaded / e.bytesTotal)));
		}
	}
}