package com.jzgame.common.services.http.events
{
import com.jzgame.common.services.http.HttpRequest;
import com.jzgame.common.services.http.IHttpResponse;

import flash.events.Event;

/**
 *
 * @author Rakuten
 *
 */
public class HttpResponseEvent extends Event
{
	static public const HTTP_RESPONSE_ERROR_CODE:String = "httpResponseErrorCode";
	
	/**
	 * 调试专用(不要删)
	 */	
	static public const HTTP_RESPONSE_RECEIVE:String = "httpResponseReceive";
//	static public const HTTP_RESPONSE_SECRITY_ERROR:String = "httpResponseSecurityError";
//	static public const HTTP_RESPONSE_IO_ERROR:String = "httpResponseIoError";
//	static public const HTTP_RESPONSE_DECODE_ERROR:String = "httpResponseDecodeError";
//	static public const HTTP_RESPONSE_PARSE_ERROR:String = "httpResponseParseError";
	
    public function HttpResponseEvent(type:String, requestVO:HttpRequest, vo:IHttpResponse)
    {
        super(type);

        request=requestVO;
        _data=vo;
        _result=_data["r"];
    }
	
    public var request:HttpRequest;

    private var _data:IHttpResponse;

    /**
     * 包含成功返回的数据和出错信息
     * @return
     *
     */
    public function get data():IHttpResponse
    {
        return _data;
    }

    private var _result:Object;

    /**
     * 仅包含成功返回的有效数据
     * @return
     *
     */
    public function get result():Object
    {
        return _result;
    }

    override public function clone():Event
    {
        return new HttpResponseEvent(this.type, this.request, this._data);
    }
}
}