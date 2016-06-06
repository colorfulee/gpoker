//GlobalTimer.as
//Dec 2, 2011
//author:jim
//description:
package com.spellife.util
{
	public class GlobalTimer extends RealGameTimer
	{
		private static var instance:GlobalTimer;
		public function GlobalTimer(interval:Number = 40)
		{
			super(interval);
			
			if (instance)
			{
				throw new Error();
			}
			instance = this;
		}
		
		public static function getInstance():GlobalTimer
		{
			if (instance == null)
			{
				instance = new GlobalTimer();
			}
			return instance;
		}
	}
}