package com.spellife.util
{
	import com.jzgame.common.utils.LangManager;
	import com.spellife.event.GameTimeEvent;
	
	import flash.utils.getTimer;

	public class TimerManager
	{
		/*auther     :jim
		* file       :TimerManager.as
		* date       :Aug 27, 2014
		* description:
		*/
		
		private static var instance:TimerManager;
		//系统时间 (秒)
		private static var sysTime:Number = 0;
		private var timer:RealGameTimer;
		//动画
		public var animTimer:RealGameTimer;
		private var one:Vector.<Function> = new Vector.<Function>;
		
		public function TimerManager()
		{
			animTimer = new RealGameTimer(20);
			animTimer.start();
			timer = new RealGameTimer();
			timer.addEventListener(GameTimeEvent.SECOND, secondHandler);
		}
		
		public static function getInstance():TimerManager
		{
			if(!instance)instance = new TimerManager;
			return instance;
		}
		
		public function addCallBack(time:Number,callback:Function):void
		{
			if(!timer.isRunning)timer.start();
			switch(time)
			{
				case GameTimeEvent.ONE_SECOND:
					if(one && one.length>0 && one.indexOf(callback)!=1)
					{
						return;
					}
					one.push(callback);
					break;
			}
			trace("有几个计时器程序:"+one.length);
		}
		/**
		 * 移除 
		 * @param time
		 * @param callback
		 * 
		 */		
		public function removeCallBack(time:Number,callback:Function):void
		{
			var length:uint = 0;
			switch(time)
			{
				case GameTimeEvent.ONE_SECOND:
					removeFilter(one,callback);
					break;
			}
		}
		
		private function removeFilter(vec:Vector.<Function>,callBack:Function):void
		{
			var length:uint = 0;
			length = one.length;
			while(length--)
			{
				if(callBack == one[length])
				{
					trace("remove some one at:",one.length);
					one.splice(length,1);
					break;
				}
			}
			
			if(one.length == 0)
			{
				timer.stop();
			}
		}
		
		private function secondHandler(event:GameTimeEvent):void
		{
			for each(var callBack:Function in one)
			{
				callBack.call();
			}
		}
		/**
		 * 同步系统时间
		 * 只接受从服务器传来的 
		 * @param time
		 * 
		 */		
		public static function syncTime(time:Number):void
		{
			if(time == 0)
			{
				var date:Date = new Date;
				sysTime = Math.floor( date.getTime() / 1000 );
			}else
			{
				sysTime = time;
			}
		}
		
		/**
		 * 获取当前系统时间 (seconds)
		 * @return 
		 * 
		 */		
		public static function getCurrentSysTime():Number
		{
			return sysTime + (getTimer() / 1000);
		}

		/**
		 * 获取当前年份 
		 * @return 
		 * 
		 */		
		public static function getSysYear():String
		{
			var date:Date = new Date;
			date.setTime(getCurrentSysTime() * 1000);
			return date.fullYear.toString();
		}
		/**
		 * 获取当前月份 
		 * @return 
		 * 
		 */		
		public static function getSysMonth():String
		{
			var date:Date = new Date;
			date.setTime(getCurrentSysTime() * 1000);
			return (date.month+1).toString();
		}
		/**
		 * 获取当前星期几
		 * @return 
		 * 
		 */		
		public static function getSysWeekDay():String
		{
			var date:Date = new Date;
			date.setTime(getCurrentSysTime() * 1000);
			var day:uint = date.day;
			if(day == 0) day = 7;
			return (day).toString();
		}
		/**
		 * 获取当前月份第几天 
		 * @return 
		 * 
		 */		
		public static function getSysDay():String
		{
			var date:Date = new Date;
			date.setTime(getCurrentSysTime() * 1000);
			return (date.date).toString();
		}
		
		/**
		 * 获取上个月份 的天数
		 * @return 
		 * 
		 */	
		public static function getSysLastMonthDays():String
		{
			//0（一月）到 11（十二月）之间的一个整数。
			var month:int = int(getSysMonth());
			var year:int = int(getSysYear());
			if(month == 0)
			{
				year -=1;
				month = 11;
			}else
			{
				month-=1;
			}
			//设置到这个月的最后一天
			var date:Date = new Date(year, month);
			date.time -= 1;
			//这个月的总天数就是这个月的最后一天
			var totalDay:int = date.date;
			return totalDay.toString();
		}
		/**
		 * 获取当前月份 的天数
		 * @return 
		 * 
		 */	
		public static function getSysDays():String
		{
			//0（一月）到 11（十二月）之间的一个整数。
			var month:int = int(getSysMonth());
			var year:int = int(getSysYear());
			//设置到这个月的最后一天
			var date:Date = new Date(year, month);
			date.time -= 1;
			//这个月的总天数就是这个月的最后一天
			var totalDay:int = date.date;
			trace(year + "年" + (month + 1) + "月总共有：" + totalDay + "天");
			return totalDay.toString();
		}
		/**
		 * 当前已经跑时间 
		 * @return 
		 * 
		 */		
		public static function getRunningTimeString():String
		{
			var timer:Number = Math.floor( getTimer() / 1000 );
			var h:uint = Math.floor( timer / 3600 );
			var m:uint = Math.floor((timer % 3600) / 60);
			var s:uint = Math.floor((timer % 60));
			
			return h + ":" + m + ":" + s;
		}
		/**
		 * 获取时间字符串 年月日
		 * @param time 1970年后的秒数
		 * @return 
		 * 
		 */		
		public static function getGenTimerFormat(time:Number):String
		{
			var date:Date = new Date;
			date.setTime(time * 1000);
			var hours:String = date.hours.toString();
			if(hours.length < 2)
			{
				hours ="0" + hours;
			}
			var min:String = date.minutes.toString();
			if(min.length < 2)
			{
				min ="0" + min;
			}
			var timeM:String = hours +":" + min;
			return date.fullYear + "/" + (date.month + 1) + "/" + date.date;
		}
		/**
		 * 获取时间有几天
		 * @param time 秒数
		 * @return 
		 * 
		 */		
		public static function getDayStr(time:Number):Number
		{
			var timer:Number = Math.floor( time  );
			var d:uint = Math.floor( timer / 3600 / 24 );
			
			return d;
		}
		/**
		 * 获取当前月的第几天
		 * @param time 1970年后的秒数
		 * @return 
		 * 
		 */		
		public static function getMonthDay(time:Number):Number
		{
			var date:Date = new Date;
			date.setTime(time * 1000);
			return date.date;
		}
		/**
		 * 获取时间字符串 
		 * @param time 1970年后的秒数
		 * @return 
		 * 
		 */		
		public static function getTimerFormat(time:Number,tformat:String = "yy/mm/dd/hh:ii"):String
		{
			var date:Date = new Date;
			date.setTime(time * 1000);
			
			tformat = tformat.replace("yy",date.fullYear);
			
			var hours:String = date.hours.toString();
			if(hours.length < 2)
			{
				hours ="0" + hours;
			}
			
			tformat = tformat.replace("hh",hours);
			
			var min:String = date.minutes.toString();
			if(min.length < 2)
			{
				min ="0" + min;
			}
			
			tformat = tformat.replace("ii",min);
			
			var mon:String = String(date.month + 1);
			if(mon.length < 2)
			{
				mon ="0" + mon;
			}
			tformat = tformat.replace("mm",mon);
			
			var datee:String = String(date.date);
			if(datee.length < 2)
			{
				datee ="0" + datee;
			}
			tformat = tformat.replace("dd",datee);
			
			return tformat;
		}
		/**
		 * 任意时间
		 * @param time
		 * @return 
		 * 
		 */		
		public static function getTimeFormat(time:Number,tformat:String = "hh:ii:ss"):String
		{
			var format:String = "";
			var timer:Number = Math.floor( time  );
			var h:String = Math.floor( timer / 3600 ).toString();
			var m:String = Math.floor((timer % 3600) / 60).toString();
			var s:String = Math.floor((timer % 60)).toString();
			if(h.length < 2)
			{
				h = "0" + h;
			}
			
			tformat = tformat.replace("hh",h);
			if(m.length <2)
			{
				m = "0" + m;
			}
			
			tformat = tformat.replace("ii",m);
			
			if(s.length < 2)
			{
				s = "0"+s;
			}
			
			tformat = tformat.replace("ss",s);
			
			return tformat;
		}
		/**
		 * 获取最近登录 
		 * @param time
		 * @return 
		 * 
		 */		
		public static function getRecentDayFormat(time:Number):String
		{
			var loginTime:Number = Number( time  );
			var date:Date = new Date;
			date.setTime(loginTime * 1000);
			
			var recent:Number = TimerManager.getCurrentSysTime() - loginTime;
			recent = Math.max(0,recent);
			if(recent >= 86400 * 7)
			{
				return 7 + LangManager.getText("402220");
			}else if(recent >= 86400 * 6)
			{
				return 6 + LangManager.getText("402220");
				
			}else if(recent >= 86400 * 5)
			{
				return 5 + LangManager.getText("402220");
				
			}else if(recent >= 86400 * 4)
			{
				return 4 + LangManager.getText("402220");
				
			}else if(recent >= 86400 * 3)
			{
				return 3 + LangManager.getText("402220");
				
			}else if(recent >= 86400 * 2)
			{
				return 2 + LangManager.getText("402220");
				
			}else if(recent >= 86400 * 1)
			{
				return 1 + LangManager.getText("402220");
			}else
			{
				var hours:String = date.hours.toString();
				if(hours.length < 2)
				{
					hours ="0" + hours;
				}
				
				var min:String = date.minutes.toString();
				if(min.length < 2)
				{
					min ="0" + min;
				}
				
				return hours+":"+min;
			}
			
			
			return 7+LangManager.getText("402220");
		}
		/**
		 * 
		 * @param t
		 * @return 
		 * 
		 */		
		public static function getSpeDes(t:Number):String
		{
			var d:String = '';
			var recent:Number = TimerManager.getCurrentSysTime() - t;
			recent = Math.max(0,recent);
			var weeks:Number = recent / ( 86400 * 7 );
			if(weeks > 0)
			{
				d = LangManager.getText('500226',Math.floor(weeks));
			}else
			{
				var days:Number = recent / ( 86400);
				if(days > 0)
				{
					d = LangManager.getText('500227',Math.floor(days));
				}else
				{
					var hours:Number = recent / ( 3600);
					if(hours > 0)
					{
						d = LangManager.getText('500228',Math.floor(hours));
					}else
					{
						d = LangManager.getText('500229');
					}
				}
			}
			return d;
		}
	}
}