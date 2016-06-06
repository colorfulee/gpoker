package com.jzgame.model
{
	public class NoteModel
	{
		/*auther     :jim
		* file       :NoteModel.as
		* date       :May 28, 2015
		* description:公告模板
		*/
		
		private var _list:Array = [];
		
		public function NoteModel()
		{
		}
		
//		{"1":{"icon":"https:\/\/g1.dev.jizeipoker.gamagic.com\/images\/announcement\/1_icon.jpg",
//			"img":"https:\/\/g1.dev.jizeipoker.gamagic.com\/images\/announcement\/1_zh_tw.jpg",
//			"msg":"111",
//			"link":"jackpot_rule","index":"0"
//		},
		public function update(v:Object):void
		{
			for(var i:String in v)
			{
				_list.push(v[i]);
			}
		}
		
		public function getList():Array
		{
			return _list.concat();
		}
	}
}