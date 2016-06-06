package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class ItemConfigVO extends ValueObject
	{
		/*auther     :jim
		* file       :ItemConfigVO.as
		* date       :Dec 24, 2014
		* description:
		*/
		public var id:String;
		public var name:String;
		public var des:String;
		public var img:String;
		//是否需要手动使用
		public var manual:uint;
		public function ItemConfigVO()
		{
			super();
		}
	}
}