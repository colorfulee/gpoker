package com.jzgame.view.windows
{
	import com.jzgame.loader.AssetsLoader;
	import com.jzgame.util.WindowFactory;
	import com.spellife.display.PopUpWindow;
	
	import lzm.starling.swf.Swf;
	import lzm.starling.swf.display.SwfMovieClip;
	
	public class PopUpCommunicateWindow extends PopUpWindow
	{
		/*auther     :jim
		* file       :PopUpCommunicateWindow.as
		* date       :Apr 14, 2015
		* description:通讯弹窗
		*/
		private var _swf:Swf;
		private var _swfMovie:SwfMovieClip;
		public function PopUpCommunicateWindow()
		{
			super();
			
			_motionEffect = null;
			_modalVisible = false;
			_isModal = true;
			_isSole = false;
			init();
		}
		
		private function init():void
		{
			_swf = new Swf(AssetsLoader.getAssetManager().getByteArray("20050"),AssetsLoader.getAssetManager(),500);
			_swfMovie = _swf.createMovieClip("mc_20050");
			addChild(_swfMovie);
			_swfMovie.stop();
			
//			_anim = new Swf(AssetsLoader.getAssetManager().getByteArray(String(50000 + Number(data))),AssetsLoader.getAssetManager(),500);
//			_animMovie = _anim.createMovieClip("mc_anim");
//			addChild(_animMovie);
//			_animMovie.gotoAndPlay(0);
//			var movie:MovieClip = new MovieClip(atlas.getTextures("loading"), 10);
////			movie.loop = false; // default: true
//			addChild(movie);
//			// 控制播放
//			movie.play();
////			movie.pause();
////			movie.stop();
//			
//			// 注意：添加movie到juggler
//			Starling.juggler.add(movie);
		}
		
		override protected function initShow():void
		{
			_swfMovie.gotoAndPlay(0);
		}
		
		override protected function initHide():void
		{
			_swfMovie.gotoAndStop(0);
		}
		
		override public function get name():String
		{
			return WindowFactory.COMMUNICATE_WINDOW;
		}
		
		override public function dispose():void
		{
			
		}
	}
}