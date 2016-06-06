package com.jzgame.view.display
{
	import com.jzgame.enmu.SystemColor;
	import com.spellife.util.HtmlTransCenter;
	
	public class RectToolTip extends DefaultToolTip
	{
		/*auther     :jim
		* file       :DefaultToolTip.as
		* date       :Apr 30, 2015
		* description:可换行基础类
		*/
		public function RectToolTip(tip:String)
		{
			super(tip);

			_label.autoTextSzie = true;
			_label.setLocation(5,5);
			_label.font = HtmlTransCenter.Arial();
			_label.color = SystemColor.MISSION_TEXT;
			_label.size = 14;
			_label.multiline = true;
			_label.wordWrap = true;
			_label.width = 200;
			_label.text = _tip;
			
			_back.width  = _label.width + 10;
			_back.height = _label.height + 10;
			
			_arrow.x = Math.floor((_back.width - _arrow.width) * .5);
		}
	}
}