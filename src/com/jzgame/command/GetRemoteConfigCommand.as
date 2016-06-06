package com.jzgame.command
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.utils.ConfigSO;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class GetRemoteConfigCommand extends Command
	{
		/*auther     :jim
		* file       :GetRemoteConfigCommand.as
		* date       :Feb 3, 2015
		* description:获取远程的配置信息(前端存储空间类似shareobject)
		*/
		[Inject]
		public var event:HttpResponseEvent;
		
		public function GetRemoteConfigCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var result:Object = event.result;
			ConfigSO.setInstance(result);
		}
	}
}