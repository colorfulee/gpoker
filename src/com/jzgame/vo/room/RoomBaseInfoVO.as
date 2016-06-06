package com.jzgame.vo.room
{
	import com.jzgame.common.utils.logging.Tracer;
	import com.spellife.vo.ValueObject;
	
	public class RoomBaseInfoVO extends ValueObject
	{
		/*auther     :jim
		* file       :RoomBaseInfoVO.as
		* date       :Feb 12, 2015
		* description:
		*/
		private var _id:int = 0;
		public var tableName:String = "";
		//小盲
		public var blinds:int;
		public var minBuy:int;
		public var maxBuy:int;
		public var maxRole:int;
		public var online:int;
		public var limit:Number = 0;
		public var port:int;
		public var host:String;
		public function RoomBaseInfoVO()
		{
			super();
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			if(value == 0)
			{
				Tracer.info(value,new Error().getStackTrace());
			}
			_id = value;
		}

		/**
		 * 获取房间类型 
		 * @return 
		 * 
		 */		
		public function get type():uint
		{
			return Math.floor(id/10000);
		}
	}
}