package com.spellife.util
{
	import flash.utils.ByteArray;      
	public class FastBase64
	{
		/*auther     :jim
		* file       :FastBase64.as
		* date       :Apr 9, 2015
		* description:
		*/
		/*  
		* 优化Base64  
		* 主要优化执行方式，尽量减少调用函数和尽可能不使用循环  
		* 优化后提升执行速度是原来的10倍  
		* Directed by kiwiw3  
		* */  
		
		public static const version:String = "2.0.0";      
		
		public static function encode(data:String):String {      
			var bytes:ByteArray = new ByteArray();      
			bytes.writeUTFBytes(data);      
			
			return encodeByteArray(bytes);      
		}      
		
		private static const BASE64_CHARARR:Vector.<int> = new <int>[65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,48,49,50,51,52,53,54,55,56,57,43,47,61];  
		
		public static function encodeByteArray(data:ByteArray):String {      
			var output:ByteArray = new ByteArray();      
			
			var opbuf0:int;  
			var opbuf1:int;  
			var opbuf2:int;  
			var opbuf3:int;  
			
			var dblen:int = 0;  
			var resultlen:uint = data.length;  
			var position:uint = 0;  
			var oplen:uint = 0;  
			while (resultlen > 0) {  
				if (resultlen >= 3) {  
					dblen = 3;  
					resultlen -= 3;  
				}else {  
					dblen = resultlen;  
					resultlen = 0;  
				}  
				
				
				opbuf0 = (data[position] & 0xfc) >> 2;  
				
				if(dblen>=1)  
					opbuf1 = ((data[position] & 0x03) << 4) | ((data[position + 1]) >> 4);  
				else  
					opbuf1 = 64;  
				
				if(dblen>=2)  
					opbuf2 = ((data[position + 1] & 0x0f) << 2) | ((data[position + 2]) >> 6);  
				else  
					opbuf2 = 64;  
				
				if(dblen>=3)  
					opbuf3 = data[position + 2] & 0x3f;  
				else  
					opbuf3 = 64;  
				
				
				output[oplen]= BASE64_CHARARR[opbuf0];      
				output[oplen+1]= BASE64_CHARARR[opbuf1];      
				output[oplen+2]= BASE64_CHARARR[opbuf2];  
				output[oplen+3]= BASE64_CHARARR[opbuf3];  
				
				position += 3;  
				oplen += 4;  
				
			}      
			return output.readUTFBytes(oplen);  
		}  
		
		public static function decode(data:String):String {      
			var bytes:ByteArray = decodeToByteArray(data);      
			
			return bytes.readUTFBytes(bytes.length);      
		}  
		public static function decodeToByteArray(_data:String):ByteArray {      
			var output:ByteArray = new ByteArray();  
			
			var data:ByteArray = new ByteArray();  
			data.writeUTFBytes(_data);  
			
			var databuf0:int;  
			var databuf1:int;  
			var databuf2:int;  
			var databuf3:int;  
			
			var resultlen:uint = data.length;  
			var position:uint = 0;  
			var oplen:uint = 0;  
			
			while (resultlen>0) {      
				
				databuf0=find(data[position]);  
				
				if (resultlen >= 1)  
				{  
					databuf1=find(data[int(position+ 1)]);  
				}  
				
				if (resultlen >= 2)  
				{  
					databuf2=find(data[int(position+ 2)]);  
				}  
				
				if (resultlen >= 3) {  
					databuf3=find(data[int(position+3)]);  
				}  
				
				
				if (databuf1 != 64) {  
					output[oplen] = (databuf0 << 2) + ((databuf1 & 0x30) >> 4);  
					if (databuf2 != 64) {  
						output[oplen + 1] = ((databuf1 & 0x0f) << 4) + ((databuf2 & 0x3c) >> 2);    
						if (databuf3 != 64) {  
							output[oplen+ 2] = ((databuf2 & 0x03) << 6) + databuf3;  
						}  
					}  
				}  
				
				position += 4;  
				oplen += 3;  
				resultlen -= 4;  
			}  
			return output;      
		}
		
		private static function find(val:int):int 
		{  
			if (val >= 65 && val<=90) {  
				return val-65;  
			}else if (val >= 97 && val<=122) {  
				return 26+val-97;  
			}else if (val >= 48 && val<=57) {  
				return 52+val-48;  
			}else if (val==43) {  
				return 62;  
			}else if (val==47) {  
				return 63;  
			}else if (val==61) {  
				return 64;  
			}  
			
			return 0;
		}  
	}
}