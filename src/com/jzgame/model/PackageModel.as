package com.jzgame.model
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.enmu.EventType;
	import com.jzgame.util.ItemStringUtil;
	import com.jzgame.vo.PackageGiftVO;
	import com.jzgame.vo.PackageItemVO;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	public class PackageModel
	{
		/*auther     :jim
		* file       :PackageModel.as
		* date       :Jan 4, 2015
		* description:
		*/
		[Inject]
		public var eventDis:IEventDispatcher;
		
		[Inject]
		public var userModel:UserModel;
		private var _giftList:Array = [];
		private var _itemList:Array = [];
		private var _itemDic:Dictionary = new Dictionary;
		private var _giftDic:Dictionary = new Dictionary;
		public function PackageModel()
		{
		}
		/**
		 * 添加物品
		 * @param source
		 * 
		 */		
		public function addItem(source:PackageItemVO):void
		{
			_itemList.push(source);
			_itemDic[source.id] = source;
		}
		/**
		 * 移除用完的物品 
		 * @param id
		 * 
		 */		
		public function removeItem(id:String):void
		{
			for(var index:uint = 0; index <_itemList.length ; index ++)
			{
				if(id == _itemList[index].id)
				{
					_itemList.splice(index,1);
					break;
				}
			}
			delete _itemDic[id]
		}
		/**
		 * 添加礼物
		 * @param source
		 * 
		 */		
		public function addGift(source:PackageGiftVO):void
		{
			_giftList.push(source);
			_giftDic[source.id] = source;
		}
		//过滤礼物类型
		private var _filterType:uint;
		private function giftTypeFilter(element:PackageGiftVO,index:uint,arr:Array):Boolean
		{
			return Configure.giftConfig.getItemById(element.id).type == _filterType;
		}
		
		/**
		 * 获取类型 
		 * @param type
		 * @return 
		 * 
		 */		
		public function getGiftTyeList(type:uint):Array
		{
			var tempList:Array;
			
			if(type == 0) 
			{
				tempList = _giftList.concat();
			}else
			{
				_filterType = type;
				tempList = _giftList.filter(giftTypeFilter);
			}
			
			return tempList;
		}
		
		public function get itemList():Array
		{
			return _itemList;
		}
		/**
		 * 根据id获取背包物品
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemById(id:String):PackageItemVO
		{
			if(!_itemDic.hasOwnProperty(id))
			{
				var itemVO:PackageItemVO = new PackageItemVO;
				itemVO.id = id;
				addItem(itemVO);
			}
			return _itemDic[id];
		}
		/**
		 * 更新道具 
		 * @param id
		 * @param count
		 * @param countAchi
		 * 
		 */		
		public function updateItem(itemid:int,count:int,countAchi:int):void
		{
			var id:String = itemid.toString();
			var now:uint = 0;
			var tips:Array = [];
			if(Configure.getItemType(id) == Configure.GIFT)
			{
				var gift:PackageGiftVO = getGiftById(id);
				now = count + countAchi;
				if((gift.num + gift.acNum) < now)
				{
					tips.push(ItemStringUtil.getItemDes(gift.id,(now - gift.num - gift.acNum).toString()));
				}
				gift.num = count;
				gift.acNum = countAchi;
			}else
			{
				var item:PackageItemVO = getItemById(id);
				//此时增加item
				now = count + countAchi;
				if((item.num + item.acNum) < now)
				{
					tips.push(ItemStringUtil.getItemDes(item.id,(now - item.num - item.acNum).toString()));
				}
				//如果当前的用完,则强刷当前页
				if(now <= 0)
				{
					removeItem(item.id);
					eventDis.dispatchEvent(new Event(EventType.UPDATE_PACK_INFO));
				}else
				{
					item.num = now;
				}
			}
			//如果道具使用完，则强刷
			if(now == 0)
			{
				HttpSendProxy.sendPackageRequest(userModel.myInfo.userId.toString());
			}
		}
		/**
		 * 根据id获取背包物品
		 * @param id
		 * @return 
		 * 
		 */		
		public function getGiftById(id:String):PackageGiftVO
		{
			if(!_giftDic.hasOwnProperty(id))
			{
				var itemVO:PackageGiftVO = new PackageGiftVO;
				itemVO.id = id;
				addGift(itemVO);
			}
			return _giftDic[id];
		}
		/**
		 * 更新背包 
		 * @param vo
		 * 
		 */		
		public function updateInfo(vo:Object,interfaceName:String):void
		{
			var tips:Array = [];
			var giftNum:uint = 0;
			var itemNum:uint = 0;
			var now:uint;
			for(var id:String in vo)
			{
				if(Configure.getItemType(id) == Configure.GIFT)
				{
					var gift:PackageGiftVO = getGiftById(id);
					giftNum ++;
					now = uint(vo[id].n) + uint(vo[id].acn);
					if((gift.num + gift.acNum) < now)
					{
						tips.push(ItemStringUtil.getItemDes(gift.id,(now - gift.num - gift.acNum).toString()));
					}
					gift.num = uint(vo[id].n);
					gift.acNum = uint(vo[id].acn);
				}else
				{
					var item:PackageItemVO = getItemById(id);
					//此时增加item
					now = uint(vo[id].n) + uint(vo[id].acn);
					if((item.num + item.acNum) < now)
					{
						tips.push(ItemStringUtil.getItemDes(item.id,(now - item.num - item.acNum).toString()));
					}
					//如果当前的用完,则强刷当前页
					if(now <= 0)
					{
						removeItem(item.id);
						eventDis.dispatchEvent(new Event(EventType.UPDATE_PACK_INFO));
					}else
					{
						item.num = now;
					}
					itemNum++;
				}
			}
			//如果背包物品个数有变化，则强刷
			if(_giftList.length != giftNum || itemNum != _itemList.length)
			{
				HttpSendProxy.sendPackageRequest(userModel.myInfo.userId.toString());
			}
			
			switch(interfaceName)
			{
				case MessageType.MESSAGE_DAILY_GET_LOGIN_BONUS:
				case MessageType.TASK_BONUS:
				case MessageType.GET_TASK_BONUS:
				case MessageType.MESSAGE_PROGCESS_MESSAGE:
				case MessageType.ACHIEVEMENT_BONUS_GET:
				case MessageType.MESSAGE_PROCESS:
				case MessageType.MESSAGE_PACKAGE_USE:
				case MessageType.ACTIVITY_EXCHANGE:
				case MessageType.EXCHANGE_BOUNTY_HUNTER:
				case MessageType.EXCHANGE_PUZZLE_PRIZE:
					if(tips.length > 0)
					{
						userModel.rewardsTips.push(LangManager.getText("402024")+tips.join(AssetsCenter.PLUS));
						eventDis.dispatchEvent(new Event(EventType.SHOW_REWARD_TIPS));
					}
					break;
			}
		}
		/**
		 * 清除 
		 * 
		 */		
		public function clear():void
		{
			_giftList.splice(0,_giftList.length);
			_itemList.splice(0,_itemList.length);
			for(var i:String in _itemDic)
			{
				delete _itemDic[i];	
			}
			
			for(var j:String in _giftDic)
			{
				delete _giftDic[j];	
			}
		}
	}
}