package com.jzgame.common.configHelper.vo
{
	import com.jzgame.common.configHelper.IConfigHelper;
	import com.jzgame.common.vo.RecommendVO;
	
	public class RecommendConfig implements IConfigHelper
	{
		/*auther     :jim
		* file       :RecommendConfig.as
		* date       :Apr 1, 2015
		* description:
		*/
		private var _list:Array = [];
		public function RecommendConfig()
		{
		}
		
		public function setData(xml:XML):void
		{
			var cvo:RecommendVO;
			for(var j:String in xml.base)
			{
				cvo = new RecommendVO;
				cvo.chips    = Number(xml.base[j].chips);
				cvo.roomName = String(xml.base[j].recommend);
				_list.push(cvo);
			}
		}
		
		public function setDataVO(value:Object):void
		{
		}
		
		public function setJsonData(value:Object):void
		{
		}
	}
}