package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class GiftConfigVO extends ValueObject
	{
		/*auther     :jim
		* file       :GiftConfigVO.as
		* date       :Jan 12, 2015
		* description:
		*/
		
//		<id>3002</id>
//			<name>Fuleco</name>
//			<desc>福来哥</desc>
//			<img>3002_gift.png</img>
//			<type>2</type>
//			<time>259200</time>
//			<expired>0</expired>
		public var id:String;
		public var name:String;
		public var desc:String;
		public var img:String;
		public var type:uint;
		public var time:Number;
		public var expired:uint;
		public var repeat:uint;
		public function GiftConfigVO()
		{
			super();
		}
	}
}