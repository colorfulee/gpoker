package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class BackgroundVO extends ValueObject
	{
		/*auther     :jim
		* file       :BackgroundVO.as
		* date       :Feb 2, 2015
		* description:
		*/
		public var id:String;
		public var name:String;
		public var cost_chip:String;
		public var index:uint;
		public var is_new:Boolean;
		public var is_hot:Boolean;
		public var img:String;
		public var desc:String;
		public function BackgroundVO()
		{
			super();
		}
	}
}