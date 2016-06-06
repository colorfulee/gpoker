package com.spellife.util
{
	import flash.display.DisplayObjectContainer;

	public class DisposeUtil
	{
		/*auther     :jim
		* file       :DisposeUtil.as
		* date       :Sep 29, 2014
		* description:
		*/
		public function DisposeUtil()
		{
		}
		/**
		 * 
		 * @param container
		 * 
		 */		
		public static function disposeChildren(container:DisplayObjectContainer):void
		{
			while(container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
		}
	}
}