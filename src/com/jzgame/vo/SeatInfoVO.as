package com.jzgame.vo
{
	import com.jzgame.modules.table.PlayerItemView;
	import com.spellife.vo.ValueObject;
	
	import flash.geom.Point;
	
	public class SeatInfoVO extends ValueObject
	{
		//座位号码
		public var id:uint;
		//当前玩家状态
//		public var state:uint = 0;
		public var user:PlayerItemView;
		public var userInfo:UserBaseVO;
		public var position:Point;
		
		public function SeatInfoVO(id_:uint)
		{
			super();
			
			id = id_;
		}
		
		public function reset():void
		{
			user = null;
			userInfo = null;
			position = null;
		}
	}
}