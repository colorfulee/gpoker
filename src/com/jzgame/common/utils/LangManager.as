package com.jzgame.common.utils
{
import com.jzgame.common.vo.LanguageVO;

import flash.utils.Dictionary;

public class LangManager
{

    static private var _dic:Dictionary = new Dictionary;
    static private var _dicXML:Dictionary = new Dictionary;

	private static var th_th:uint = 1;
	private static var zh_tw:uint = 2;
	private static var en_us:uint = 0;
	
    public function LangManager()
    {
    }

    /**
     *
     * @param xml
     *
     */
    static public function setData(xml:XML):void
    {
        var cvo:LanguageVO;
        for (var j:String in xml.item)
        {
            cvo=new LanguageVO;
            cvo.id=xml.item[j].@id;
			
			cvo.texts.push(String(XMLList(xml.item[j]).children()[0]));
			cvo.texts.push(String(XMLList(xml.item[j]).children()[1]));
			cvo.texts.push(String(XMLList(xml.item[j]).children()[2]));
//            cvo.text=xml.item[j];
            _dic[cvo.id]=cvo;
        }
    }

    /**
     * 设置release配置
     * @param value
     *
     */
    static public function setDataVO(value:Object):void
    {
		setJsonVO(value);
    }
	
	static public function setJsonVO(value:Object):void
	{
		var cvo:LanguageVO;
		for (var id:String in value)
		{
			cvo = new LanguageVO;
			cvo.id = id;
			cvo.texts.push(String(XMLList(value[id]).children()[0]));
			cvo.texts.push(String(XMLList(value[id]).children()[1]));
			cvo.texts.push(String(XMLList(value[id]).children()[2]));
//			cvo.text = value[id];
			_dic[cvo.id]=cvo;
		}
	}
	/**
	 * 是否存在 
	 * @param id
	 * @return 
	 * 
	 */	
	static public function hasText(id:String):Boolean
	{
		if(!_dic.hasOwnProperty(id)) return false;
		return true;
	}

    /**
     *
     * @param id
     * @return
     *
     */
    static public function getText(id:String, ...arg):String
    {
		if(!_dic.hasOwnProperty(id))return "no text found in language by " + id;
        return substitute(_dic[id].texts[LangManager[ExternalVars.language]], arg);
    }
	
	public static function substitute(input:String, ...rest):String
	{
		// Replace all of the parameters in the msg string.
		var len:uint = rest.length;
		var args:Array;
		if (len == 1 && rest[0] is Array)
		{
			args = rest[0] as Array;
			len = args.length;
		}
		else
		{
			args = rest;
		}
		
		for (var i:int = 0; i < len; i++)
		{
			input = input.replace(new RegExp("\\{" + i + "\\}", "g"), args[i]);
		}
		return input.split("\\n").join("\n");
	}
}
}
