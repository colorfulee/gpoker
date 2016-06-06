package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class VipConfigVO extends ValueObject
	{
		/*auther     :jim
		* file       :VipConfigVO.as
		* date       :Jan 14, 2015
		* description:
		*/
		
//		<id>7001</id>
//			<name>VIP Metal</name>
//			<desc>1. valid in 30 days &lt;br&gt; 2.valid in 30 days&lt;/br&gt;</desc>
//			<img>item_VIPMetal.png</img>
//			<type>0</type>
//			<effect>0</effect>
//			<time>2592000</time>
//			<expired>0</expired>
		public var id:String;
		public var index:int;
		public var name:String;
		public var img:String;
		public var type:uint;
		public var time:Number;
		public var effect:Boolean;
		public var expired:Boolean;
		public var desc:String;
		public function VipConfigVO()
		{
			super();
		}
	}
}