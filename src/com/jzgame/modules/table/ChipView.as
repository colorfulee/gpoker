package com.jzgame.modules.table
{
	import starling.display.Sprite;
	
	public class ChipView extends Sprite
	{
		/***********
		 * name:    ChipView
		 * data:    Nov 19, 2015
		 * author:  jim
		 * des:
		 ***********/
		public var tableChipContainer:Sprite = new Sprite;
		public var eachChipContainer:Sprite = new Sprite;
		public function ChipView()
		{
			super();
			
			addChild(tableChipContainer);
			addChild(eachChipContainer);
		}
		/**
		 * 清空所有筹码 
		 * 
		 */		
		public function reset():void
		{
			while(tableChipContainer.numChildren > 0)
			{
				var table:DealerChipTableItem = tableChipContainer.getChildAt(0) as DealerChipTableItem;
				table.dispose();
				tableChipContainer.removeChildAt(0);
			}
			while(eachChipContainer.numChildren > 0)
			{
				var chip:ChipTableItem = eachChipContainer.getChildAt(0) as ChipTableItem;
				chip.dispose();
				eachChipContainer.removeChildAt(0);
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			reset();
		}
	}
}