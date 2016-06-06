package com.jzgame.command
{
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.vo.TimeLimitVo;
	import com.jzgame.model.DailyModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.WindowFactory;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class LimitGameRewardCommand extends Command
	{

		[Inject]
		public var event:HttpResponseEvent;
		public function LimitGameRewardCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var result:Object = event.result;
			
			if(result)
			{
				var itemList:Array=new Array();
				for(var tap:String in result)
				{
					var itemVo:Object=new Object();
					itemVo.id=Number(tap);
					itemVo.num=Number(result[tap]);
					itemList.push(itemVo);
				}
				
				if(itemList && itemList.length>0)
				{
					WindowFactory.addPopUpWindow(WindowFactory.TIME_LIMIT_SHOW_REWARD_WINDOW,null,itemList);
				}
				
			}
		}
	}
}