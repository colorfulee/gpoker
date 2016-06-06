package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.vo.GuideArrowVO;
	import com.jzgame.vo.GuideCardInfoVO;
	import com.jzgame.vo.GuideVO;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	public class GuideConfigModel implements IConfigHelper
	{
		/*auther     :jim
		* file       :GuideModel.as
		* date       :Sep 29, 2014
		* description:
		*/
		
		private var _dic:Dictionary = new Dictionary;
		private var _dicXML:Dictionary = new Dictionary;
		
		private var _facePosition:Vector.<Point> = new Vector.<Point>;
		private var _cardList:Array = [];
		public function GuideConfigModel()
		{
		}
		
		public function get cardList():Array
		{
			return _cardList;
		}

		/**
		 * 
		 * @param xml
		 * 
		 */		
		public function setData(xml:XML):void
		{
			var cvo:GuideVO;
			for(var j:String in xml.item)
			{
				cvo = new GuideVO;
				cvo.index     = uint(xml.item[j].@index);
				cvo.tipHole.x = Number(xml.item[j].hole[0].@x);
				cvo.tipHole.y = Number(xml.item[j].hole[0].@y);
				cvo.tipHole.width = Number(xml.item[j].hole[0].@width);
				cvo.tipHole.height = Number(xml.item[j].hole[0].@height);
				cvo.tipText.x = Number(xml.item[j].text[0].@x);
				cvo.tipText.y = Number(xml.item[j].text[0].@y);
				cvo.tipText.width = Number(xml.item[j].text[0].@width);
				cvo.tipText.height = Number(xml.item[j].text[0].@height);
				
				cvo.arrowVO.arrowDirection = Number(xml.item[j].text[0].@arrowDirection);
				cvo.arrowVO.arrowX = Number(xml.item[j].text[0].@arrowX);
				cvo.arrowVO.arrowY = Number(xml.item[j].text[0].@arrowY);
				_dic[cvo.index] = cvo;
			}
			var card:GuideCardInfoVO;
			
			for(var m:String in xml.cardInfo.item)
			{
				card = new GuideCardInfoVO;
				card.index = Number(xml.cardInfo.item[m].@index);
				card.shadow = Number(xml.cardInfo.item[m].@shadow);
				card.card = String(xml.cardInfo.item[m].@card).split(",");
				
				_cardList.push(card);
			}
		}
		
		/**
		 * 设置release配置 
		 * @param value
		 * 
		 */		
		public function setDataVO(value:Object):void
		{
			var cvo:GuideVO;
			for(var j:String in value.item)
			{
				cvo = new GuideVO;
				cvo.index     = Number(value.item[j].index);;
				cvo.tipHole.x = Number(value.item[j].hole.x);
				cvo.tipHole.y = Number(value.item[j].hole.y);
				cvo.tipHole.width = Number(value.item[j].hole.width);
				cvo.tipHole.height = Number(value.item[j].hole.height);
				cvo.tipText.x = Number(value.item[j].text.x);
				cvo.tipText.y = Number(value.item[j].text.y);
				cvo.tipText.width = Number(value.item[j].text.width);
				cvo.tipText.height = Number(value.item[j].text.height);
				
				cvo.arrowVO.arrowDirection = Number(value.item[j].text.arrowDirection);
				cvo.arrowVO.arrowX = Number(value.item[j].text.arrowX);
				cvo.arrowVO.arrowY = Number(value.item[j].text.arrowY);
				_dic[cvo.index] = cvo;
			}
			var card:GuideCardInfoVO;
			
			for(var m:String in value.cardInfo)
			{
				card = new GuideCardInfoVO;
				card.index = Number(value.cardInfo[m].index);
				card.shadow = Number(value.cardInfo[m].shadow);
				card.card = String(value.cardInfo[m].card).split(",");
				
				_cardList.push(card);
			}
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:GuideVO;
			for(var j:String in value.item)
			{
				cvo = new GuideVO;
				cvo.index     = uint(j);
				cvo.tipHole.x = Number(value.item[j].hole.x);
				cvo.tipHole.y = Number(value.item[j].hole.y);
				cvo.tipHole.width = Number(value.item[j].hole.width);
				cvo.tipHole.height = Number(value.item[j].hole.height);
				cvo.tipText.x = Number(value.item[j].text.x);
				cvo.tipText.y = Number(value.item[j].text.y);
				cvo.tipText.width = Number(value.item[j].text.width);
				cvo.tipText.height = Number(value.item[j].text.height);
				
				cvo.arrowVO.arrowDirection = Number(value.item[j].text.arrowDirection);
				cvo.arrowVO.arrowX = Number(value.item[j].text.arrowX);
				cvo.arrowVO.arrowY = Number(value.item[j].text.arrowY);
				_dic[cvo.index] = cvo;
			}
			var card:GuideCardInfoVO;
			
			for(var m:String in value.cardInfo)
			{
				card = new GuideCardInfoVO;
				card.index = Number(value.cardInfo[m].index);
				card.shadow = Number(value.cardInfo[m].shadow);
				card.card = String(value.cardInfo[m].card).split(",");
				
				_cardList.push(card);
			}
		}
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getText(id:String):String
		{
			return _dic[id].text;
		}
		
		/**
		 * 获取引导的位置
		 * @param step
		 * @return 
		 * 
		 */		
		public function getTipsPositionByStep(step:uint):Rectangle
		{
			Tracer.info("getTipsPositionByStep:"+step);
			var rect:Rectangle = GuideVO(_dic[step]).tipText;
			
			return rect;
		}
		/**
		 * 
		 * @param step
		 * @return 
		 * 
		 */		
		public function getArrowVO(step:uint):GuideArrowVO
		{
			var rect:GuideArrowVO = GuideVO(_dic[step]).arrowVO;
			
			return rect;
		}
		/**
		 * @param step
		 * @return 
		 * 
		 */		
		public function getTipsHoleByStep(step:uint):Rectangle
		{
			var rect:Rectangle = GuideVO(_dic[step]).tipHole;
			return rect;
		}
		/**
		 * 获取头像的位置
		 * @param seatId
		 * @return 
		 * 
		 */		
		public function getFacePosition(seatId:uint):Point
		{
			var p:Point = _facePosition[seatId - 1];
			
			return p;
		}
	}
}