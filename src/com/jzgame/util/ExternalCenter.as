package com.jzgame.util
{
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;

	public class ExternalCenter
	{
		/*auther     :jim
		* file       :ExternalCenter.as
		* date       :Feb 12, 2015
		* description:
		*/
		//新成就
		public static var SHARE_ACHIEVE:uint = 1;
		public static var SHARE_RANK:uint = 2;
		public static var SHARE_LEVEL:uint = 3;
		//成就排名
		public static var SHARE_ACHIEVEMENT:uint = 4;
		public static var SHARE_WHELL:uint = 5;
		public static var SHARE_SLOT:uint = 6;
		//大乐透
		public static var SHARE_JACK_POT:uint = 7;
		//打點
		public static var LOG_GAME_LOAD:String = "game_load";
		public static var LOG_OPEN_STORE:String = "store";
		public static var LOG_LIKE:String = "like";
		public static var LOG_HISTORY:String = "history";
		public static var LOG_MESSAGE:String = "message";
		public static var LOG_ACHIE:String = "achievement";
		public static var LOG_OPEN_PACKAGE:String = "property";
		public static var LOG_OPEN_RANK:String = "rank";
		public static var LOG_OPEN_TASK:String = "task";
		public static var LOG_OPEN_SETTING:String = "setting";
		public static var LOG_OPEN_FULL:String = "fullscreen";
		public static var LOG_PLAY_NOW:String = "playnow";
		public static var LOG_DAILY_BONUS:String = "dailybonus";
		public static var LOG_OPEN_TUTORIAL:String = "tutorial";
		public static var LOG_SEARCH_GAMEFRIEND:String = "searchfriend";
		public static var LOG_OPEN_MTT_SIGN_UP:String = "mtt_signup";
		public static var LOG_MTT_RESULT:String = "mtt_viewresult";
		public static var LOG_MTT_OBSERVE:String = "mtt_observe";
		
		public function ExternalCenter()
		{
		}
		/**
		 * 添加回调函数 
		 * @param fn
		 * @param f
		 * 
		 */		
		public static function addCallBack(fn:String,f:Function):void
		{
			ExternalInterface.addCallback(fn,f);
		}
		/**
		 * 打點 
		 * @param type
		 * 
		 */		
		public static function checkPoint(type:String):void
		{
			return;
			if(Capabilities.playerType != "StandAlone")
			{
				ExternalInterface.call("jz_ga",type);
			}
		}
		/**
		 * 刷新页面
		 * 
		 */		
		public static function refresh():void
		{
			ExternalInterface.call("refresh");
		}
		/**
		 * 更改语言 
		 * @param lang
		 * 
		 */		
		public static function changeLang(lang:String):void
		{
			ExternalInterface.call("change_lang",lang);
		}
		/**
		 * 邀请好友 
		 * 
		 */		
		public static function inviteFriends():void
		{
			ExternalInterface.call("fb_invite");
		}
		/**
		 * 显示点赞 
		 * 
		 */		
		public static function showLike():void
		{
			ExternalInterface.call("fb_like");
		}
		/**
		 * 显示help 
		 * 
		 */		
		public static function showHelp(index:uint = 0):void
		{
			ExternalInterface.call("show_help",index);
		}
		/**
		 * 增加筹码 
		 * 
		 */		
		public static function addChip(chip:Boolean = true):void
		{
			var type:String = "chip";
			if(!chip)
			{
				type = "coin";
			}
			ExternalInterface.call("show_store",type);
		}
		/**
		 * 
		 * @param type
		 * @param data
		 * 
		 */		
		public static function share(type:uint,data:Object):void
		{
//			var data:Object = new Object;
//			switch(type)
//			{
//				case SHARE_ACHIEVE:
//					data.achievement_name = "test";
//					break;
//				case SHARE_RANK:
//					data.play_name = "test";
//					data.chips_rank = "test";
//					break;
//				case SHARE_LEVEL:
//					data.play_name = "test";
//					data.level_rank = "test";
//					break;
//				case SHARE_ACHIEVEMENT:
//					data.play_name = "test";
//					data.achievement_rank = "test";
//					break;
//				case SHARE_WHELL:
//					data.play_name = "test";
//					break;
//				case SHARE_SLOT:
//					data.play_name = "test";
//					data.chips_num = "test";
//					break;
//			}
			ExternalInterface.call("post_wall",type,data);
		}
		/**
		 * 分享图片 
		 * @param raw_image
		 * @param image_type
		 * @param message
		 * 
		 */		
		public static function shareImg(raw_image:String, image_type:String="", message:String = ""):Boolean
		{
			return ExternalInterface.call("post_image",raw_image, image_type, "");
		}
		/**
		 * 好友召回 
		 * @param fb_id
		 * @param msg
		 * @return 
		 * 
		 */		
		public static function getFriendBack(fb_id:String , msg:String ):Boolean
		{
			return ExternalInterface.call("retrieve",fb_id,msg);
		}
		/**
		 * 召回密码 
		 * 
		 */		
		public static function findPass():void
		{
			ExternalInterface.call("feedback");
		}
	}
}