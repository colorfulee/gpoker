package
{
import com.jzgame.enmu.ReleaseUtil;

import flash.display.LoaderInfo;
import flash.external.ExternalInterface;
import flash.system.Capabilities;

/**
 *
 *
 */
public class ExternalVars
{
    //==========================================================================
    //  Class variables
    //==========================================================================

    static private var loaderInfo:LoaderInfo;

    //==========================================================================
    //  Class Methods
    //==========================================================================
    static public function initialize(info:LoaderInfo):void
    {
        loaderInfo = info;
//        isDebug = CONFIG::debugging;
        var playerType:String = Capabilities.playerType;
        if ((playerType == "PlugIn" || playerType == "ActiveX" || playerType == "Desktop"))
        {
            var params:Object = info.parameters;
            if (params.hasOwnProperty("uid"))
            {
                userID = uint(params["uid"]);
            }
            if (params.hasOwnProperty("version"))
            {
                clientVersion = params["version"];
            }else
			{
//				var swfUrl:String = loaderInfo.url;
//				if(swfUrl.indexOf("?"))
//				{
//					clientVersion = String(swfUrl.substr(swfUrl.indexOf("?") + 1));
//				}
				
//				local = swfUrl;
//				local = local.split("\\").join("/");
//				var lastIndex:int = local.lastIndexOf("/");
//				local = local.slice(0, lastIndex);
			}
			
			if (params.hasOwnProperty("enable_flash_log"))
			{
				enable_flash_log = params["enable_flash_log"];
			}
			
			if (params.hasOwnProperty("social_id"))
			{
				socialId = params["social_id"];
			}
			
			if (params.hasOwnProperty("gateway"))
			{
				gateway = params["gateway"];
			}
			
			if (params.hasOwnProperty("cdnversion"))
			{
				cdnVersion = String(params["cdnversion"]);
				
				ReleaseUtil.versionPath = "version_"+params["cdnversion"]+".bin";
			}
			
			if (params.hasOwnProperty("token"))
			{
				token = params["token"];
			}
			
			if (params.hasOwnProperty("log_track_url"))
			{
				log_track_url = params["log_track_url"];
			}
			
			if (params.hasOwnProperty("log_track_seq_id"))
			{
				log_track_seq_id = Number(params["log_track_seq_id"]);
			}
			
			if (params.hasOwnProperty("log_track_session_id"))
			{
				log_track_session_id = String(params["log_track_session_id"]);
			}
			
			if (params.hasOwnProperty("platform"))
			{
				platform = params["platform"];
			}
			if (params.hasOwnProperty("language"))
			{
				language = params["language"];
			}
			
			if (params.hasOwnProperty("start_time"))
			{
				start_time = params["start_time"];
			}
			
			if (params.hasOwnProperty("static_json"))
			{
				configSource = params["static_json"];
			}else
			{
//				configSource = "https://g1.dev.jizeipoker.gamagic.com/json/static.json";
			}
        }
        else
        {
//			configSource = "https://g1.dev.jizeipoker.gamagic.com/json/static.json";
//            if (CONFIG::debugging)
//            {
//                checkToken = false;
//            }
        }

        if(href == null)
        {
            if(ExternalInterface.available)
            {
                href = ExternalInterface.call(
                    "function getHref(){return document.location.href;}");
            }
            else
            {
                href = "";
            }
        }

    }

    static public function getValue(name:String):String
    {
        return loaderInfo.parameters[name];
    }
	
	static public var enable_flash_log:String = "0";
	static public var log_track_url:String = "http://192.168.1.52/log/";
	static public var log_track_seq_id:Number = 17415498701;
	static public var log_track_session_id:String = "174154987000001004";
	static public var cdnVersion:String = "jzbbkk";
//	static public var socialId:String = "100001132252722";
	static public var socialId:String = "157166871107226";
//	static public var appID:String = "1017916871551726";
	//dev app id
	static public var appID:String = "448153988699629"; 
	/**
	 * 调用PHP API的地址
	 */	
	static public var gateway:String = "https://g1.dev.jizeipoker.gamagic.com/gateway.php";
	
	static public var token:String = "CAAGXlZCtNFe0BACCJZCRhYrH3MgwpuSSaWWjQvCZCwA4KEamRtZAaPLI94iNUrjWuUhiYCmoAYJYVfQLt5DoO44SeOd8piDMWysE7fObZAkLzxcOJscj3rGu1qWSXGHLKVoITLLiqxdD9mJLS9EaWb0ZBW3GvZCNJH9tJKHZC1XJocqbo4Dwhd3Ohw5JFXhoXPvY0SbK0MD5fAZDZD";
	static public var platform:String = "";
	//页面加载成功时间
	static public var start_time:String = "";
//	static public var language:String = "en_us";
//	static public var language:String = "th_th";
	static public var language:String = "zh_tw";
	//静态配置文件资源 json格式
	static public var configSource:String = "";

	static public function getJsonSource():String
	{
		if(configSource!="")return configSource;
		return "https://g1.dev.jizeipoker.gamagic.com/json/"+language+"/static.json";
	}
    /**
     * 指示是否检查登录，这里主要是开放时希望绕过登录验证.
     * 在发布版本中，记得这个必须为true.
     */
    static public var checkToken:Boolean = true;

    /**
     * 是否登录
     */
    static public var logged:Boolean = true;

    /**
     * 用户ID，默认值为测试用
     */
    
    static public var userID:uint = 1002;
    /**
     * 客户端编译版本
     */
    static public var clientVersion:String = "1.0.0.d";
	
    /**
     * 获取swf文件路径
     * @return
     *
     */
//    static public var local:String;

    /**
     * 当前打开页面地址.
     */
    static public var href:String;

    /**
     * 是否debug模式
     */
    static public var isDebug:Boolean = true;
}
}

