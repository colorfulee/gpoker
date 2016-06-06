package com.jzgame.view.windows.chat
{
	import com.jzgame.loader.AssetsLoader;
	
	import lzm.starling.swf.Swf;
	import lzm.starling.swf.display.SwfMovieClip;
	
	import starling.display.Sprite;
	
	public class ChatInterAnimSheet extends Sprite
	{
		/***********
		 * name:    ChatInterAnimSheet
		 * data:    Jan 12, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _anim:Swf;
		private var _animMovie:SwfMovieClip;
		public function ChatInterAnimSheet(index:String)
		{
			super();
			
			_anim = new Swf(AssetsLoader.getAssetManager().getByteArray(String(50000+Number(index))),AssetsLoader.getAssetManager(),500);
			_animMovie = _anim.createMovieClip("mc_anim");
			_animMovie.scale = .77;
			addChild(_animMovie);
		}
		
		public function play(loop:Boolean = true):void
		{
			if(loop)
			{
				_animMovie.loop = true;
				_animMovie.gotoAndPlay(0);
			}else
			{
				//强制reset  避免没有播放完毕
				_animMovie.loop = false;
				_animMovie.gotoAndPlay(0);
				_animMovie.completeFunction = finish;
			}
		}
		/**
		 * 播放结束 
		 * 
		 */		
		public function finish(target:SwfMovieClip):void
		{
			_animMovie.completeFunction = null;
			_anim.dispose(false);
			_animMovie.dispose();
			this.removeFromParent(true);
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			_animMovie.completeFunction = null;
			_anim.dispose(false);
			_animMovie.dispose();
			
			trace('chat inte anim sheet dispose!!!!!!!');
		}
	}
}