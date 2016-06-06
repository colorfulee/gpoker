package com.jzgame.view.windows.chat
{
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.loader.AssetsLoader;
	
	import flash.utils.ByteArray;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import lzm.starling.swf.Swf;
	import lzm.starling.swf.display.SwfMovieClip;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureAtlas;
	
	public class ChatAnimListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    ChatAnimListItem
		 * data:    Jan 12, 2016
		 * author:  jim
		 * des:
		 ***********/
		private var _anim:Swf;
		private var _animMovie:SwfMovieClip;
		public function ChatAnimListItem()
		{
			super();
		
			hasLabelTextRenderer = false;
			
			
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			if(!value)return;
			
			var bytes:ByteArray = AssetsLoader.getAssetManager().getByteArray(String(50000+Number(value)));
			var texture:TextureAtlas = AssetsLoader.getAssetManager().getTextureAtlas(String(50000+Number(value)));
			_anim = new Swf(bytes,AssetsLoader.getAssetManager(),50);
			_animMovie = _anim.createMovieClip("mc_anim",null,texture);
			_animMovie.x = 20;
			_animMovie.y = 50;
			_animMovie.scale = .77;
			addChild(_animMovie);
			_animMovie.gotoAndPlay(0);
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function touchHandler(e:TouchEvent):void
		{
			if(e.getTouch(this,TouchPhase.ENDED))
			{
				SignalCenter.onChatAnimItemTriggered.dispatch(String(data));
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			_anim.dispose(false);
			_animMovie.dispose();
			
			_anim = null;
			_animMovie = null;
		}
	}
}