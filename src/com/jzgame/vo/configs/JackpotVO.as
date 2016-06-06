package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class JackpotVO extends ValueObject
	{
		public var id:String;
		public var blind:int;
		public var fee:int;
		public var bonus:int;
		public function JackpotVO()
		{
			super();
		}
	}
}