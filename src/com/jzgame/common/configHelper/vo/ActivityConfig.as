package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.vo.configs.ActivitesConfigVO;
	
	import flash.utils.Dictionary;
	
	public class ActivityConfig implements IConfigHelper
	{
		/***********
		 * name:    ActivityConfig
		 * data:    Sep 17, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _arr:Array = [];
		private var _dic:Dictionary = new Dictionary;
		public function ActivityConfig()
		{
		}
		
		public function setData(xml:XML):void
		{
		}
		
		public function setDataVO(value:Object):void
		{
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:ActivitesConfigVO;
			var detail:Object=value;
			if(detail)
			{
				for(var j:String in detail)
				{
					cvo = new ActivitesConfigVO;
					for(var i:String in detail[j])
					{
						if(cvo.hasOwnProperty(i))
						{
							cvo[i] = detail[j][i];
						}
					}
					var bonus:Array = [];
					if(detail[j].bonus)
					{
						for(var mm:String in detail[j].bonus)
						{
							var item:Array = [];
							for(var id:String in detail[j].bonus[mm] )
							{
								item.push(id);
								item.push(detail[j].bonus[mm][id]);
							}
							item.push(mm);
							bonus.push(item.join(AssetsCenter.COLON));
						}
					}
					
//				eg	"rank_bonus": {
//						"1": {
//							"101": 2000
//						},
//						"2": {
//							"101": 2000
//						},
//						"3": {
//							"101": 2000
//						},
//						"4-6": {
//							"101": 2000
//						},
//						"7-10": {
//							"101": 2000
//						},
//						"11-30": {
//							"101": 2000
//						},
//						"31-50": {
//							"101": 2000
//						}
//					}
					var realBonus:Array = [];
					if(detail[j].rank_bonus)
					{
						for(var mmr:String in detail[j].rank_bonus)
						{
							var rbo:Object = new Object;
							rbo.id = mmr.split("-")[0];
							rbo.index = mmr;
							for(id in detail[j].rank_bonus[mmr] )
							{
								rbo.bonusId = id;
								rbo.bonusNum = detail[j].rank_bonus[mmr][id];
							}
							realBonus.push(rbo);
						}
					}
					
					if(detail[j].refresh)
					{
						for(var jjj:String in detail[j].refresh)
						{
							cvo.refresh = jjj+":"+detail[j].refresh[jjj];
						}
					}
					//要排序！
					realBonus.sortOn("id",Array.NUMERIC);
					
					cvo.rewards = bonus;
					cvo.realBonus = realBonus;
					_arr.push(cvo);
					_dic[cvo.id] = cvo;
				}
			}
		}
		
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemById(id:String):ActivitesConfigVO
		{
			return _dic[id];
		}
	}
}