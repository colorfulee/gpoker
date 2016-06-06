package com.jzgame.common.utils
{
import com.jzgame.common.utils.style.IStyle;


public class Style
{
    /*auther     :jim
    * file       :Style.as
    * date       :Dec 9, 2014
    * description:
    */
    private static var _instance:IStyle;

    public function Style()
    {
    }

    public static function init(vo:IStyle):void
    {
        _instance=vo;
    }

    public static function getInstance():IStyle
    {
        if (!_instance)
        {
            throw Error("Style need init an instance frist")
        }
        return _instance;
    }

}
}