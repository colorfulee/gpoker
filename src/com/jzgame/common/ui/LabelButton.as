package com.jzgame.common.ui
{
import com.jzgame.enmu.SystemColor;
import com.jzgame.common.utils.ResManager;
import com.spellife.display.S9ImageButton;
import com.spellife.display.SLLabel;
import com.spellife.display.Scale9BitmapData;
import com.spellife.util.HtmlTransCenter;

import flash.display.Sprite;
import flash.geom.Rectangle;
/**
 * 带文字按钮
 * @author Rakuten
 * 
 */
public class LabelButton extends Sprite
{
	
    public function LabelButton()
    {

        initDisplay();
    }

	protected var imageBtn:S9ImageButton;
	protected var sl:SLLabel;

	public function get htmlText():String
	{
		return sl.htmlText;
	}

	public function set htmlText(value:String):void
	{
		sl.htmlText=HtmlTransCenter.getHtmlStr(value, SystemColor.STR_GUIDE_BUTTON_TEXT, 12, "");
//		imageBtn.setScaleX(1.5);
		sl.x=imageBtn.width * 0.5 - sl.width * 0.5;
	}

	public function get text():String
	{
		return sl.text;
	}

	public function set text(value:String):void
	{
		sl.text=value
//		imageBtn.setScaleX(1.5);
		sl.x=imageBtn.width * 0.5 - sl.width * 0.5;
	}
	
    protected function initDisplay():void
    {
        this.mouseChildren=false;
        this.useHandCursor=true;

        var rect:Rectangle = new Rectangle(20, 5, 10, 5);
        imageBtn=new S9ImageButton(
			new Scale9BitmapData(ResManager.getBitmapDataByName("20001_s9ButtonBg_out"), rect), 
			new Scale9BitmapData(ResManager.getBitmapDataByName("20001_s9ButtonBg_over"), rect), 
			new Scale9BitmapData(ResManager.getBitmapDataByName("20001_s9ButtonBg_down"), rect));
        addChild(imageBtn);

        sl = new SLLabel;
        sl.autoTextSzie=true;
        addChild(sl);
        
    }
    
}
}