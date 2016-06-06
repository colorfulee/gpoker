//AssetsCenter.as
//May 24, 2012
//author:jim
//description:
package com.jzgame.common.utils
{
	import com.hurlant.crypto.symmetric.DESKey;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.common.vo.VersionObject;
	import com.jzgame.enmu.ReleaseUtil;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	public class AssetsCenter
	{
		public static var COMMON:String = 'common/';
		public static var ASSETS:String = 'assets/';
		private static var ANIMATION:String = 'swf/';
		private static var LOADING:String = 'loading/';
		private static var SOUND:String = '07/';
		private static var EFFECT:String = 'effect/';
		private static var FACE:String = 'face/';
		public static var IMAGES:String = 'images/';
		public static const XML:String = '.xml';
		public static const FNT:String = '.fnt';
		public static const PNG:String = '.png';
		public static const JPG:String = '.jpg';
		public static const SWF:String = '.swf';
		public static const MP3:String = '.mp3';
		public static const AO:String = '.ao';
		public static const BIN:String = '.bin';
		public static const JSN:String = '.json';
		public static const DOT:String = '.';
		public static var NAME:String = 'AssetsCenter';
		public static var SPLIT:String = ';';
		public static var COMMA:String = ',';
		public static var PLUS:String = '+';
		public static var COLON:String = ':';
		public static var LEFT:String = '/';
		private static var _head:String ="";
		
		public static var TH_TH:String = "th_th";
		public static var ZH_TW:String = "zh_tw";
		public static var EN_US:String = "en_us";
		
		//谷歌自带player解析
		public static var GOOGLE:String = "Google Pepper";
		public static var WINDOWS:String = "Adobe Windows";
		
		public static var eventDispatcher:IEventDispatcher;
		
		public static var myDes:DESKey;//加密算法
		public function AssetsCenter(head:String='',lang:String="en_us")
		{
			_head = head ? head : '';

			switch(lang)
			{
				case TH_TH:
					ASSETS = "assets_th/";
					break;
				case ZH_TW:
					ASSETS = "assets_tw/";
					break;
				default:
					ASSETS = "assets/";
					break;
			}
			init();
		}
		
		private function init():void
		{
			var myKeyStr:String="spellife";
			var myKey:ByteArray=new ByteArray();
			myKey.writeUTFBytes(myKeyStr);
			myDes = new DESKey(myKey); 
		}
		
		public static function getExtFromFilename(filename:String):String {
			var dot:int = filename.indexOf('.');
			return DOT+filename.slice(dot + 1, filename.length);
		}
		/***
		 * Returns a filename from the full path
		 **/
		public static function getFilenameFromPath(path:String):String {
			var pathArr:Array = path.split('/');
			var fileNameArr:Array;
			
			if(pathArr.length > 1)
			{
				fileNameArr = pathArr[pathArr.length - 1].split('.');
			}
			else 
			{
				fileNameArr = pathArr[0].split('.');
			}
			
			return fileNameArr[0];
		}
		
		private function getLoadingPath():String
		{
			var path:String  = ASSETS +'swf/loading.swf';
			
			return getFullPath(path);
		}
		/**
		 * 获取B路径 
		 * @return 
		 * 
		 */		
		public static function getTempBPath():String
		{
			return getFullPath(ASSETS + "01/xinshou_icon_playerB.png");
		}
		
		/**
		 * 获取A路径 
		 * @return 
		 * 
		 */		
		public static function getTempAPath():String
		{
			return getFullPath(ASSETS + "01/xinshou_icon_playerA.png");
		}
		/**
		 * 获取config路径 
		 * @return 
		 * 
		 */		
		public static function getConfigPath():String
		{
			return ASSETS + 'json/initialAssets'+ JSN;
		}
		/**
		 * 获取main loading路径 
		 * @return 
		 * 
		 */		
		public static function getLoadingPath():String
		{
			return ASSETS + "02/20030.swf";
		}
		
		/**
		 * 获取声音路径 
		 * @param id
		 * @return 
		 * 
		 */		
		public static function getSoundPath(id:String):String
		{
			return ASSETS+SOUND+id + MP3;
		}
		/**
		 * 转换成xml
		 * @param bytes
		 * @return 
		 * 
		 */		
		public static function transformBinToXML(bytes:ByteArray):String
		{
			bytes.position = 0;
			myDes.decrypt(bytes, 0);
			bytes.uncompress();
			
			return  (bytes.readUTFBytes(bytes.length));
		}
		/**
		 * 转换成json
		 * @param bytes
		 * @return 
		 * 
		 */		
		public static function transformJSONToValueObject(bytes:ByteArray):Object
		{
			bytes.position = 0;
			myDes.decrypt(bytes, 0);
			bytes.uncompress();
			var string:String = bytes.readUTFBytes(bytes.length);
			Tracer.info(string);
			return JSON.parse(string);
		}
		/**
		 * 转换成vo 
		 * @param bytes
		 * @return 
		 * 
		 */		
		public static function transformBinToValueObject(bytes:ByteArray):Object
		{
			bytes.position = 0;
			myDes.decrypt(bytes, 0);
			bytes.uncompress();
			
			return  (bytes.readObject());
		}
		/**
		 *  
		 * @param bytes
		 * @return 
		 * 
		 */		
		public static function transformBinToBitmap(bytes:ByteArray):void
		{
			bytes.position = 0;
			myDes.decrypt(bytes, 0);
			bytes.uncompress();
		}
		/**
		 * 解析二进制转化成bitmap 
		 * @param bytes
		 * @param callBack
		 * 
		 */		
		public static function converByteToBitmap(bytes:ByteArray, callBack:Function = null):void
		{
			var loader:Loader = new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			var lc:LoaderContext = new LoaderContext();
			lc.allowCodeImport = true;
			loader.loadBytes(bytes, lc);
			function loaded(e:Event):void
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaded);
				if(callBack != null)
				{
					callBack.apply(null,[(loader.content as Bitmap).bitmapData]);
				}
			}
		}
		/**
		 * 
		 * @param bytes
		 * @return 
		 * 
		 */		
		public static function transformBinTOMC(bytes:ByteArray):ByteArray
		{
			bytes.position = 0;
			myDes.decrypt(bytes, 0);
			bytes.uncompress();
			
			return bytes;
		}
		/**
		 * 变更发布版本的路径修改
		 * @param path
		 * @return 
		 * 
		 */		
		public static function getReleasePath(path:String):String
		{
//			var lead:Array = path.split('/');
//			var name:String = lead[lead.length - 1];
//			var format:Array = name.split('.');
//			switch('.'+format[1])
//			{
//				case XML:
//					path = path.replace(XML,BIN);
//					break;
//				case SWF:
//					path = path.replace(SWF,AO);
//					break;
//			}
			var pathVO:VersionObject = VersionDic.getInstance().getPathVO(path);
			if(pathVO)
				path = pathVO.newPath;
//			Debug.log('getReleasePath:'+_head + path);
			return _head + path;
		}
		/**
		 * 获取全路径 
		 * @param path
		 * @return 
		 * 
		 */		
		public static function getFullPath(path:String):String
		{
//			var pathVO:VersionObject = VersionDic.getInstance().getPathVO(path);
//			if(pathVO)
//			path = pathVO.newPath;
			return _head + path;
		}
		
		/**
		 * 获取路径
		 * @param value
		 * @return 
		 * 
		 */		
		public static function getStrongEffectPath():String
		{
			var path:String = ASSETS + ANIMATION + EFFECT + 'energyShot' + SWF;
			return getFullPath(path);
		}
		
		/**
		 * 获取金币路径
		 * @param value
		 * @return 
		 * 
		 */		
//		public static function getCoinPathById(value:String):String
//		{
//			var path:String = ASSETS + ANIMATION + COIN + value + SWF;
//			return (path);
//		}
		/**
		 * 根据性别获取头像路径 
		 * @param value
		 * @return 
		 * 
		 */		
		public static function getFacePathBySex(value:String):String
		{
			var path:String = ASSETS + IMAGES + FACE + value + JPG;
			return getFullPath(path);
		}
		/**
		 * 获取声音路径
		 * @param value
		 * @return 
		 * 
		 */		
		public static function getSoundPathById(value:String):String
		{
			var path:String = ASSETS + SOUND + value + MP3;
			return getFullPath(path);
		}
		
		public static var FB_FACE_LARGE:String = "large";
		public static var FB_FACE_NORMAL:String = "normal";
		public static var FB_FACE_SMALL:String = "small";
		public static var FB_FACE_SQUARE:String = "square";
		/**
		 * 
		 * @param type
		 * @return 
		 * 
		 */		
		public static function getFBFace(id:String,type:String="large"):String
		{
			if(!ReleaseUtil.RELEASE)
			{
				return COMMON + IMAGES + "pokerJ_icon.png";
			}
			var url:String = "https://graph.facebook.com/"+id+"/picture?type="+type;
			if(id=="" || id=="0") return COMMON + IMAGES + "pokerJ_icon.png";
//			https://graph.facebook.com/{facebookId}/picture?type=square
			return ( url );
		}
		/**
		 * 获取一般替代头像 
		 * @return 
		 * 
		 */		
		public static function getCommonFace():String
		{
			return COMMON + IMAGES + "pokerJ_icon.png";
		}
		/**
		 * 获取道具图片地址
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getImagePath(name:String):String
		{
			return (ASSETS + "04/" +name + PNG);
		}
		
		public static function getDyImagePath(name:String):String
		{
			return (ASSETS + IMAGES +name + JPG);
		}
		
		/**
		 * 获取礼物素材地址
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getGiftPath(name:String):String
		{
			return (ASSETS + "10/" + name + SWF);
		}
		/**
		 * 获取FB主页 
		 * @param id
		 * @return 
		 * 
		 */		
		public static function getFBPage(id:String):String
		{
			return "https://www.facebook.com/"+id;
		}
		public static function getLaunchImagePath(img:String):String
		{
			return ASSETS + 'launch/' + img;
		}
		
		/**
		 *
		 * @param id
		 * @return
		 *
		 */
		static public function findPathById(id:String):String
		{
			var list:Array = id.split(ResManager.OPERATE);
			var fl:String = list[0];
			if (fl.length < 6)
			{
				fl="0" + fl;
			}
			
			var folder:String = fl.substr(0, 2);
			return ASSETS + folder + "/" + list[0] + SWF;
		}
	}
}