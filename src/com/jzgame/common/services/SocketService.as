package com.jzgame.common.services
{
	import com.jzgame.common.services.protobuff.ProtocalMessage;
	import com.jzgame.common.services.socket.NetPackageUnit;
	import com.jzgame.common.services.socket.SocketServiceEvent;
	import com.jzgame.common.utils.logging.Tracer;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.ObjectEncoding;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	
	public class SocketService
	{
		private var _host:String;  
		private var _port:uint;  
		private var _socket:Socket;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
//		[Inject]
//		public var netReceivedPackUnitModel:NetReceivedPackUnitModel;
		
		/**
		 * 连接主机端口 
		 * @param host
		 * @param port
		 * 
		 */		
		public function connect(host:String, port:uint = 80):void
		{
			_host = host;  
			_port = port;  
			_socket = new Socket();
			_socket.objectEncoding = ObjectEncoding.AMF3;            
			Security.loadPolicyFile("xmlsocket://" + host + ":" + port);  
			_socket.addEventListener(Event.CONNECT, handler);
			_socket.addEventListener(Event.CLOSE, handler);  
			_socket.addEventListener(IOErrorEvent.IO_ERROR, handler);  
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handler);  
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, handler);  
			
			_socket.connect(host, port); 
		}
		/**
		 * 主机
		 * @return 
		 * 
		 */
		public function get host():String 
		{  
			return _host;  
		}
		/**
		 * 端口
		 * @return 
		 * 
		 */          
	    public function get port():uint 
		{  
	        return _port;  
	    }  
		/**
		 * 是否连接 
		 * @return 
		 * 
		 */         
        public function get connected():Boolean 
		{  
			if(!_socket)return false;
	        return _socket.connected;  
	    }
		/**
		 * 关闭连接 
		 * 
		 */		
		public function close():void 
		{
			if(_socket.connected)
			{
				_socket.close();
			}
			_socket.removeEventListener(Event.CONNECT, handler);  
			_socket.removeEventListener(Event.CLOSE, handler);  
			_socket.removeEventListener(IOErrorEvent.IO_ERROR, handler);  
			_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handler);  
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA, handler);  
		}
		/**
		 * 发送消息 
		 * @param params
		 * 
		 */		
		public function send(params:ByteArray):void 
		{  
			if(!connected || params == null) return;
			if(params)
			{
				_socket.writeBytes(params);  
				_socket.flush();
			}else
			{
				throw new Error('send error');
			}
		}
		
		private var bytes:ByteArray = new ByteArray;
		
		private var length:Number = 0;
		/**
		 * 查找头 
		 * 
		 */		
		private function findLength():void
		{
			bytes.position = 0;
			
			bytes.readByte();
			bytes.readByte();
			bytes.readByte();
			//8 bytes + ProtocalMessage 
			
			//8 bytes中取4-7bytes为消息长度，前3个byte以及最后一个byte为保留字节，每次产生随机数以作混淆。
			
			length = bytes.readUnsignedInt();
			
			length = length ^ -226834058;
			
			trace("length:",length,"bytes.bytesAvailable:",bytes.bytesAvailable);
		}
		/**
		 *接收到消息 
		 * 
		 */		
		private function received():void 
		{
			var byte:ByteArray = new ByteArray;
//			var string:String ="8, -23, 7, 16, 0, 26, 51, 10, 2, 8, 0, 18, 45, 8, -22, 7, 18, 0, 24, -36, 11, 34, 9, -23, -67, -112, -27, -123, -117, -27, -123, -74, 40, 2, 48, 2, 56, 0, 64, 0, 72, 0, 80, 0, 88, 1, 96, 0, 106, 8, -27, -100, -80, -27, -99, -128, 49, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0";
//			var arr:Array = string.split(", ");
//			for(var i:uint = 0; i<arr.length;i++)
//			{
//				
//			}
//			trace(arr.length);
//			var receivemessage:ProtocalMessage = new ProtocalMessage();
//			receivemessage.id  =  1001;
//			receivemessage.errorcode = 0;
//			var tt:String = "dfafdasfdsfdsfsafsadfsdssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss";
//			var byte:ByteArray = new ByteArray;
//			byte.writeUTF(tt);
//			receivemessage.content = byte;
//			
//			var temp:ByteArray = new ByteArray;
//			receivemessage.writeTo(temp);
//			
//			var t:ProtocalMessage = new ProtocalMessage;
//			t.mergeFrom(temp);
//			return;
//			bytes.endian = Endian.LITTLE_ENDIAN;
			if (_socket.bytesAvailable > 0) {
				Tracer.info("_socket.bytesAvailable:"+_socket.bytesAvailable);
				//设置指针为初始位置，否则bytesAvailable属性则会不正确
				//为什么不用长度,因为如果读取了字节，长度不会自动减少
				_socket.readBytes(bytes, bytes.length, _socket.bytesAvailable); 
			}
			
			if(length == 0)
			{
				findLength();
			}
			
			if(length < NetPackageUnit.MSG_HEADER_LENGTH) return;
			//避免粘包,长度不包括头
			while(bytes.length >= (length + 8))
			{
				bytes.position = 0;
				var store:ByteArray = new ByteArray;
				bytes.readBytes(store,0,length + 8);
				var receivemessage:ProtocalMessage = new ProtocalMessage();
				//protocol buffer 解析会出问题，所以要把长度让出来
				store.position = 8;
				//bytes.position = 0;
				receivemessage.mergeFrom(store);
				eventDispatcher.dispatchEvent(new SocketServiceEvent(SocketServiceEvent.SOCKET_RECEIVED,receivemessage));
				var temp:ByteArray = new ByteArray;
				//把粘包的保存下来
				bytes.readBytes(temp,0,bytes.bytesAvailable);
				bytes = temp;
//				trace("receive if there is more data after read:",bytes.bytesAvailable,",length:",bytes.length);
				if(bytes.bytesAvailable != 0)
				{
					findLength();
//					bytes.position = 0;
//					length = bytes.readUnsignedInt();
				}else
				{
					length = 0;
					break;
				}
			}
//			bytes.position = 0;
//			var store:ByteArray = new ByteArray;
//			bytes.readBytes(store,0,length + 4);
//			var temp:ByteArray = new ByteArray;
//			//把粘包的保存下来
//			bytes.readBytes(temp,0,bytes.bytesAvailable);
//			bytes = temp;
//			length = 0;
			
//			var receivemessage:ProtocalMessage = new ProtocalMessage();
//			//bytes.position = 0;
//			receivemessage.mergeFrom(store);
////			bytes = new ByteArray;
//			eventDispatcher.dispatchEvent(new SimpleEvent(EventType.SOCKET_RECEIVED,receivemessage));
			
//			var command:ByteArray = new ByteArray;
//			bytes.writeUnsignedInt(45);
//			bytes.position = 0;
//			var newA:ByteArray = new ByteArray;
			
//			bytes.readBytes(newA,0,bytes.readUnsignedInt());
			
//			trace(newA.bytesAvailable);
////			bytes.readBytes(command,0,4);
//			trace(bytes.bytesAvailable);
//			var commandID:int = bytes.readInt();
//			trace(commandID,bytes.bytesAvailable);
//			var key:String = bytes.readUTFBytes(8);
			
//			var byte:ByteArray = new ByteArray;
//			var test:ByteArray = new ByteArray;
//			test.writeByte(1);
//			test.writeByte(1);
//			test.position = 0;
//			test.readBytes(byte,0,1);
//			trace(byte.bytesAvailable);
//			test.readBytes(byte,1,1);
//			trace(byte.bytesAvailable);
//			trace(bytes.length);
//				var receivemessage:SimMessage = new SimMessage();
//				receivemessage.mergeFrom(bytes);
//				var receivecarInfo:CarInfo = new CarInfo;
//				receivecarInfo.mergeFrom(receivemessage.content);
//				trace(receivemessage.id,receivemessage.key,receivecarInfo.brand,receivecarInfo.carNumber,receivecarInfo.color,receivecarInfo.model,receivecarInfo.price.toString());
//				bytes.position = 0;
//				trace(bytes.length,bytes.bytesAvailable);
//			var sendB:ByteArray = new ByteArray;
//			var carB:ByteArray = new ByteArray;
//			var message:SimMessage = new SimMessage();
//			var carInfo:CarInfo = new CarInfo;
//			carInfo.price = new Int64(1,1);
//			carInfo.brand = "test";
//			carInfo.color = "yellow";
//			carInfo.model = 2;
//			carInfo.carNumber = '110';
//			carInfo.owner = new CarOwner;
//			carInfo.owner.age = 10;
//			carInfo.owner.height = 10;
//			carInfo.owner.name = "test";
//			carInfo.owner.sex = 1;
//			carInfo.writeTo(carB);
//			message.id = 10;
//			message.key = "test";
//			message.content = carB;
//			message.writeTo(sendB);		
//			trace("sendB:",sendB.length);
//			sendB.position = 0;
			
//			var receivemessage:SimMessage = new SimMessage();
//			receivemessage.mergeFrom(sendB);
//			var receivecarInfo:CarInfo = new CarInfo;
////			receivecarInfo.mergeFrom(receivemessage.content);
//			trace(receivemessage.id,receivemessage.key);
//				trace(bytes.bytesAvailable,bytes.length);
//			if(bytes.length > 17000)
//			{
//							var message:SimMessage = new SimMessage();
//							bytes.position = 0;
//							message.mergeFrom(bytes);
//							
//							trace(message.id,message.key);
//			}
//			var message:Message = new Message;
//			message.mergeFrom(bytes);
//			trace(message);
//			trace(commandID,carInfo.color,carInfo.carNumber);
//			var message:SimMessage = new SimMessage();
//			bytes.position = 0;
//			message.mergeFrom(bytes);
//			var carInfo:CarInfo = new CarInfo;
//			carInfo.mergeFrom(message.content);
//			trace(message.id,message.key,carInfo.brand);
			
//			eventDispatcher.dispatchEvent(new SimpleEvent(EventType.SOCKET_GET_SOMETHING,bytes));
//			netReceivedPackUnitModel.receive(bytes);
		}
		/**
		 * 处理句柄 
		 * @param event
		 * 
		 */         
		private function handler(event:Event):void 
		{  
			switch(event.type)
			{
				case Event.CLOSE:
					Tracer.error("Socket Connect Close!");
					eventDispatcher.dispatchEvent(new SocketServiceEvent(SocketServiceEvent.SOCKET_CLOSE));
					break;
				case Event.CONNECT:
					eventDispatcher.dispatchEvent(new SocketServiceEvent(SocketServiceEvent.SOCKET_CONNECTED));
					break;
				case IOErrorEvent.IO_ERROR:  
				case SecurityErrorEvent.SECURITY_ERROR:  
					eventDispatcher.dispatchEvent(new SocketServiceEvent(SocketServiceEvent.SOCKET_ERROR));
					Tracer.error("Socket Connect Error!");
					break;  
				case ProgressEvent.SOCKET_DATA:
					received();  
					break;  
			}
		}
	}  
}  
