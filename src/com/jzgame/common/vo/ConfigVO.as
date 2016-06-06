package com.jzgame.common.vo
{
	import com.spellife.vo.ValueObject;
	
	public class ConfigVO extends ValueObject
	{
		public var id:String;
		public var link:String;
		public var exportClass:String;
		public var option:Object;
		public var ext:String;
		public var data:*;
		public function ConfigVO(_id:String, _data:Object, op:Object,_ext:String)
		{
			id = _id;
			data = _data;
			option = op;
			ext = _ext;
		}
	}
}