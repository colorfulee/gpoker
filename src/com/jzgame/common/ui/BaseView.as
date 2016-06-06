package com.jzgame.common.ui
{
import com.jzgame.common.utils.ResManager;
import com.jzgame.common.utils.Style;
import com.jzgame.enmu.AssetsName;
import com.spellife.display.ImageSelectBox;
import com.spellife.display.List;
import com.spellife.display.ListBar;
import com.spellife.display.MCButton;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.text.TextField;

/**
 *  
 * @author Rakuten
 * 
 */
public class BaseView extends Sprite
{
    public function BaseView()
    {
        super();
    }
	
	protected var asset:DisplayObjectContainer

	public function bindView(view:DisplayObjectContainer):void
	{
		asset = view;
		
		var num:uint = view.numChildren - 1;
		
		var target:DisplayObject;
		var viewName:String;
		var list:Array;
		for(var i:int = num; i >= 0; i--)
		{
			target = view.getChildAt(i);
			
			viewName = target.name;
			
//			trace(viewName)
			
			if(this.hasOwnProperty(viewName))
			{
				list = viewName.split('_');
				var displayObj:DisplayObject;
				switch(list[0])
				{
					case 'chkBox':
					case 'closeBtn':
					case 'list':
					case 'listBar':
					{
						this[viewName] = getComponent(list[0],target, i);
						break;
					}
					case 'btn':
						this[viewName] = (target as SimpleButton);
						break;
//					case 'ebtn':
//						this[viewName] = new EnabledButton(target as SimpleButton);
//						break;
					case 'mbtn':
						this[viewName] = new MCButton();
						MCButton(this[viewName]).bindView(target as MovieClip);
						view.addChildAt(this[viewName],i);
						break;
					case "mc":
						this[viewName] = (target as MovieClip);
						break;
					case "txt":
						this[viewName] = (target as TextField);
						break;
					case "lbtn": //default button
					{
						displayObj = new LabelButton();
						displayObj.name = viewName;
						displayObj.x = target.x;
						displayObj.y = target.y;
						displayObj.width = target.width;
						displayObj.height = target.height;
						asset.removeChild(target);
						asset.addChildAt(displayObj,i);
						break;
					}
					default:
						this[list[1]] = target;
						break;
				}
			}
		}
		
		addChild(asset);
		
		initilze();
	}
	
	private function getComponent(val:String, target:DisplayObject, index:int):DisplayObject
	{
		var displayObj:DisplayObject;
		switch(val)
		{
			case 'closeBtn':
			{
				displayObj = Style.getInstance().closeButton;
				displayObj.width = target.width;
				displayObj.height = target.height;
				break;
			}
			case 'list':
			{
				displayObj = new List();
				displayObj.width = target.width;
				displayObj.height = target.height;
				List(displayObj).setRect(target.transform.pixelBounds.clone());
				break;
			}
			case 'listBar':
			{
				displayObj = new ListBar();
				displayObj.width = target.width;
				displayObj.height = target.height;
//				ListBar(displayObj).setSize(target.width,target.height);
				break;
			}
			case 'chkBox':
			{
				displayObj = new ImageSelectBox(ResManager.getBitmapDataByName(AssetsName.ASSET_20000_SELECT_ARROW),
												ResManager.getBitmapDataByName(AssetsName.ASSET_20001_SELECT_BACKGROUND));
				break;
			}
		}
		displayObj.name = target.name;
		displayObj.x = target.x;
		displayObj.y = target.y;
//		addChildAt(displayObj,index);
		asset.removeChild(target);
		asset.addChild(displayObj);
		return displayObj;
	}
	
	protected function initilze():void
	{
		
	}
	
    public function dispose():void
    {
    }
}
}
