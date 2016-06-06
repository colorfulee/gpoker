package com.jzgame.common.utils
{
	import com.jzgame.common.vo.VersionObject;
	
	import flash.utils.Dictionary;

	public class VersionDic
	{
		private static var _instance:VersionDic;
		
		private var _dic:Dictionary = new Dictionary;
		
		public function getPathVO(path:String):VersionObject
		{
			return _dic[path];
		}
		
		public function addPathVersion(path:String, vo:VersionObject):void
		{
			_dic[path] = vo;
		}
		
		public static function getInstance():VersionDic
		{
			if(!_instance)_instance = new VersionDic;
			return _instance;
		}
	}
}