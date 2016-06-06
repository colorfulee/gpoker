package com.jzgame.loader
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.display.ContentDisplay;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.vo.ConfigVO;
	
	import org.osflash.signals.Signal;

	public class FileLoader
	{
		/***********
		 * name:    FileLoader
		 * data:    Nov 10, 2015
		 * author:  jim
		 * des:
		 ***********/
		private static var instance:FileLoader;
		
		public var queue:LoaderMax;
		
		/**
		 * holds an array of objects
		 */
		private var callBackArray:Array;
		
		public var onProgress:Signal;
		public var onComplete:Signal;
		public function FileLoader()
		{
			if(!instance)
			{
				initQueue();
			}
		}
		
		public static function getInstance():FileLoader
		{
			if(!instance)instance = new FileLoader;
			return instance;
		}
		
		private function initQueue():void  {
			onProgress = new Signal();
			onComplete = new Signal();
			queue =  new LoaderMax({name:"mainQueue", 
				onProgress:onProgressHandler, 
				onComplete:onCompleteHandler, 
				onError:onErrorHandler,
				autoLoad:true
			});
			callBackArray = [];
		}
		/**
		 * 添加加载队列 
		 * @param path
		 * @param cb
		 * @param id
		 * @param includeAssetPath
		 * @param startQueueLoad
		 * @param opts
		 * 
		 */		
		public function addToLoad(path:String, cb:Function, id:String = '', includeAssetPath:Boolean = true, startQueueLoad:Boolean = true, opts:Object = null):void  {
			var fileName:String = AssetsCenter.getFilenameFromPath(path);
			var ext:String = AssetsCenter.getExtFromFilename(path);
			
			// if id was not supplied, use the filename minus extension
			if(id == '') {
				id = fileName;
			}
			
			// Set up the fullPath for the asset
			var fullPath:String = AssetsCenter.getFullPath(path);
			
			var useRawContent:Boolean = false;
			if(ext == AssetsCenter.PNG
				|| ext == AssetsCenter.JPG 
				) {
				useRawContent=true;
			}
			
			// handle callback queue
			callBackArray.push({ 'fileName': fileName, 
				'cb': cb,
				'id': id,
				'useRawContent': useRawContent,
				'options': opts,
				'ext':ext
			});
			
//			Config.log(className, 'addToLoad', "Adding callback function for " + path + " to callBackArray index: " + (callBackArray.length - 1 ).toString());
//			Config.log(className, 'addToLoad', "FileName: " + fileName + " || FullPath: " + fullPath + " || ext: " + ext);
			
			switch(ext) {
				// EXTENSIONS
				case AssetsCenter.XML:
				case AssetsCenter.FNT:
					queue.append(new XMLLoader(fullPath, {'name':id}));
					break;
				
				case AssetsCenter.JPG:
				case AssetsCenter.PNG:
					queue.append(new ImageLoader(fullPath, {'name':id}));
					break;
				
				case AssetsCenter.JSN:
					queue.append(new DataLoader(fullPath, {'name':id}));
					break;
				
				case AssetsCenter.MP3:
					queue.append(new MP3Loader(fullPath, {'name':id, 'autoPlay': false}));
					break;
			}
			
			if(startQueueLoad) {
				queue.load();
			}
		}
		
		/***
		 * Process data and make sure loaded items get sent back to proper callbacks
		 **/
		public function onCompleteHandler(event:LoaderEvent):void {
//			Config.log(className, 'onCompleteHandler', "Beginning to process " + event.target);
			
			// Array of Objects used to temporarily store things that have not fully been loaded yet 
			// and are not ready for callback
			var nextPassArray:Array = [];
			
			// item will hold the data from callBackArray that we're processing
			var item:Object;
			
			while(callBackArray.length > 0)  {
				// remove the item from the array so we dont try to process it again
				// save it in item so we can process it there
				item = callBackArray.shift();
				
//				Config.log(className, 'onCompleteHandler', "Processing fileName: " + item.id);
				
				// holds the content we've just loaded. may be an image (ContentDisplay) or xml or other data type
				var contentData:* = queue.getContent(item.id);
				
				// if contentData has not loaded yet, save the item and continue
				if((contentData is ContentDisplay && contentData.rawContent == undefined) || contentData == undefined) 
				{
//					Config.log(className, 'onCompleteHandler', "Moving " + item.id + " to the Next Pass");
					nextPassArray.push(item);
				} 
				else 
				{
					var data:*;
					if(item.useRawContent) {
						data = contentData.rawContent;
					} else {
						data = contentData;
					}
					item.cb(new ConfigVO(item.id, data, item.options,item.ext));
				}
			}
			
			callBackArray = nextPassArray;
			
			if(callBackArray.length == 0) {
				onComplete.dispatch();
//				Config.log(className, 'onCompleteHandler', event.target + " is complete!");
			}
		}
		
		public function onProgressHandler(event:LoaderEvent):void {
//			Config.log(className, 'onProgressHandler', "progress: " + event.target.progress);
			onProgress.dispatch(event.target.progress);
		}
		
		public function onErrorHandler(event:LoaderEvent):void {
			trace('onErrorHandler', "error occured with " + event.target + ": " + event.text);
//			Config.logError(className, 'onErrorHandler', "error occured with " + event.target + ": " + event.text);
		}
	}
}