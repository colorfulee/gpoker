package com.jzgame.mediator.windows.rank
{
	import com.jzgame.common.model.HttpSendProxy;
	import com.jzgame.common.model.achiement.AchiementProxy;
	import com.jzgame.common.model.gameFriends.GameFriendsProxy;
	import com.jzgame.common.services.MessageType;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.vo.GameFriendVO;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.BuffModel;
	import com.jzgame.model.RankModel;
	import com.jzgame.model.UserModel;
	import com.jzgame.view.windows.rank.PopUpRankWindow;
	import com.jzgame.vo.RankListItemVO;
	import com.jzgame.vo.RankMyInfoVO;
	
	import flash.events.Event;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Event;
	
	public class PopUpRankWindowMediator extends StarlingMediator
	{
		/***********
		 * name:    PopUpRandWindowMediator
		 * data:    Dec 7, 2015
		 * author:  jim
		 * des:
		 ***********/
		[Inject]
		public var view:PopUpRankWindow;
		[Inject]
		public var userModel:UserModel;
		
		[Inject]
		public var rankModel:RankModel;
		[Inject]
		public var buffModel:BuffModel;
		
		[Inject]
		public var gameFriendProxy:GameFriendsProxy
		[Inject]
		public var achie:AchiementProxy;
		public function PopUpRankWindowMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			//获取成就回调
			addContextListener(EventType.UPDATE_ACHIE,updateAchie);
			addContextListener(MessageType.PLAYER_RANK,updateRank,HttpResponseEvent);
			
			
			view.tabBar.addEventListener(starling.events.Event.CHANGE, updateIndex);
			view.radioGroup.addEventListener(starling.events.Event.CHANGE, updateAll);
			
			if(view.motionEffect)
			{
				view.addEventListener(starling.events.Event.COMPLETE, startNet);
			}else
			{
				startNet(null);
			}
		}
		
		override public function destroy():void
		{
			removeContextListener(EventType.UPDATE_ACHIE,updateAchie);
			removeContextListener(MessageType.PLAYER_RANK,updateRank,HttpResponseEvent);
			view.tabBar.removeEventListener(starling.events.Event.CHANGE, updateIndex);
			view.radioGroup.removeEventListener(starling.events.Event.CHANGE, updateAll);
			view.removeEventListener(starling.events.Event.COMPLETE, startNet);
		}
		private function startNet(e:starling.events.Event):void
		{
			//获取成就
			HttpSendProxy.sendAchieRequest(userModel.myInfo.userId.toString());
		}
		
		/**
		 * 更新成就 
		 * @param e
		 * 
		 */		
		private function updateAchie(e:flash.events.Event):void
		{
			//获取列表
			HttpSendProxy.getRank(userModel.myInfo.userId.toString());
		}
		private function updateRank(e:HttpResponseEvent):void
		{
			var result:Object = e.data["r"];
			var target:Object;
			if(e.result)
			{
				var all:Object = e.result["all"];
				var friend:Object = e.result["friend"];
				//				c表示chip  a表示成就  l表示等级
				var rankItemVO:RankListItemVO
				var all_achieve:Object = all["a"];
				if(all_achieve)
				{
					prase(all_achieve,rankModel.addAllAchieveItem);
					target = all_achieve["t"];
					rankModel.myAchieveInfo = new RankMyInfoVO;
					rankModel.myAchieveInfo.value = achie.goldP + achie.silP + achie.treP;
					rankModel.myAchieveInfo.rank = all_achieve.me;
					rankModel.myAchieveInfo.target = target["r"];
					rankModel.myAchieveInfo.need = target["v"];
					rankModel.myAchieveInfo.myFBID = userModel.myInfo.uFB_ID;
					rankModel.myAchieveInfo.myName = userModel.myInfo.uNickName;
				}
				
				var all_chip:Object = all["c"];
				if(all_chip)
				{
					prase(all_chip,rankModel.addAllChipItem);
					target = all_chip["t"];
					rankModel.myChipInfo = new RankMyInfoVO;
					rankModel.myChipInfo.value = userModel.myInfo.uMoney.toNumber();
					rankModel.myChipInfo.rank = all_chip.me;
					rankModel.myChipInfo.target = target["r"];
					rankModel.myChipInfo.need = target["v"];
					rankModel.myChipInfo.myFBID = userModel.myInfo.uFB_ID;
					rankModel.myChipInfo.myName = userModel.myInfo.uNickName;
				}
				
				var all_level:Object = all["l"];
				if(all_level)
				{
					prase(all_level,rankModel.addAllLevelItem);
					target = all_level["t"];
					rankModel.myLevelInfo = new RankMyInfoVO;
					rankModel.myLevelInfo.value = userModel.myInfo.uLevel;
					rankModel.myLevelInfo.rank = all_level.me;
					rankModel.myLevelInfo.target = target["r"];
					rankModel.myLevelInfo.need = target["v"];
					rankModel.myLevelInfo.myFBID = userModel.myInfo.uFB_ID;
					rankModel.myLevelInfo.myName = userModel.myInfo.uNickName;
				}
				var friend_achieve:Object = friend["a"];
				if(friend_achieve)
				{
					praseFriend(friend_achieve,rankModel.addFriendAchieveItem);
					rankModel.friendAchieve.sortOn("index",Array.NUMERIC);
				}
				
				var friend_chip:Object = friend["c"];
				if(friend_chip)
				{
					praseFriend(friend_chip,rankModel.addFriendChipItem);
					rankModel.friendChip.sortOn("index",Array.NUMERIC);
				}
				
				var friend_level:Object = friend["l"];
				if(friend_level)
				{
					praseFriend(friend_level,rankModel.addFriendLevelItem);
					rankModel.friendLevel.sortOn("index",Array.NUMERIC);
				}
				
				view.tabBar.selectedIndex = 0;
			}
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function updateAll(e:starling.events.Event):void
		{
			updateList();
		}
		/**
		 * 更换页签
		 * @param e
		 * 
		 */		
		private function updateIndex(e:starling.events.Event):void
		{
			updateList();
		}
		/**
		 * 更新列表 
		 * 
		 */		
		private function updateList():void
		{
			switch(view.tabBar.selectedIndex)
			{
				case 2:
					if(view.radioGroup.selectedIndex == 0)
					{
						view.setList(rankModel.getAllAchieve());
					}else
					{
						view.setList(rankModel.friendAchieve);
					}
					view.setMyInfo(rankModel.myAchieveInfo);
					break;
				case 1:
					if(view.radioGroup.selectedIndex == 0)
					{
						view.setList(rankModel.getAllLevel());
					}else
					{
						view.setList(rankModel.friendLevel);
					}
					view.setMyInfo(rankModel.myLevelInfo);
					break;
				case 0:
					if(view.radioGroup.selectedIndex == 0)
					{
						view.setList(rankModel.getAllChip());
					}else
					{
						view.setList(rankModel.friendChip);
					}
					view.setMyInfo(rankModel.myChipInfo);
					break;
			}
		}
		/**
		 * 解析所有 
		 * @param result
		 * @param fun
		 * 
		 */		
		private function prase(result:Object,fun:Function):void
		{
			var rankItemVO:RankListItemVO;
			var all_achieve:Object = result;
			if(all_achieve)
			{
				var acR:Object = all_achieve["r"];
				for(var i:String in acR)
				{
					rankItemVO = new RankListItemVO;
					rankItemVO.index = acR[i][0];
					rankItemVO.uid = acR[i][1];
					rankItemVO.name = acR[i][2];
					rankItemVO.fbID = acR[i][3];
					rankItemVO.field = acR[i][4];
					rankItemVO.lastIndex = acR[i][5];
					fun.apply(null,[rankItemVO]);
				}
			}
		}
		/**
		 * 解析好友 
		 * @param result
		 * @param fun
		 * 
		 */		
		private function praseFriend(result:Object,fun:Function):void
		{
			var rankItemVO:RankListItemVO;
			var all_achieve:Object = result;
			if(all_achieve)
			{
				var acR:Object = all_achieve;
				var f:GameFriendVO;
				for(var i:String in acR)
				{
					rankItemVO = new RankListItemVO;
					rankItemVO.index = acR[i][0];
					rankItemVO.field = acR[i][1];
					rankItemVO.uid = i;
					if(uint(rankItemVO.uid) == userModel.myInfo.userId)
					{
						rankItemVO.name = userModel.myInfo.uNickName;
						rankItemVO.fbID = userModel.myInfo.uFB_ID;
						//						rankItemVO.field = NumUtil.n2kb(userModel.myInfo.uMoney.toNumber());
					}else
					{
						f = gameFriendProxy.getUserById(rankItemVO.uid);
						if(f)
						{
							rankItemVO.name = f.name;
							rankItemVO.fbID = f.fb_id;
							//							rankItemVO.field = NumUtil.n2kb(f.chip);
						}
					}
					rankItemVO.lastIndex = acR[i][2];
					fun.apply(null,[rankItemVO]);
				}
			}
		}	
	}
}