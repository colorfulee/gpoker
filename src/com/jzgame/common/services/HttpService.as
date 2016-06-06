package com.jzgame.common.services
{
	import com.hurlant.util.Hex;
	import com.jzgame.common.services.http.AES;
	import com.jzgame.common.services.http.CRC32;
	import com.jzgame.common.services.http.HttpRequest;
	import com.jzgame.common.services.http.HttpResponse;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.logging.Tracer;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	/**
	 * @example:
	 * ------发送-------
	 * var requestVo:HttpRequest = new HttpRequest();
	 * requestVo.name = "player.login";
	 * requestVo.data = [userid,xxxx,xxxx,xxx];
	 * requestVo.responseEvent = HttpResponseEvent.LOGIN;
	 * dispatcher.dispatchEvent(new HttpRequestEvent(HttpRequestEvent.HTTP_REQUEST, requestVo));
	 * 
	 * ------接收-------
	 * 方法一:
	 * addContextListener(HttpResponseEvent.LOGIN, httpResponseHandler);
	 * function httpResponseHandler(event:HttpResponseEvent):void
	 * {
	 *      var responseVo:HttpResponse = event.data;
	 * 		responseVo.xxxx;
	 * }
	 * 
	 * 方法二:
	 * 自己在HttpRequest加callBack方法
	 * 
	 * 
	 * 方法三:
	 * 使用工具解析协议文档后自动生成强类型Reqeust和Response对象
	 * 
	 * 
	 * @author Rakuten
	 *
	 */
	public class HttpService
	{
		//==========================================================================
		//  Class variables
		//==========================================================================
		//不能少于16个字符
//		private static const AES_KEY:String = "hellohellohelloo";
		//    private static const AEK_IV:String = "912467427aa54cccf443d2ae206a63ce";  //仅供调式用
		private static const MAGIC_WORD:uint = 0x668866aa;
		//	private static const REQUEST_URL:String = "";
		
		//==========================================================================
		//  Constructor
		//==========================================================================
		/**
		 * Constructs a new <code>HttpService</code> instance.
		 * 
		 */
		public function HttpService()
		{
//			encryptKey = Hex.toArray(AES_KEY);
			encryptKey = getKey();
			clientVer = ExternalVars.clientVersion
		}
		
		//==========================================================================
		//  Variables
		//==========================================================================
		
		[Inject]
		public var dispatcher:IEventDispatcher;
		
//		[Inject]
//		public var userProxy:UserModel;
		
		public var requestId:uint = 1;
		//    public var token:String = "";
		
		private var clientVer:String = "1.0.0.b";
		
		private var loaderLib:Dictionary = new Dictionary();
		
		private var crc32:CRC32 = new CRC32();
		
		public var userId:uint;
		public var token:String = "";
		public var gateway:String = "";
		
		//==========================================================================
		//  Methods
		//==========================================================================
		/**
		 * ios:A
		 * web:B
		 * android:D
		 */	
//		private function getClientVer():String
//		{
//			var nativeOperationSystem:String=flash.system.Capabilities.os;
//			nativeOperationSystem=nativeOperationSystem.toUpperCase();
//			var result:String = clientVer;
//			if(nativeOperationSystem.indexOf("IPHONE")>=0)
//			{
////			trace("这是爱疯");
//				result += ".a";
//			}
//			else if(nativeOperationSystem.indexOf("ANDROID")>=0)
//			{
////			trace("这是安卓");
//				result += ".d";
//			}
//			else if(nativeOperationSystem.indexOf("WINDOWS")>=0)
//			{
////			trace("这是windows系列");
//				result += ".b";
//			}
//			else if(nativeOperationSystem.indexOf("MAC")>=0)
//			{
////			trace("这是mac系列");
//				result += ".b";
//			}
//			return result;
//		}
		public function send(vo:HttpRequest):void
		{
			if(gateway == "")return;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, loader_completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_securityErrorHandler);
			loaderLib[loader] = vo;
			
			var urlReq:URLRequest = new URLRequest();
			urlReq.method = URLRequestMethod.POST;
			var dataStr:String = createRequestJson(vo);
			urlReq.data = encryptData(dataStr);
			urlReq.contentType = "application/octet-stream";
			urlReq.url = gateway;
			loader.load(urlReq);
			if(vo.name !=MessageType.HEART)
			{
				Tracer.info("--->http 发送请求:"+vo.name+"::data:"+dataStr);
			}
		}
		
		private function removeListener(loader:URLLoader):void
		{
			loader.addEventListener(Event.COMPLETE, loader_completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_securityErrorHandler);
//			loaderLib[loader] = null;
			delete loaderLib[loader];
		}
		
		private function createRequestJson(vo:HttpRequest):String
		{
			var data:* = {s: [vo.name].concat(vo.data),
				h: [userId, token, requestId++, clientVer, ExternalVars.cdnVersion]};
			return JSON.stringify(data);
		}
		
		static private var encryptKey:ByteArray; 
		/**
		 * 将明文数据加密 
		 * @param dataStr json字符串
		 * @return 
		 */	
		private function encryptData(dataStr:String):ByteArray
		{
//			var key : ByteArray = Hex.toArray(AES_KEY);
//			var iv : ByteArray = Hex.toArray(AEK_IV);
//			var key:ByteArray = AES.generateKey(AES_KEY);//AES.DEFAULT_CIPHER_NAME
			var iv:ByteArray = AES.generateIV(AES.DEFAULT_CIPHER_NAME, encryptKey);
			var ivStr:String = Hex.fromArray(iv);
			
			var dataBy:ByteArray = new ByteArray();
			//		dataBy.writeUTF(dataStr);  //数据
			dataBy.writeUTFBytes(dataStr);
			crc32.reset();
			crc32.update(dataBy,0);
			var crcValue:uint = crc32.getValue();
			dataBy.writeUnsignedInt(crcValue);
			dataBy.writeByte(0);		//压缩
			dataBy.writeMultiByte("ok","ASCII");	//Success Flag
			var sourceLen:uint = dataBy.length;		//明文数据长度
			var aes:AES = new AES(encryptKey, iv, AES.DEFAULT_CIPHER_NAME, "null");
			//        var encryptBy:ByteArray = aes.encryptString(dataStr);
			var encryptBy:ByteArray = aes.encrypt(dataBy);
			//		trace(encryptBy.toString())
			var by:ByteArray = new ByteArray();
			by.writeUnsignedInt(MAGIC_WORD); // magic word
			by.writeByte(encryptBy.length - sourceLen); //PaddingLength
			by.writeByte(sourceLen >> 16);
			by.writeShort(sourceLen & 0xFFFF);
			//			by.writeUTF(dataStr);
			by.writeBytes(encryptBy);
			by.writeBytes(iv);
			iv.clear();
			encryptBy.clear();
			dataBy.clear();
			return by;
		}
		
		/**
		 * 解密 
		 * @return json类型对象
		 */	
		private function decryptData(by:ByteArray,requestName:String):*
		{
			by.position = 0;
			var magicWord:String = by.readUnsignedInt().toString(16);  // magic word
			
			var paddingLength:uint = by.readByte(); //PaddingLength
			
			var temp1:uint = by.readByte();
			var temp2:uint = by.readShort();
			var dataLength:uint =  temp1 << 16 | temp2;  //Data Length
			
			var dataBy:ByteArray = new ByteArray();
			dataBy.writeBytes(by, by.position, dataLength+paddingLength);
			by.position += dataLength+paddingLength;
			
			var iv:ByteArray = new ByteArray();
			iv.writeBytes(by, by.position, 16);
			
			//			var iv : ByteArray = Hex.toArray(AEK_IV);
			//			var key:ByteArray = AES.generateKey(AES_KEY);//AES.DEFAULT_CIPHER_NAME
			var aes : AES = new AES(encryptKey, iv, AES.DEFAULT_CIPHER_NAME, "null");
			dataBy.position = 0;
			var result:String;
			
			try
			{
				result = parseResultData(aes.decrypt(dataBy), paddingLength);
				if(requestName != MessageType.HEART && requestName != MessageType.PLAYER_INIT)
				{
					Tracer.info("------HttpService返回数据------请求接口:"+requestName+",返回数据:"+result);
				}
			}
			catch (e:Error)
			{
				Tracer.error("------HttpService数据解析出错!!!------");
//				dispatcher.dispatchEvent(new HttpResponseEvent(HttpResponseEvent.HTTP_RESPONSE_DECODE_ERROR, null, null));
			}
			
			iv.clear();
			dataBy.clear();
			by.clear();
			var obj:*;
			try
			{
				obj = JSON.parse(result);
			}
			catch (e:Error)
			{
				Tracer.error("------HttpService JSON解析出错!!!------");
//				dispatcher.dispatchEvent(new HttpResponseEvent(HttpResponseEvent.HTTP_RESPONSE_PARSE_ERROR, null, null));
			}
			return obj;
		}
		
		/**
		 * 对数据进行CRC32验证及解压缩 
		 * @param by
		 * @return 
		 */	
		private function parseResultData(by:ByteArray, paddingLength:uint):String
		{
			by.position = 0;
			by.length -= paddingLength;
			var dataLen:Number = by.length - 7; //CRC32+zip+flag 总计7字节
			var dataBy:ByteArray = new ByteArray();
			dataBy.writeBytes(by, 0, dataLen);
			dataBy.position = 0;
			by.position = dataLen;
			var crcValue:uint = by.readUnsignedInt();
			if (by.readByte() == 1)
			{
				dataBy.uncompress();
			}
			//		var resultStr:String = dataBy.readUTF();
			var resultStr:String = dataBy.readUTFBytes(dataBy.length);
			var okFlag:String = by.readMultiByte(2,"ACSII");
			dataBy.clear();
			return resultStr;
		}
		
		private function getKey():ByteArray
		{
//		var key : ByteArray = Hex.toArray(AES_KEY);
			var key:ByteArray = new ByteArray();
			key.writeMultiByte("hellohellohelloo","ascii");
			return key;
		}
		//==========================================================================
		//  Event Handlers
		//==========================================================================
		protected function loader_completeHandler(event:Event):void
		{
			var by:ByteArray = event.currentTarget.data;
			var request:HttpRequest = HttpRequest(loaderLib[event.currentTarget])
			//		trace("-----HttpServic:收到数据返回,"+resultData+"-----");
//			if(request.name != MessageType.HEART)
//			{
//				Tracer.info("-----HttpServic:收到数据返回,请求接口:"+request.name+",发送的参数:"+request.data);
//			}
			var resultData:* = decryptData(by,request.name)
			var responseData:HttpResponse = new HttpResponse(resultData);
			
			dispatcher.dispatchEvent(new HttpResponseEvent(HttpResponseEvent.HTTP_RESPONSE_RECEIVE, request, responseData));
			if(uint(responseData.e) > 0)
			{
//				eventDisp.dispatchEvent(new SimpleEvent(EventType.ERROR_CODE_WINDOW,uint(responseData.e)));
//				dispatcher.dispatchEvent(new HttpResponseEvent(HttpResponseEvent.HTTP_RESPONSE_ERROR_CODE, request,responseData));
			}else if(responseData.hasOwnProperty("m"))
			{
				//如果直接返回error信息
				Tracer.info("=====http error=====:"+responseData.m);
//					eventDisp.dispatchEvent(new SimpleEvent(EventType.ERROR_CODE_WINDOW,String(responseData.m)));
//				dispatcher.dispatchEvent(new HttpResponseEvent(HttpResponseEvent.HTTP_RESPONSE_ERROR_CODE, request,responseData));
			}
			else
			{
				//成功收到数据返回
				dispatcher.dispatchEvent(new HttpResponseEvent(request.name, request, responseData));
			}
			removeListener(event.currentTarget as URLLoader);
		}
		
		private function loader_securityErrorHandler(event:SecurityErrorEvent):void
		{
			Tracer.error("----HttpService:安全策略错误，无法连接远程服务器-----");
//			dispatcher.dispatchEvent(new HttpResponseEvent(HttpResponseEvent.HTTP_RESPONSE_SECRITY_ERROR, null, null));
			removeListener(event.currentTarget as URLLoader);
		}
		
		private function loader_ioErrorHandler(event:IOErrorEvent):void
		{
			Tracer.error("------HttpService:无法连接服务器------");
//			dispatcher.dispatchEvent(new HttpResponseEvent(HttpResponseEvent.HTTP_RESPONSE_IO_ERROR, null, null));
			removeListener(event.currentTarget as URLLoader);
		}
	}
}