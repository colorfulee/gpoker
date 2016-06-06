package com.jzgame.command
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.GameModel;
	import com.jzgame.model.PackageModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.vo.PackageGiftVO;
	import com.jzgame.vo.PackageItemVO;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HandlePackCommand extends Command
	{
		/*auther     :jim
		* file       :HandlePackCommand.as
		* date       :May 20, 2015
		* description:
		*/
		[Inject]
		public var event:HttpResponseEvent;
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		[Inject]
		public var packModel:PackageModel;
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var gameModel:GameModel;
		public function HandlePackCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var result:Object     = event.data["r"];
			if(result)
			{
				var packObject:Object = result["pack"];
				if(packObject)
				{
					//			"r": {
					//				"pack": {
					//					"3001": {
					//						"n": 10,        #除了成就获得的数量
					//						"acn": 0        #成就获得的数量
					//					},
					//					"4001": {
					//						"n": 35,
					//						"acn": 0
					//					}
					
					packModel.clear();
					
					for(var item:String in packObject)
					{
						if(Configure.getItemType(item) == Configure.GIFT)
						{
							var vo:PackageGiftVO = new PackageGiftVO;
							vo.id = item;
							vo.num = packObject[item]["n"];
							vo.acNum = packObject[item]["acn"];
							if((vo.num + vo.acNum ) <=0) continue;
							packModel.addGift(vo);
						}else
						{
							var itemVO:PackageItemVO = new PackageItemVO;
							itemVO.id = item;
							itemVO.isMine = userModel.myInfo.userId == gameModel.tipUserId;
							itemVO.num = packObject[item]["n"];
							itemVO.acNum = packObject[item]["acn"];
							if((itemVO.num + itemVO.acNum ) <=0) continue;
							packModel.addItem(itemVO);
						}
					}
					
					eventDispatcher.dispatchEvent(new Event(EventType.UPDATE_PACK_INFO));
				}
			}
		}
	}
}