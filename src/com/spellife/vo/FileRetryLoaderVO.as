//FileRetryLoaderVO.as
//Mar 23, 2012
//author:jim
//description:
package com.spellife.vo
{
	import com.spellife.interfaces.vo.IValueObject;
	
	import flash.system.LoaderContext;
	
	public class FileRetryLoaderVO extends ValueObject
	{
//		类型
		public var type:uint;
//		地址
		public var url:String;
//		加载安全域
		public var context:LoaderContext;
//		传入参数
		public var params:Object;
//		重复加载次数
		public var retryNum:int = 5;
		public function FileRetryLoaderVO(filetype:uint,path:String, appcontext:LoaderContext = null,param:Object = null,retry:int = 5)
		{
			super();
			
			url     = path;
			type    = filetype;
			context =appcontext;
			params  = param;
			retryNum= retry;
		}
		
		public override function clone():IValueObject
		{
			return new FileRetryLoaderVO(this.type,this.url,this.context,this.params,this.retryNum);
		}
	}
}