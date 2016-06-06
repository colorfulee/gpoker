package com.jzgame.common.utils
{
	import com.jzgame.enmu.ReleaseUtil;
	
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;

	public class DisplayManager
	{
		/*auther     :jim
		* file       :DisplayManager.as
		* date       :Dec 22, 2014
		* description:
		*/
		public function DisplayManager()
		{
		}
		
		/**
		 * 
		 * @param target 目标
		 * @param ruleTarget 标尺
		 * 
		 */		
		public static function centerY(target:DisplayObject,ruleTarget:DisplayObject):void
		{
			target.y =  Math.floor(ruleTarget.y +(ruleTarget.height - target.height ) *0.5);
		}
		/**
		 * 
		 * @param target 目标
		 * @param ruleTarget 标尺
		 * 
		 */		
		public static function centerX(target:DisplayObject,ruleTarget:DisplayObject):void
		{
			target.x =  Math.floor(ruleTarget.x +(ruleTarget.width - target.width ) *0.5);
		}
		/**
		 * 
		 * @param target 目标
		 * @param ruleTarget 标尺
		 * 
		 */		
		public static function center(target:DisplayObject,ruleTarget:DisplayObject):void
		{
			target.x =  Math.floor(ruleTarget.x +(ruleTarget.width - target.width ) *0.5);
			target.y =  Math.floor(ruleTarget.y +(ruleTarget.height - target.height ) *0.5);
		}
		/**
		 * 
		 * @param target
		 * @param centerPoint
		 * 
		 */		
		public static function centerYByPoint(target:DisplayObject,height:Number):void
		{
			target.y = Math.floor((height - target.height)  *0.5);
		}
		/**
		 * 按照点居中
		 * @param target
		 * @param centerPoint
		 * 
		 */		
		public static function centerByPoint(target:DisplayObject,centerPoint:Point):void
		{
			target.x = Math.floor((centerPoint.x - target.width  *0.5));
			target.y = Math.floor((centerPoint.y - target.height  *0.5));
		}
		/**
		 * 场景居中
		 * @param target
		 * 
		 */		
		public static function centerByStage(target:DisplayObject):void
		{
			target.x =  Math.floor((ReleaseUtil.STAGE_WIDTH - target.width ) *0.5);
			target.y =  Math.floor((ReleaseUtil.STAGE_HEIGHT - target.height ) *0.5);
		}
		/**
		 * 
		 * @param target
		 * 
		 */		
		public static function clearItemStage(target:DisplayObjectContainer):void
		{
			while(target.numChildren > 0)
			{
				target.removeChildAt( 0 );
			}
//			disposeOne(target,true);
		}
		/**
		 * 销毁我 
		 * @param $displayObject
		 * @param dispose
		 * 
		 */		
		public static function disposeMe($displayObject:DisplayObjectContainer,dispose:Boolean=false):void
		{
			var displayObjectContainer:DisplayObjectContainer;
			displayObjectContainer = $displayObject as DisplayObjectContainer;
			var $tempDisplayObject:DisplayObject;
			for (var i:int=displayObjectContainer.numChildren-1; i>=0; --i)
			{
				$tempDisplayObject = displayObjectContainer.getChildAt(i);
				$tempDisplayObject.removeFromParent(dispose);
			}
			displayObjectContainer.removeFromParent(false);
		}
		public static function disposeOneAll($displayObject:DisplayObject,dispose:Boolean=false):void
		{
			var displayObjectContainer:DisplayObjectContainer;
			if($displayObject is DisplayObjectContainer)
			{
				displayObjectContainer = $displayObject as DisplayObjectContainer;
				var $tempDisplayObject:DisplayObject;
				for (var i:int=displayObjectContainer.numChildren-1; i>=0; --i)
				{
					$tempDisplayObject = displayObjectContainer.getChildAt(i);
					if($tempDisplayObject is DisplayObjectContainer)
					{
						disposeOneAll($tempDisplayObject,dispose);
						$tempDisplayObject.removeFromParent(dispose);
					}
					else
					{
						$tempDisplayObject.removeFromParent(dispose);
					}
				}
				displayObjectContainer.removeFromParent(dispose);
			}
			else
			{
				$displayObject.removeFromParent(dispose);
			}
		}

		/**
		 * 清除图片 
		 * @param target
		 * 
		 */		
		public static function disposeBitmap(target:Image):void
		{
			if(target)
			{
				target.dispose();
			}
		}
		/**
		 * 批量清除图片 
		 * @param rests
		 * 
		 */		
		public static function disposeBitmaps(...rests):void
		{
			for(var i:String in rests)
			{
				disposeBitmap(rests[i] as Image);
			}
		}
	}
}