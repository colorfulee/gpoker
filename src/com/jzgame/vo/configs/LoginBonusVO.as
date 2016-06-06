package com.jzgame.vo.configs
{
	import com.spellife.vo.ValueObject;
	
	public class LoginBonusVO extends ValueObject
	{
		/*auther     :jim
		* file       :LoginBonusVO.as
		* date       :Jan 26, 2015
		* description:
		*/
//		<id>20003</id>
//			<num>31</num>
//			<bonus>101:1,4001:2</bonus>
		
		public var id:String;
		public var num:Number = 0;
		public var bonus:String = "";// 奖励，格式：101:1;4001:2
		public function LoginBonusVO()
		{
			super();
		}
	}
}