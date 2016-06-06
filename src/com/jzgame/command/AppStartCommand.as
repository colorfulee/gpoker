package com.jzgame.command
{
	import com.jzgame.common.services.HttpService;
	import com.jzgame.common.services.SocketService;
	import com.jzgame.model.UserModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
	 * mvc框架启动完成后触发
	 * @author Rakuten
	 * 
	 */
	public class AppStartCommand extends Command
	{
		public function AppStartCommand()
		{
			super();
		}
		
		[Inject]
		public var httpService:HttpService;
		
		[Inject]
		public var socketService:SocketService;
		
		[Inject]
		public var userProxy:UserModel;
		
		override public function execute():void
		{
			httpService.userId = ExternalVars.userID;
			httpService.token = ExternalVars.token;
			httpService.gateway = ExternalVars.gateway;
			
			initUser();
		}
		
		private function initUser():void
		{
			//		var params:Object   = mainView.stage.loaderInfo.parameters;
			//		userProxy.myInfo.uid = ExternalVars.userID;
			userProxy.myInfo.userId = ExternalVars.userID;
			userProxy.myInfo.uFB_ID = ExternalVars.socialId;
			//		userProxy.gateway   = ExternalVars.gateway;
			//		userProxy.gateway   = "http://poker_dev/gateway.php";
			//		userProxy.toking    = ExternalVars.token;
			//		userProxy.platform  = ExternalVars.platform;
			
			//			gateway           : "http://poker_dev/gateway.php",
			//			token             : "01ea:1:2c54777a52f:100:90fb::1:ecaa:",
			//			version           : "0.0.0.1",
			//			social_id         : "765749800139421",
			//			uid               : "1001",
			//			assets_path       : "https://g1.dev.jizeipoker.gamagic.com/res/",
			//			zipped            : "true",
			//			platform          : "facebook_us"
		}
	}
}
