package com.jzgame.common.utils
{
	import com.jzgame.common.model.HttpSendProxy;

	public class ConfigSO
	{
		/*auther     :jim
		* file       :ShareObject.as
		* date       :Feb 3, 2015
		* description:前端配置
		*/
		
		private static var _instance:ConfigSO;

		public var muteBottomHint:Boolean = false;
		public var muteStandUp:Boolean = false;
		//音效声音百分比
		public var soundEffectVolumn:Number = 100;
		//扑克的背景配置
		public var pokerBackIndex:uint = 2;
		//扑克前脸配置
		public var pokerIndex:uint = 3;
		
		public function ConfigSO()
		{
			if(_instance)throw new Error("ConfigSO instance exist!");
		}
		
		public static function getInstance():ConfigSO
		{
			if(!_instance)_instance = new ConfigSO;
			return _instance;
		}
		
		/**
		 * 设置存储 
		 * 只要是元数据，都能还原
		 * @param item
		 * 
		 */		
		public static function setInstance(item:Object):void
		{
			var target:ConfigSO = getInstance();
			for(var index:String in item)
			{
				if(target.hasOwnProperty(index))
				{
					target[index] = item[index];
				}
			}
		}
		
		public static function flush():void
		{
			HttpSendProxy.sendRemoteConfig(_instance);
		}
	}
}