package com.spellife.util
{
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/** 
	 * @Content 
	 * @Author jim 
	 * @Version 1.0.0 
	 * @Date：Mar 15, 2013 3:58:11 PM 
	 * @description:
	 */ 
	public class CloneUtil
	{
		/**
		 * 从obj中克隆属性  
		 * @param target 目标对象
		 * @param origan 原始需要克隆的对象
		 * 
		 */			
		public static function cloneFromObj(target:Object, origan:Object):void
		{
			for(var i:String in origan)
			{
				target[i] = origan[i];
				trace('cloneFromObj:',i,target[i],origan[i]);
			}
		}
		/**
		 * 从obj中深度克隆属性 ，数据最佳
		 * 复制一定要用返回对象赋值，避免将target从接口传入赋值，此种无效,即不支持构造函数需要传参数的克隆
		 * 即使内部实例的类中构造函数需要参数的也会失效
		 * @param target
		 * @param origan
		 * 
		 */		
		public static function deepClone(origan:Object):*
		{
			//复制对象
			var copier:ByteArray = new ByteArray();
			copier.writeObject(origan);
			copier.position = 0;
			return copier.readObject();
		}
		/**
		 * 深度复制类 
		 * @param origan
		 * @return 
		 * 
		 */		
		public static function deepCloneClass(origan:Object):*
		{
			var typeName:String = getQualifiedClassName(origan);//获取全名
			trace('输出类的结构'+typeName);
			//return;
			var packageName:String = typeName.split('::')[0];//切出包名
			trace('类的名称'+packageName);
			var type:Class = getDefinitionByName(typeName) as Class;//获取Class
			//				trace(type);
			registerClassAlias(packageName, type);//注册Class
			
			//复制对象
			var copier:ByteArray = new ByteArray();
			copier.writeObject(origan);
			copier.position = 0;
			return copier.readObject();
		}
		
		/**
		 * //重写索引，方便保存与解析
		 * @param p
		 * @return 
		 * 
		 */		
		public static function specialIndex(p:Point):String
		{
//			trace('specialIndex:', p.x + ',' + p.y);
			return  p.x + ',' + p.y;
		}
	}
}