package com.jzgame.vo
{
	import com.jzgame.modules.table.ChipTableItem;
	import com.spellife.vo.ValueObject;
	
	import starling.display.Sprite;
	
	public class TableClipVO extends ValueObject
	{
		/*auther     :jim
		* file       :TableClipVO.as
		* date       :Aug 28, 2014
		* description:
		*/
		public var clip:Number  = 0;
		public var seatID:uint = 0;//谁发的筹码
		public var belongs:uint =0;//属于哪个池子 主池或者边池
		public function TableClipVO(clip_:Number,belongs_:uint)
		{
			super();
			
			clip = clip_;
			belongs = belongs_;
		}
		
		public function clear():void
		{
			clip = 0;
			seatID = 0;
//			if(clipItemView)
//			{
//				clipItemView.dispose();
//			}
//			clipItemView = null;
		}
	}
}