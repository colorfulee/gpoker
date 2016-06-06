package com.jzgame.model
{
	public class ActivitiesModel
	{
		/***********
		 * name:    ActivitiesModel
		 * data:    Sep 25, 2015
		 * author:  jim
		 * des:     活动模块
		 ***********/
		public var festervalTask:Array = [];
		public var festervalPoint:Number = 0;
		public var festervalCard:Array = [];
		
		public var hunterTask:Array = [];
		public var hunterBonus:Array = [];
		public var hunterPoint:Number = 0;
		public var hunterStart:Number = 0;
		public var hunterEnd:Number = 0;
		
		
		public var puzzleList:Array = [];
		public var puzzleInfo:Object;
		public var puzzleStart:Number;
		public var puzzleEnd:Number;
		public function ActivitiesModel()
		{
		}
	}
}