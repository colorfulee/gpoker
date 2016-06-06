package com.jzgame.loader
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	
	import starling.utils.AssetManager;
	
	public class AssetsLoader extends EventDispatcher
	{
		/***********
		 * name:    AssetsLoader
		 * data:    Dec 1, 2015
		 * author:  jim
		 * des:
		 ***********/
		private static var _assets:AssetManager = new AssetManager;
		public function AssetsLoader(target:IEventDispatcher=null)
		{
			super(target);
			//log
			_assets.verbose = true;
		}
		

		static public function addQuene(assets:*):void
		{
			_assets.enqueue(assets);
		}
		
		static public function loadQuene(f:Function = null):void
		{
			if(!f)
			{
				_assets.loadQueue(loadProgress);
			}else
			{
				_assets.loadQueue(f);
			}
		}
		
		static public function loadProgress(p:Number):void
		{
			if(p==1)
			{
				trace("lllllllllllllllllload end!");
			}
		}
		
		static public function getByteArray(n:String):ByteArray
		{
			return _assets.getByteArray(n)
		}
		
		static public function getAssetManager():AssetManager
		{
			return _assets;
		}
	}
}