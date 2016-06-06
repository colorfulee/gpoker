package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.vo.configs.JackpotVO;
	
	import flash.utils.Dictionary;
	
	public class JackpotConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :JackpotConfig.as
		* date       :Jan 14, 2015
		* description:jack pot 表
		*/
		public var _dic:Vector.<JackpotVO> = new Vector.<JackpotVO>();
		public function JackpotConfig()
		{
		}
		
		/**
		 * 
		 * @param xml
		 * 
		 */
		public function setData(xml:XML):void
		{
			//		<id>7001</id>
			//			<name>VIP Metal</name>
			//			<desc>1. valid in 30 days &lt;br&gt; 2.valid in 30 days&lt;/br&gt;</desc>
			//			<img>item_VIPMetal.png</img>
			//			<type>0</type>
			//			<effect>0</effect>
			//			<time>2592000</time>
			//			<expired>0</expired>
			var baseList:XMLList=xml.base;
			
			var cvo:JackpotVO;
			if(baseList && baseList.length()>=3)
			{
				for(var i:int=1;i<baseList.length();i++)
				{
					cvo = new JackpotVO;
					cvo.id=String(baseList[i].id);
					cvo.bonus=int(baseList[i].bonus);
					cvo.blind=int(baseList[i].blind);
					cvo.fee=int(baseList[i].fee);
					_dic.push(cvo);
					
				}
			}
			
		}
		
		public function setDataVO(value:Object):void
		{
			setJsonData(value);
		}
		
		public function setJsonData(value:Object):void
		{
			var cvo:JackpotVO;
			var detail:Object=value.detail;
			if(detail)
			{
				for(var j:String in detail)
				{
					cvo = new JackpotVO;
					
					cvo.id = String(detail[j].id);
					cvo.bonus=int(detail[j].bonus);
					cvo.blind=int(detail[j].blind);
					cvo.fee=int(detail[j].fee);
					_dic.push(cvo);
				}
			}
			
		}
		
		/**
		 * 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemById(id:String):JackpotVO
		{
			var vo:JackpotVO;
			if(_dic && _dic.length>0)
			{
				for(var i:int=1;i<_dic.length;i++)
				{
					if(_dic[i].id==id)
					{
						vo=_dic[i];
					}
				}
			}
			return vo;
		}
		
		public function getMinblind():int
		{
			var min:int=0;
			if(_dic && _dic.length>0)
			{
				min=_dic[0].blind;
			}
			return min;
		}
		/**
		 * 获取压注金额 
		 * @return 
		 * 
		 */		
		public function getCertainBet(blinds:Number):Number
		{
			if(blinds >= _dic[1].blind)
			{
				return _dic[1].fee;
			}else
			{
				return _dic[0].fee;
			}
		}
		
	}
}