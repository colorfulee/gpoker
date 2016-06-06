package com.jzgame.util
{
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.style.IStyle;
	import com.jzgame.enmu.AssetsName;
	import com.spellife.display.ImageButton;
	import com.spellife.display.S9ImageButton;
	import com.spellife.display.Scale9BitmapData;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * 
	 * @author Rakuten
	 * 
	 */
	public class WebStyle implements IStyle
	{
		public function WebStyle()
		{
		}
		
		[Embed("../../../../resource/assets/03/dating_bg_scrollbackground.png")]
		private var _scrollBg:Class;
		
		/**
		 * 滚动条上按钮 
		 * @return 
		 * 
		 */		
		public function get listBarUpButton():ImageButton
		{
			var image:BitmapData = ResManager.getBitmapDataByName("20000_upArrow");
			return new ImageButton(image,image,image);
		}
		/**
		 * 滚动条下按钮 
		 * @return 
		 * 
		 */		
		public function get listBarDownButton():ImageButton
		{
			var image:BitmapData = ResManager.getBitmapDataByName("20000_downArrow");
			return new ImageButton(image,image,image);
		}
		/**
		 * 滚动条背景 
		 * @return 
		 * 
		 */		
		public function get listBarHandlerBack():Scale9BitmapData
		{
			var rect:Rectangle = new Rectangle(8,15,2,5);
			var image:BitmapData = Bitmap(new _scrollBg()).bitmapData;
			var s9b:Scale9BitmapData = new Scale9BitmapData(image,rect);
			return s9b;
		}
		/**
		 * 滚动条滑块 
		 * @return 
		 * 
		 */
		public function get listBarHandler():Scale9BitmapData
		{
			var rect:Rectangle = new Rectangle(5,15,1,1);
			var image:BitmapData = ResManager.getBitmapDataByName("20000_handler");
			var s9b:Scale9BitmapData = new Scale9BitmapData(image,rect);
			return s9b;
		}
		/**
		 * 任务完成弹窗背景 
		 * @return 
		 * 
		 */		
		public function get missionCompleteBg():Scale9BitmapData
		{
			var rect:Rectangle = new Rectangle(20,20,2,2);
			var image:BitmapData = ResManager.getBitmapDataByName("20000_missionCompleteBg");
			var s9b:Scale9BitmapData = new Scale9BitmapData(image,rect);
			return s9b;
		}
		/**
		 * 成就圆角半透明背景
		 * @return 
		 * 
		 */		
		public function get roundBg():Scale9BitmapData
		{
			var rect:Rectangle = new Rectangle(20,20,2,2);
			var image:BitmapData = ResManager.getBitmapDataByName("20000_s9_achievementRoundBg");
			var s9b:Scale9BitmapData = new Scale9BitmapData(image,rect);
			return s9b;
		}
		
		/**
		 * 成就圆角半透明over背景
		 * @return 
		 * 
		 */		
		public function get roundOverBg():Scale9BitmapData
		{
			var rect:Rectangle = new Rectangle(20,20,2,2);
			var image:BitmapData = ResManager.getBitmapDataByName("20000_s9_achievementRoundOverBg");
			var s9b:Scale9BitmapData = new Scale9BitmapData(image,rect);
			return s9b;
		}
		/**
		 * 任务完成弹窗背景 
		 * @return 
		 * 
		 */		
		public function get missionCompleteSmallBg():BitmapData
		{
			var image:BitmapData = ResManager.getBitmapDataByName("20000_missionCompleteSmallBg");
			return image;
		}
		/**
		 * 滚动条中间的icon
		 * @return 
		 * 
		 */		
		public function get scrollCenterIcon():BitmapData
		{
			var image:BitmapData = ResManager.getBitmapDataByName("20000_scrollCenterIcon");
			return image;
		}
		/**
		 * 获取统一按钮  圆角按钮 不能y軸拉伸
		 * @return 
		 * 
		 */		
		public function get imageNormalButton():S9ImageButton
		{
			var rect:Rectangle = new Rectangle(12,6,5,2);
			return new S9ImageButton(
				new Scale9BitmapData(ResManager.getBitmapDataByName("20001_s9ButtonBg_out"),rect),
				new Scale9BitmapData(ResManager.getBitmapDataByName("20001_s9ButtonBg_over"),rect),
				new Scale9BitmapData(ResManager.getBitmapDataByName("20001_s9ButtonBg_down"),rect)
			);
		}
		/**
		 * 获取统一按钮 方角按钮 不能拉伸
		 * @return 
		 * 
		 */		
		public function get imageRectNormalButton():ImageButton
		{
			return new ImageButton(
				ResManager.getBitmapDataByName("20000_storeConfirmBtnOut"),
				(ResManager.getBitmapDataByName("20000_storeConfirmBtnOver")),
				(ResManager.getBitmapDataByName("20000_storeConfirmBtnDown"))
			);
		}
		/**
		 * 获取关闭按钮 
		 * @return 
		 * 
		 */		
		public function get closeButton():ImageButton
		{
			return new ImageButton(ResManager.getBitmapDataByName("20000_closeBtnOut"),
				ResManager.getBitmapDataByName("20000_closeBtnOver"),
				ResManager.getBitmapDataByName("20000_closeBtnDown"));
		}
		/**
		 * 获取统一按钮 方角按钮 可以横向拉伸
		 * @return
		 *
		 */
		public function get imageRectNormalHorButton():S9ImageButton
		{
			var rect:Rectangle = new Rectangle(11,11,1,1);
			return new S9ImageButton(
				new Scale9BitmapData(ResManager.getBitmapDataByName("20000_imageRectNormalHorButtonOut"),rect),
				new Scale9BitmapData(ResManager.getBitmapDataByName("20000_imageRectNormalHorButtonOver"),rect),
				new Scale9BitmapData(ResManager.getBitmapDataByName("20000_imageRectNormalHorButtonDown"),rect)
			);
		}
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get rectAlphaBackground():Scale9BitmapData
		{
			var s9rect:Rectangle = new Rectangle(10,10,10,10);
			var s9:Scale9BitmapData = new Scale9BitmapData(ResManager.getBitmapDataByName(AssetsName.ASSET_20000_DETAIL_ALPHA_BG),s9rect);
			
			return s9;
		}
		/**
		 * 获取vip按钮 
		 * @return 
		 * 
		 */		
		public function get vipButton():ImageButton
		{
			return new ImageButton(ResManager.getBitmapDataByName("20000_vipOut"),
				ResManager.getBitmapDataByName("20000_vipOver"),
				ResManager.getBitmapDataByName("20000_vipDown"));
		}
	}
}
