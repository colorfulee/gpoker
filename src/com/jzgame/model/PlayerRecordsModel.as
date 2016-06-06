package com.jzgame.model
{
	import com.jzgame.common.utils.LangManager;
	import com.jzgame.vo.PlayerRecordsItemVO;
	import com.jzgame.vo.PlayerRecordsVO;
	
	import flash.utils.Dictionary;

	public class PlayerRecordsModel
	{
		/*auther     :jim
		* file       :PlayerRecordsModel.as
		* date       :Jan 16, 2015
		* description:
		*/
		private var oneYear:String = "365";
		private var halfYear:String = "180";
		private var threeMonths:String = "90";
		private var oneMonth:String = "30";
		private var oneWeek:String = "7";
		private var twoDays:String = "2";
		private var oneDay:String = "1";
		private var _dic:Dictionary = new Dictionary;
		
		private var _dayList:Array = [];
		
		public function PlayerRecordsModel()
		{
			_dayList.push(oneYear,halfYear,threeMonths,oneMonth,oneWeek);
		}
		
		public function get dayList():Array
		{
			return _dayList;
		}

		public function addRecords(index:String, recordVO:PlayerRecordsVO):void
		{
			_dic[index] = recordVO;
		}
		
		public function getRecords(index:String):PlayerRecordsVO
		{
			return _dic[index];
		}
		/**
		 * 根据天数获取overview的数据 
		 * @param index
		 * @return 
		 * 
		 */		
		public function getOverViewRecords(index:String):Array
		{
			var recordsVO:PlayerRecordsVO = getRecords(index);
			if(!recordsVO)return [];
			var vo:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo.name = LangManager.getText("300901");
			vo.times = recordsVO.a;
			vo.percent = 1;
			var vo2:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo2.times = recordsVO.b;
			vo2.name = LangManager.getText("300902");
			vo2.percent = recordsVO.a == 0?0:recordsVO.b / recordsVO.a;
			return [vo,vo2];
		}
		/**
		 * 根据天数获取social的数据 
		 * @param index
		 * @return 
		 * 
		 */		
		public function getSocialViewRecords(index:String):Array
		{
			var recordsVO:PlayerRecordsVO = getRecords(index);
			if(!recordsVO)return [];
			var vo3:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo3.name = LangManager.getText("300903");
			vo3.times = recordsVO.c;
			vo3.percent = recordsVO.a == 0?0:recordsVO.c / recordsVO.a;
			var vo4:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo4.times = recordsVO.d;
			vo4.name = LangManager.getText("300904");
			vo4.percent = recordsVO.a == 0?0:recordsVO.d / recordsVO.a;
			return [vo3,vo4];
		}
		/**
		 * 根据天数获得回合的记录数据
		 * @param index
		 * @return 
		 * 
		 */		
		public function getRoundViewRecords(index:String):Array
		{
			var recordsVO:PlayerRecordsVO = getRecords(index);
			if(!recordsVO)return [];
			var vo5:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo5.name = LangManager.getText("300905");
			vo5.times = recordsVO.e;
			vo5.percent = recordsVO.a == 0?0:recordsVO.e / recordsVO.a;
			
			var vo6:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo6.times = recordsVO.f;
			vo6.name = LangManager.getText("300906");
			vo6.percent = recordsVO.a == 0?0:recordsVO.f / recordsVO.a;
			
			var vo7:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo7.times = recordsVO.g;
			vo7.name = LangManager.getText("300907");
			vo7.percent = recordsVO.a == 0?0:recordsVO.g / recordsVO.a;
			
			var vo8:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo8.times = recordsVO.h;
			vo8.name = LangManager.getText("300908");
			vo8.percent = recordsVO.a == 0?0:recordsVO.h / recordsVO.a;
			
			var vo9:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo9.times = recordsVO.i;
			vo9.name = LangManager.getText("300909");
			vo9.percent = recordsVO.a == 0?0:recordsVO.i / recordsVO.a;
			return [vo5,vo6,vo7,vo8,vo9];
		}
		/**
		 * 根据天数获得胜利的记录数据
		 * @param index
		 * @return 
		 * 
		 */		
		public function getWinViewRecords(index:String):Array
		{
			var recordsVO:PlayerRecordsVO = getRecords(index);
			if(!recordsVO)return [];
			var vo10:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo10.name = LangManager.getText("300910");
			vo10.times = recordsVO.j;
			vo10.percent = recordsVO.j / recordsVO.a;
			var vo11:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo11.times = recordsVO.k;
			vo11.name = LangManager.getText("300911");
			vo11.percent = recordsVO.k / recordsVO.a;
			var vo12:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo12.times = recordsVO.l;
			vo12.name = LangManager.getText("300912");
			vo12.percent = recordsVO.l / recordsVO.a;
			var vo13:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo13.times = recordsVO.m;
			vo13.name = LangManager.getText("300913");
			vo13.percent = recordsVO.m / recordsVO.a;
			var vo14:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo14.times = recordsVO.n;
			vo14.name = LangManager.getText("300914");
			vo14.percent = recordsVO.n / recordsVO.a;
			return [vo10,vo11,vo12,vo13,vo14];
		}
		/**
		 * 根据天数获得操作的记录数据
		 * @param index
		 * @return 
		 * 
		 */		
		public function getActionViewRecords(index:String):Array
		{
			var recordsVO:PlayerRecordsVO = getRecords(index);
			if(!recordsVO)return [];
			var actionAll:uint = recordsVO.o + recordsVO.p+recordsVO.q+recordsVO.r+recordsVO.s;
			var vo15:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo15.name = LangManager.getText("300915");
			vo15.times = recordsVO.o;
			vo15.percent = recordsVO.o / actionAll;
			var vo16:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo16.times = recordsVO.p;
			vo16.name = LangManager.getText("300916");
			vo16.percent = recordsVO.p / actionAll;
			var vo17:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo17.times = recordsVO.q;
			vo17.name = LangManager.getText("300917");
			vo17.percent = recordsVO.q / actionAll;
			var vo18:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo18.times = recordsVO.r;
			vo18.name = LangManager.getText("300918");
			vo18.percent = recordsVO.r / actionAll;
			var vo19:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo19.times = recordsVO.s;
			vo19.name = LangManager.getText("300919");
			vo19.percent = recordsVO.s / actionAll;
			return [vo15,vo16,vo17,vo18,vo19];
		}
		
		/**
		 * 根据天数获得弃牌的记录数据
		 * @param index
		 * @return 
		 * 
		 */		
		public function getFoldViewRecords(index:String):Array
		{
			var recordsVO:PlayerRecordsVO = getRecords(index);
			if(!recordsVO)return [];
			var vo20:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo20.name = LangManager.getText("300920");
			vo20.times = recordsVO.j;
			vo20.percent = recordsVO.j / recordsVO.a;
			var vo21:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo21.times = recordsVO.k;
			vo21.name = LangManager.getText("300921");
			vo21.percent = recordsVO.k / recordsVO.a;
			var vo22:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo22.times = recordsVO.l;
			vo22.name = LangManager.getText("300922");
			vo22.percent = recordsVO.l / recordsVO.a;
			var vo23:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo23.times = recordsVO.m;
			vo23.name = LangManager.getText("300923");
			vo23.percent = recordsVO.m / recordsVO.a;
			var vo24:PlayerRecordsItemVO = new PlayerRecordsItemVO;
			vo24.times = recordsVO.n;
			vo24.name = LangManager.getText("300924");
			vo24.percent = recordsVO.n / recordsVO.a;
			return [vo20,vo21,vo22,vo23,vo24];
		}
		
	}
}