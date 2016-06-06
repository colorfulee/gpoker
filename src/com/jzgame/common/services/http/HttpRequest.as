package com.jzgame.common.services.http
{
	import com.jzgame.common.jize_internal;

	use namespace jize_internal;
	
	public class HttpRequest implements IHttpRequest
	{
		public function HttpRequest()
		{
		}
		
		jize_internal var apiUrl:String = "";
		
		public var name:String;
		
		public var data:Array = [];
		
//		public var responseEvent:String;
	}
}