package com.jzgame.common.model.message
{
	import com.jzgame.common.configHelper.Configure;
	import com.jzgame.common.services.http.events.HttpResponseEvent;
	import com.jzgame.common.vo.MTTConfigVO;
	import com.jzgame.common.vo.MessageCenterVO;
	import com.jzgame.common.vo.SpeMTTConfigVO;
	import com.jzgame.enmu.EventType;
	import com.jzgame.model.UserModel;
	import com.jzgame.util.ItemStringUtil;
	import com.jzgame.util.WindowFactory;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;

	/**
	 * auther     :jim
	 * file       :HttpReceivedMessageCommand.as
	 * date       :Dec 2, 2014
	 * description:
	 */
	public class HttpReceivedMessageCommand extends Command
	{
		[Inject]
		public var event:HttpResponseEvent;
		
		[Inject]
		public var messageProxy:MessageProxy;
		
		[Inject]
		public var userModel:UserModel;
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		public function HttpReceivedMessageCommand()
		{
			super();
		}
		
		override public function execute():void
		{
//			"e": 0,
//			"r": {
//				"u:1001:547834d96f2f1": {
//					"type": 901,
//					"uid": "1002",
//					"source_uid": "1001",
//					"data": {
//						"fb_id": "765749800139421",
//						"fb_first_name": "继明 李"
//					},
//					"time": 1417163993,
//					"status": 1
//				}
//			}
			WindowFactory.hideCommuWindow();
//			var test:String = 'f?fa???	iì? g7÷￠M	?S9???a_uL,m)Ya?￥??????3???°?í÷óbx9übn??)I????]DoS?(]yo??°??nD:±o	^?s±=F*?o?Eü???*?BT6?￡?Gí??5NáZu2*??Qy8?4??D|±￥Xeê?á???^?·,{Q ?í NònéC????í?′¤?í|N^j??V]￠Mü}fó?N¤B?Ri}Ek?ó?e2>???aó?ma??yVF`m}"foN?í?&??óKˉT?ütí?μùD6ê;ì~:?Q¤t?R?￠??M?'
//			var httpRe:HttpResponse = HttpSendProxy.decode(test);
//return;
			var result:Object = event.result;
			if(!result)return;
			messageProxy.removeAll();
			
			var vo:MessageCenterVO;
			var json:Object;
			var message:Object = result["message"];
			var voArr:Array = [];
			var voUnReadArr:Array = [];
			var unread:uint = 0;
			for(var uuid:String in message)
			{
				json = message[uuid];
				vo = new MessageCenterVO;
				vo.type = json.type;
				vo.fromUid = json.source_uid;
				vo.uid = json.uid;
				vo.id = uuid;
				vo.myName = userModel.myInfo.uNickName;
				vo.happenTime = json.time;
				vo.status = json.status;
				//如果已经删除的不显示
				if(vo.status == MessageCenterVO.REMOVE )continue;

				if(vo.status == MessageCenterVO.NORMAL)
				{
					unread++;
					voUnReadArr.push(vo);
				}else
				{
					voArr.push(vo);
				}

				switch(vo.type)
				{
					//901 好友请求
					case MessageProxy.ADD_FRIEND:
						vo.index = json.id;
						vo.friendFBID = json.data.fb_id;
						vo.friendName = json.data.fb_first_name + json.data.fb_last_name;
						break;
					//902 收到好友礼物
					case MessageProxy.SEND_GIFT:
						vo.friendFBID = json.data.fb_id;
						vo.friendName = json.data.fb_first_name + json.data.fb_last_name;	
						break;
					//903 向好友请求礼物
					case MessageProxy.ASK_GIFT:
						vo.friendFBID = json.data.fb_id;
						vo.friendName = json.data.fb_first_name + json.data.fb_last_name;	
						break;
					case MessageProxy.GLOBAL_MESSAGE:
						vo.text = json.data.message;
//						vo.bonus = json.data.bonus;
//						"text":"xxx", # 消息内容
//						"bonus" : {101:20, 102:30}, //奖励

						break;
					case MessageProxy.CASH_BUY:
//						"type":"xxx" # 1--》chip  2--》coin
//						"num":"xxx" # num
						vo.itemId = json.data.type;
						vo.itemNum = json.data.num;
						break;
					case MessageProxy.MTT_SIGN_IN:
						var mttVO:MTTConfigVO = Configure.mttConfig.getItemById(json.data.mtt_id);
						if(mttVO)
						{
							vo.text = mttVO.name;
						}
						break;
					case MessageProxy.MTT_RESULT:
//						"match_id":"xxx" # 1--》chip  2--》coin
//						"rank":"xxx" # num
//						"bonus" : 'xx'

						vo.text = json.data.rank;
						vo.bonus = ItemStringUtil.getBonusString(json.data.bonus);
//						vo.bonus = json.data.bonus;
						messageProxy.addGlobal(vo);
						break;
					case MessageProxy.UPDATE_GIFT:
						vo.text = json.data.level;
						break;
					case MessageProxy.INVITE_ROUND:
//						"fb_id":"xxx",          # 请求人的fb_id
//						"fb_first_name":"xxx",        # 请求人的fb_name
//						"fb_last_name":"xxx",        # 请求人的fb_name
//						"table_id":"10101",     # table ID
//						"table_name":"Shanghai" # table name

						vo.fb_id = json.data.fb_id;
//						vo.name = json.data.fb_first_name + " "+json.data.fb_last_name;
						vo.name = json.data.fb_name;
						vo.tableId = json.data.table_id;
						vo.tableName = json.data.table_name;
						break;
					case MessageProxy.PRIZE_TODO:
						vo.bonus = ItemStringUtil.getBonusString(json.data.bonus);
						vo.ext = json.data.ext;
						vo.dataType = json.data.type;
						break;
					case MessageProxy.JACK_POT_PRIZE:
						var chip:Object = {101:json.data.bonus}
						vo.bonus = ItemStringUtil.getBonusString(chip);
						break;
					case MessageProxy.SPE_MTT_SIGN_IN:
						var spemttVO:SpeMTTConfigVO = Configure.speMttConfig.getItemById(json.data.mtt_id);
						if(spemttVO)
						{
							vo.text = spemttVO.name;
						}
						break;
					case MessageProxy.SPE_MTT_RESULT:
//						"match_id":"xxx" # 1--》chip  2--》coin
//						"rank":"xxx" # num
//						"bonus" : 'xx'

						vo.text = json.data.rank;
						vo.bonus = ItemStringUtil.getBonusString(json.data.bonus);
//						vo.bonus = json.data.bonus;
						messageProxy.addGlobal(vo);
						break;
				}
			}

			voArr.sortOn("happenTime",Array.NUMERIC);
			voArr.reverse();

			voUnReadArr.sortOn("happenTime",Array.NUMERIC);
			voUnReadArr.reverse();

			var all:Array = voUnReadArr.concat(voArr);
			for(var uuuid:String in all)
			{
				vo = all[uuuid];

				switch(vo.type)
				{
					//901 好友请求
					case MessageProxy.ADD_FRIEND:
						messageProxy.addBuddy(vo);
						break;
					//902 收到好友礼物
					case MessageProxy.SEND_GIFT:
						messageProxy.addBuddy(vo);
						break;
					//903 向好友请求礼物
					case MessageProxy.ASK_GIFT:
						messageProxy.addBuddy(vo);
						break;
					case MessageProxy.GLOBAL_MESSAGE:
						messageProxy.addGlobal(vo);
//						vo.bonus = json.data.bonus;
//						"text":"xxx", # 消息内容
//						"bonus" : {101:20, 102:30}, //奖励

						break;
					case MessageProxy.CASH_BUY:
//						"type":"xxx" # 1--》chip  2--》coin
//						"num":"xxx" # num
						messageProxy.addPay(vo);
						break;
					case MessageProxy.MTT_SIGN_IN:
						messageProxy.addGlobal(vo);
						break;
					case MessageProxy.MTT_RESULT:
//						"match_id":"xxx" # 1--》chip  2--》coin
//						"rank":"xxx" # num
//						"bonus" : 'xx'

//						vo.bonus = json.data.bonus;
						messageProxy.addGlobal(vo);
						break;
					case MessageProxy.UPDATE_GIFT:
						messageProxy.addGlobal(vo);
						break;
					case MessageProxy.PRIZE_TODO:
						messageProxy.addGlobal(vo);
						break;
					//MTT_START
					case MessageProxy.MTT_START:
						messageProxy.addGlobal(vo);
						break;
					//SPEMTT_START
					case MessageProxy.SPE_MTT_START:
						messageProxy.addGlobal(vo);
						break;
					case MessageProxy.JACK_POT_PRIZE:
						messageProxy.addGlobal(vo);
						break;
					case MessageProxy.SPE_MTT_SIGN_IN:
						messageProxy.addGlobal(vo);
						break;
					case MessageProxy.SPE_MTT_RESULT:
//						"match_id":"xxx" # 1--》chip  2--》coin
//						"rank":"xxx" # num
//						"bonus" : 'xx'

//						vo.bonus = json.data.bonus;
						messageProxy.addGlobal(vo);
						break;
				}
			}
			messageProxy.addMessages(all);
			if(unread>0)
			{
				eventDispatcher.dispatchEvent(new Event(EventType.SHOW_MESSAGE_RED_ICON));
			}else
			{
				eventDispatcher.dispatchEvent(new Event(EventType.HIDE_MESSAGE_RED_ICON));
			}
			
		}
	}
}