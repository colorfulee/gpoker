package com.jzgame.model
{
	import com.spellife.util.TimerManager;
	
	import flash.utils.Dictionary;

	public class BuffModel
	{
		/*auther     :jim
		* file       :BuffModel.as
		* date       :Apr 13, 2015
		* description:buff 数据模块
		*/
		
//		"buff": {
//			"4008": {
//				"end_time": "1421037382"
//			}
//		},

		private var _dic:Dictionary = new Dictionary;
		
		public function BuffModel()
		{
			
		}
		/**
		 *  添加buff
		 * @param id
		 * @param endtime
		 * 
		 */		
		public function addBuff(id:String,endtime:String):void
		{
			_dic[id] = endtime;
		}
		/**
		 * 获取指定buff 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getBuff(id:String):Number
		{
			if(_dic.hasOwnProperty(id))
			{
				return _dic[id];
			}
			return 0;
		}
		/**
		 * 是否vip 
		 * @return 
		 * 
		 */		
		public function isVIP():Boolean
		{
			//判断是否过期
			var B4001:Number = getBuff("7001") - TimerManager.getCurrentSysTime();
			var B4002:Number = getBuff("7002") - TimerManager.getCurrentSysTime();
			var B4003:Number = getBuff("7003") - TimerManager.getCurrentSysTime();
			var B4004:Number = getBuff("7004") - TimerManager.getCurrentSysTime();
			if(B4001 > 0 || B4002 > 0 || B4003 > 0 || B4004 > 0)
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 更新自己信息 
		 * @param vo
		 * 
		 */		
		public function updateInfo(vo:Object):void
		{
			var buff:Object = vo;
			if(buff)
			{
				for(var bfi:String in buff)
				{
					addBuff(bfi,buff[bfi]["end_time"]);
				}
			}
//			addBuff();
		}
	}
}