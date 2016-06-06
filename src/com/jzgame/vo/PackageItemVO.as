package com.jzgame.vo
{
	import com.spellife.vo.ValueObject;
	
	import flash.events.Event;
	
	public class PackageItemVO extends ValueObject
	{
		/*auther     :jim
		* file       :PackageItemVO.as
		* date       :Jan 4, 2015
		* description:
		*/
		//自己购买个数包括别人赠送
		private var _num:uint = 0;
		//成就获得？？
		private var _acNum:uint = 0;
		//是否是自己的
		public var isMine:Boolean = true;
		//
		public var id:String = "";
		//时间
		public var time:Number = 0;
		public function PackageItemVO()
		{
			super();
		}

		public function get acNum():uint
		{
			return _acNum;
		}

		public function set acNum(value:uint):void
		{
			_acNum = value;
		}

		public function get num():uint
		{
			return _num;
		}
		/**
		 * 获取全部数量 
		 * @return 
		 * 
		 */		
		public function get allNum():Number
		{
			return _acNum + _num;
		}

		public function set num(value:uint):void
		{
			_num = value;
			dispatchEvent(new Event(Event.CHANGE));
		}

	}
}