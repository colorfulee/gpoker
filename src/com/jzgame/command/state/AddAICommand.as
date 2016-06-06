package com.jzgame.command.state
{
	import com.jzgame.model.UserModel;
	import com.jzgame.vo.UserBaseVO;
	import com.netease.protobuf.Int64;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class AddAICommand extends Command
	{
		/*auther     :jim
		* file       :AddAICommand.as
		* date       :Oct 8, 2014
		* description:
		*/
		
		[Inject]
		public var userModel:UserModel;
		
		public function AddAICommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var player:UserBaseVO = new UserBaseVO;
			player.uSeatIndex = 1;
			player.userId = 1;
			player.uLevel = 5;
			player.uMoney = new Int64(10000);
			player.uClip = new Int64(10000);
			player.uNickName = "AI_1"
			
			userModel.addUser(player);
			
			player = new UserBaseVO;
			player.uSeatIndex = 3;
			player.userId = 2;
			player.uLevel = 5;
			player.uMoney = new Int64(10000);
			player.uClip = new Int64(10000);
			player.uNickName = "AI_2"
			userModel.addUser(player);
			
			player = new UserBaseVO;
			player.uSeatIndex = 7;
			player.userId = 3;
			player.uLevel = 5;
			player.uMoney = new Int64(10000);
			player.uClip = new Int64(10000);
			player.uNickName = "AI_3"
			userModel.addUser(player);
			
			player = new UserBaseVO;
			player.uSeatIndex = 9;
			player.userId = 4;
			player.uLevel = 5;
			player.uMoney = new Int64(10000);
			player.uClip = new Int64(10000);
			player.uNickName = "AI_4"
			userModel.addUser(player);
		}
	}
}