package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class TableConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :TableConfigModel.as
		* date       :Oct 8, 2014
		* description:
		*/
		private var _dic:Dictionary = new Dictionary;
		private var _chipDic:Dictionary = new Dictionary;
		private var _collectChip:Dictionary = new Dictionary;
		private var _pokerBackDic:Dictionary = new Dictionary;
		private var _handPokerDic:Dictionary = new Dictionary;
		private var _dealerDic:Dictionary = new Dictionary;
		
		public function TableConfig()
		{
		}
		
		/**
		 * 
		 * @param xml
		 * 
		 */		
		public function setData(xml:XML):void
		{
			var cvo:Point;
			var chip:Point;
			var collectChip:Point;
			var pokerBack:Point;
			var handPoker:Point;
			var dealer:Point;
			for(var j:String in xml.item)
			{
				cvo = new Point;
				chip = new Point;
				collectChip = new Point;
				pokerBack = new Point;
				handPoker = new Point;
				dealer = new Point;
				cvo.x = Number(xml.item[j].seat[0].@x);
				cvo.y = Number(xml.item[j].seat[0].@y);
				
				chip.x = Number(xml.item[j].chip[0].@x);
				chip.y = Number(xml.item[j].chip[0].@y);
				
				collectChip.x = Number(xml.item[j].collectChip[0].@x);
				collectChip.y = Number(xml.item[j].collectChip[0].@y);
				
				pokerBack.x = Number(xml.item[j].pokerBack[0].@x);
				pokerBack.y = Number(xml.item[j].pokerBack[0].@y);
				
				handPoker.x = Number(xml.item[j].handPoker[0].@x);
				handPoker.y = Number(xml.item[j].handPoker[0].@y);
				
				dealer.x = Number(xml.item[j].dealer[0].@x);
				dealer.y = Number(xml.item[j].dealer[0].@y);
				
				_dic[uint(xml.item[j].@index)] = cvo;
				_chipDic[uint(xml.item[j].@index)] = chip;
				_pokerBackDic[uint(xml.item[j].@index)] = pokerBack;
				_collectChip[uint(xml.item[j].@index)]  = collectChip;
				_handPokerDic[uint(xml.item[j].@index)]  = handPoker;
				_dealerDic[uint(xml.item[j].@index)]  = dealer;
			}
		}
		
		public function setDataVO(value:Object):void
		{
			var cvo:Point;
			var chip:Point;
			var collectChip:Point;
			var pokerBack:Point;
			var handPoker:Point;
			var dealer:Point;
			for(var j:String in value)
			{
				cvo = new Point;
				chip = new Point;
				collectChip = new Point;
				pokerBack = new Point;
				handPoker = new Point;
				dealer = new Point;
				cvo.x = Number(value[j].seat.x);
				cvo.y = Number(value[j].seat.y);
				
				chip.x = Number(value[j].chip.x);
				chip.y = Number(value[j].chip.y);
				
				collectChip.x = Number(value[j].collectChip.x);
				collectChip.y = Number(value[j].collectChip.y);
				
				pokerBack.x = Number(value[j].pokerBack.x);
				pokerBack.y = Number(value[j].pokerBack.y);
				
				handPoker.x = Number(value[j].handPoker.x);
				handPoker.y = Number(value[j].handPoker.y);
				
				dealer.x = Number(value[j].dealer.x);
				dealer.y = Number(value[j].dealer.y);
				//这个与解析json的唯一差别就是id序号
				value[j].index = uint(j) + 1;
				_dic[uint(value[j].index)] = cvo;
				_chipDic[uint(value[j].index)] = chip;
				_pokerBackDic[uint(value[j].index) ] = pokerBack;
				_collectChip[uint(value[j].index)]  = collectChip;
				_handPokerDic[uint(value[j].index)]  = handPoker;
				_dealerDic[uint(value[j].index)]  = dealer;
			}
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:Point;
			var chip:Point;
			var collectChip:Point;
			var pokerBack:Point;
			var handPoker:Point;
			var dealer:Point;
			for(var j:String in value)
			{
				cvo = new Point;
				chip = new Point;
				collectChip = new Point;
				pokerBack = new Point;
				handPoker = new Point;
				dealer = new Point;
				cvo.x = Number(value[j].seat.x);
				cvo.y = Number(value[j].seat.y);
				
				chip.x = Number(value[j].chip.x);
				chip.y = Number(value[j].chip.y);
				
				collectChip.x = Number(value[j].collectChip.x);
				collectChip.y = Number(value[j].collectChip.y);
				
				pokerBack.x = Number(value[j].pokerBack.x);
				pokerBack.y = Number(value[j].pokerBack.y);
				
				handPoker.x = Number(value[j].handPoker.x);
				handPoker.y = Number(value[j].handPoker.y);
				
				dealer.x = Number(value[j].dealer.x);
				dealer.y = Number(value[j].dealer.y);
				
				value[j].index = uint(j);
				_dic[uint(value[j].index)] = cvo;
				_chipDic[uint(value[j].index)] = chip;
				_pokerBackDic[uint(value[j].index)] = pokerBack;
				_collectChip[uint(value[j].index)]  = collectChip;
				_handPokerDic[uint(value[j].index)]  = handPoker;
				_dealerDic[uint(value[j].index)]  = dealer;
			}
		}
		
		/**
		 * 根据座位查找坐标 
		 * @param seat
		 * @return 
		 * 
		 */		
		public function getSeatPoint(seat:uint):Point
		{
			return _dic[seat];
		}
		/**
		 * 
		 * @param index
		 * @return 
		 * 
		 */		
		public function getCollectChipPoint(index:uint):Point
		{
			return _collectChip[index];
		}
		
		/**
		 * 
		 * @param seat
		 * @return 
		 * 
		 */		
		public function getChipPoint(seat:uint):Point
		{
			return _chipDic[seat];
		}
		/**
		 * 
		 * @param seat
		 * @return 
		 * 
		 */		
		public function getPokerBackPoint(seat:uint):Point
		{
			return _pokerBackDic[seat];
		}
		/**
		 * 获取庄按钮位置
		 * @param seat
		 * @return 
		 * 
		 */		
		public function getDealerPoint(seat:uint):Point
		{
			return _dealerDic[seat];
		}
		/**
		 * 
		 * @param seat
		 * @return 
		 * 
		 */		
		public function getHandPokerPoint(seat:uint):Point
		{
			return _handPokerDic[seat];
		}
	}
}