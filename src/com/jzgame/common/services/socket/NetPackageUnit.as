package com.jzgame.common.services.socket
{
	import com.jzgame.common.utils.logging.Tracer;
	
	import flash.utils.Endian;

	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Apr 9, 2013 5:28:42 PM 
	 * @description:
	 */ 
	public class NetPackageUnit extends NetBaseByteArray
	{
		//协议最大长度
		public static const MSG_MAX_LENGTH:int = 10240;
		//协议头长度
		public static const MSG_HEADER_LENGTH:int = 8;
		
		public function NetPackageUnit()
		{
			super();
			
			this.endian = Endian.BIG_ENDIAN;
			
			reset();
		}
		
		private var  uMsgSize:Number = 0;			// 包的总长度,包括dwSize自身 32位
		private var  uMsgMagic:uint = 0xF1E2D3C4;			// （魔术数字 可以是校验头，也可以是版本号）32位
		private var	 uMsgType:uint = 0;			// 消息类型 16位
		private var  _uMsgCmd:uint = 0;				// 消息命令字16位
		private var	 _uMsgErrno:uint = 0;			// 错误号32位
		private var	 uMsgParams:Array = [0,0];		// 保留字段32位
		
		public function get uMsgErrno():uint
		{
			return _uMsgErrno;
		}

		private function reset():void
		{
			var len:int = uMsgSize;
			len = len ^ -226834058;

			addShortWorld(1,0);
			addShortWorld(1);
			addShortWorld(1);
			addSignWord(len);
			addShortWorld(1);
//			addSignWord(len,3);
//			addShortWorld(1,7);
			
//			addUsignWord(uMsgMagic);
//			addUsignShortWord(uMsgType);
//			addUsignShortWord(_uMsgCmd);
//			addUsignWord(uMsgErrno);
//			addUsignWord(uMsgParams[0]);
//			addUsignWord(uMsgParams[1]);
		}
		
		public function prase(size:uint):void
		{
			this.position  = 0;
			
			uMsgSize  = size;
			uMsgMagic = this.readUnsignedInt();
			uMsgType  = this.readUnsignedShort();
			_uMsgCmd   = this.readUnsignedShort();
			_uMsgErrno = this.readUnsignedInt();
			uMsgParams[0] = this.readUnsignedInt();
			uMsgParams[1] = this.readUnsignedInt();
		}
		/**
		 * 设置接口类型
		 * @param cmd
		 * 
		 */		
		public function set msgCmd(cmd:uint):void
		{
			_uMsgCmd = cmd;
		}
		/**
		 * 获取接口类型 
		 * @param cmd
		 * 
		 */		
		public function get msgCmd():uint
		{
			return _uMsgCmd
		}
		/**
		 * 准备好
		 * 发送 
		 * 
		 */		
		public function getReady():Boolean
		{
			//重新写头文件，计算长度
			uMsgSize = this.length - MSG_HEADER_LENGTH;
			reset();
			//prase(this)
//			Debug.log('i am from get ready:command,'+uMsgCmd.toString(16)+','+this.toString());
//			var debug:String = 'i am from get ready:command,'+_uMsgCmd.toString(16)+',size:'+this.uMsgSize;
//			AssetsCenter.eventDispatcher.dispatchEvent(new DebugInfoEvent(debug,DebugInfoType.SEND_NET));
			Tracer.debug('i am from get ready:command,',_uMsgCmd.toString(16),',size:'+this.uMsgSize);
			if(uMsgSize<MSG_HEADER_LENGTH || uMsgSize>MSG_MAX_LENGTH)
			{
				return false;
			}
			
			return true;
		}
		
		/**
		 * 无符号16位 
		 */
		public function addUsignShortWord(val:int,pos:int = -1):Boolean
		{
			if(!checkPos(pos))
			{
				return false;
			}
			writeShort(val);
			return true;
		}
		/**
		 * 读取无符号16位 
		 */
		public function getUsignShortWord(pos:int = -1):uint
		{
			if(!checkPos(pos))
			{
				return 0;
			}
			
			return readUnsignedShort();
		}
		/**
		 * 无符号八位
		 * @return 
		 * 
		 */		
		public function addShortWorld(val:int,pos:int = -1):Boolean
		{
			if(!checkPos(pos))
			{
				return false;
			}
			writeByte(val);
			return true;
		}
		/**
		 * 无符号八位
		 * @return 
		 * 
		 */		
		public function getShortWorld(pos:int = -1):uint
		{
			if(!checkPos(pos))
			{
				return 0;
			}
			
			return readByte();
		}
		
		/**
		 * 无符号32位 
		 * @param val 值
		 * @param pos 写的位置
		 * @return 
		 * 
		 */		
		public function addUsignWord(val:uint,pos:int = -1):Boolean
		{
			if(!checkPos(pos))
			{
				return false;
			}
			writeUnsignedInt(val);
			return true;
		}
		/**
		 * 读取有符号32位 
		 * @param pos
		 * @return 
		 * 
		 */		
		public function getIntWord(pos:int = -1):int
		{
			if(!checkPos(pos))
			{
				return -1;
			}
			
			return readInt();
		}
		/**
		 * 读取无符号32位 
		 * @param pos
		 * @return 
		 * 
		 */		
		public function getUsignWord(pos:int = -1):uint
		{
			if(!checkPos(pos))
			{
				return 0;
			}
			
			return readUnsignedInt();
		}
		/**
		 * 有符号32位 
		 */
		public function addSignWord(val:int,pos:int = -1):Boolean
		{
			if(!checkPos(pos))
			{
				return false;
			}
			writeInt(val);
			return true;
		}
		/**
		 * 添加短（16位）字符串 [长度+字符串+结尾符]
		 * @param val
		 * @param pos
		 * @return 
		 * 
		 */		
		public function addShortString(val:String, pos:int = -1):Boolean
		{
			if(!checkPos(pos))
			{
				return false;
			}
			
			var oldpos:uint = position;
			writeShort(0);//16位长度
			writeMultiByte(val,"utf-8");//GB2312
			writeByte(0);//结尾符8位
			var offset:uint = position - oldpos - 2;
			position = oldpos;
			writeShort(offset);
			position = oldpos+2+offset;	
			return true;
		}
		/**
		 *  
		 * @param pos
		 * @return 
		 * 
		 */		
		public function getShortString(pos:int = -1):String
		{	
			if(bytesAvailable<=2 || !checkPos(pos))
			{
				return "";
			}
			var len:uint = readUnsignedShort();
			if(len < 1 || bytesAvailable < len)
			{
				return "";
			}
			
			var strMsg:String = "";
			strMsg = readMultiByte((len -1),"utf-8");//GB2312		
			position++;
			
			return strMsg;
		}
		
		/**
		 * 添加32位浮点数 
		 * @return 
		 * 
		 */		
		public function addFloat(val:Number, pos:int = -1):Boolean
		{
			if(!checkPos(pos))
			{
				return false;
			}
			writeFloat(val);
			return true;
		}
		
		/**
		 *	读取一个 IEEE 754 双精度（32 位）浮点数 
		 */
		public function getFloat(pos:int = -1):Number
		{
			if(!checkPos(pos) || bytesAvailable<4)
			{
				return 0;
			}
			return readFloat();		
		}
		
		/**
		 *	读取一个 IEEE 754 双精度（64 位）浮点数 
		 */
		public function getDouble(pos:int = -1):Number
		{
			if(!checkPos(pos) || bytesAvailable<8)
			{
				return 0;
			}
			return readDouble();		
		}
		/**
		 * 检测是否超长,设置指针位置
		 * @param pos
		 * @return 
		 * 
		 */		
		private function checkPos(pos:int):Boolean
		{
			if(-1 == pos)
			{
				return true; 
			}
			else if(0==pos || (pos>=0 && pos<length))
			{
				position = pos;
				return true; 
			}
			else
			{
				return false;
			}
		}
	}
}