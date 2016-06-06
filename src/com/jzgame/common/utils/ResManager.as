package com.jzgame.common.utils
{
import com.jzgame.common.vo.ConfigVO;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.events.Event;
import flash.media.Sound;
import flash.system.LoaderContext;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import starling.textures.Texture;
import starling.textures.TextureAtlas;

/**
 * 
 * @author Rakuten
 * 
 */
public class ResManager
{
	public static var OPERATE:String = "_";
	public static var defaultAssets				:TextureAtlas;
	public static var tableAssets				:TextureAtlas;
    public function ResManager()
    {
    }
	
	static public var isReleaseVer:Boolean;

	static private var _loaderInfo:Object = {};
	static private var _swf:Dictionary = new Dictionary;
	static private var _texture:Dictionary = new Dictionary;
	static private var _xml:Dictionary = new Dictionary;
	static private var _bitmap:Dictionary = new Dictionary;
	static public var font:Dictionary = new Dictionary;
	static private var resourceDict:Dictionary;

	static public function init(obj:Dictionary):void
	{
		resourceDict = obj;
	}
    /**
     *
     * @param url 路径
     * @param loaderInfo
     *
     */
	static public function addLoaderInfo(url:String, loaderInfo:LoaderInfo):void
    {
        //			trace('addLoaderInfo:',url,loaderInfo);
        _loaderInfo[url]=loaderInfo;
    }
	/**
	 * 增加纹理 
	 * @param id
	 * @param texture
	 * 
	 */	
	static public function addTexture(id:String, texture:Texture):void
	{
		_texture[id] = texture;
	}
	/**
	 * 查找纹理 
	 * @param id
	 * 
	 */	
	static public function getTexture(id:String):Texture
	{
		return _texture[id];
	}
	
	/**
	 * 增加图片
	 * @param id
	 * @param texture
	 * 
	 */	
	static public function addBitmap(id:String, texture:Bitmap):void
	{
		_bitmap[id] = texture;
	}
	/**
	 * 查找图片
	 * @param id
	 * 
	 */	
	static public function getBitmap(id:String):Bitmap
	{
		return _bitmap[id];
	}
	
	static public function addXML(id:String, xml:XML):void
	{
		_xml[id] = xml;
	}
	
	static public function getXML(id:String):XML
	{
		return _xml[id];
	}
	/**
	 * 开始初始化合集 
	 * 
	 */	
	static public function start():void
	{
		defaultAssets = new TextureAtlas(getTexture("defaultAssets"),getXML("defaultAssetsXML"));
		//init text font
//		var font:BitmapFont = new BitmapFont(Texture.fromBitmap(getBitmap("wizztaB")), getXML("wizztaXML"));
//		TextField.registerBitmapFont(font);
		
		tableAssets = new TextureAtlas(getTexture("tableSheet"),getXML("tableSheetXML"));
	}

    /**
     *
     * @param url
     * @return
     *
     */
	static public function hasLoaderInfo(url:String):Boolean
    {
        if (_loaderInfo[url])
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    /**
     *
     * @param url
     * @return
     *
     */
	static public function getLoaderInfoByPath(url:String):LoaderInfo
    {
        return _loaderInfo[url];
    }

    /**
     * 为库对象添加索引
     * @param id
     * @param loaderInfo
     *
     */
	static public function addSWF(id:String, loaderInfo:LoaderInfo):void
    {
        _swf[id]=loaderInfo;
    }

    /**
     * 获取类从对应的加载实例中
     * @param id
     * @param infoId
     * @return
     *
     */
	static public function getClassByName(id:String, infoId:String=null):Class
    {
        if (!infoId)
        {
            infoId=id;
        }
        var loaderInfo:LoaderInfo = _swf[infoId];
        var c:Class = loaderInfo.applicationDomain.getDefinition(id) as Class;
        return c;
    }

    /**
     * 根据索引判断是否存在类对象
     * @param id
     * @return
     *
     */
	static public function hasClass(id:String):Boolean
    {
        var loaderInfo:LoaderInfo = _swf[id];
        if (!loaderInfo)
            return false;

        return loaderInfo.applicationDomain.hasDefinition(id);
    }

    /**
     *
     * @param id 需要的类索引
     * @param infoPath 指向loadInfo路径
     *
     */
	static public function getBitmapDataInLoaderInfoByName(id:String, infoPath:String):BitmapData
    {
		//如果素材存在缓存中
        if (hasLoaderInfo((infoPath)))
        {
            var loaderInfo:LoaderInfo = getLoaderInfoByPath((infoPath));
            //				trace('getBitmapDataInLoaderInfoByName:',id,loaderInfo);
            var mc:Class = loaderInfo.applicationDomain.getDefinition(id) as Class;
            return new mc();
        }else
		{
		}

        return null
    }

    /**
     * 根据名字获取图片
     * @param id
     * @return
     *
     */
	static public function getBitmapDataByName(id:String):BitmapData
    {
        var list:Array = id.split(OPERATE);
        return getBitmapDataInLoaderInfoByName(id, (AssetsCenter.findPathById(list[0])));
    }

    /**
     *
     * @param id 需要的类索引
     * @param infoPath 指向loadInfo路径
     *
     */
	static public function getMCInLoaderInfoByName(id:String, infoPath:String):MovieClip
    {
        if (hasLoaderInfo((infoPath)))
        {
            var loaderInfo:LoaderInfo = getLoaderInfoByPath((infoPath));
            //				trace('getMCInLoaderInfoByName:',id,loaderInfo);
            var mc:Class = loaderInfo.applicationDomain.getDefinition(id) as Class;
            var item:MovieClip = new mc();
            item.gotoAndStop(1);
            return item;
        }

        return null;
    }

    /**
     * 根据索引获取类实例(包含文件名字)
     * @param id
     * @return
     *
     */
	static public function getMCByName(id:String):MovieClip
    {
        var asset:ConfigVO = resourceDict[id];
        //			如果存在配置文件中
        if (asset)
        {
            var path:String = asset.link;

            return getMCInLoaderInfoByName(id, (path));
        }
        else
        {
            var list:Array = id.split(OPERATE);
            return getMCInLoaderInfoByName(id, (AssetsCenter.findPathById(list[0])));
        }
	}
    /**
     * 根据索引获取类实例
     * @param id
     * @return
     *
     */
	public static function getMCByOraignName(id:String):MovieClip
    {
        var asset:ConfigVO = resourceDict[id];
        //			如果存在配置文件中
        if (asset)
        {
            var path:String = asset.link;

            return getMCInLoaderInfoByName(id, (path));
        }
        else
        {
            var mc:Class = getClassByName(id);
            var item:MovieClip = new mc();
            item.gotoAndStop(1);
            return item;

        }
    }

//    /**
//     *
//     * @param id
//     * @return
//     *
//     */
//	static public function findPathById(id:String):String
//    {
//        var fl:String = id;
//        if (fl.length < 6)
//        {
//            fl="0" + fl;
//        }
//
//        var folder:String = fl.substr(0, 2);
//        return "assets/" + folder + "/" + id + ".swf";
//    }

    /**
     *
     * @param exportClass
     * @param path
     * @return
     *
     */
	static public function getMovieClipInLoaderInfoByName(exportClass:String, path:String):MovieClip
    {
        var loadInfo:LoaderInfo = null;
        var ins:Class = null;
        if (hasLoaderInfo(path))
        {
            loadInfo = getLoaderInfoByPath(path);
            ins=loadInfo.applicationDomain.getDefinition(exportClass) as Class;
            var item:MovieClip = new ins();
            return item;
        }
        return null;
    } // end function

    /**
     * 在指定的加载类实例中获取指定索引
     * @param id
     * @param infoId
     * @return
     *
     */
	static public function getMCByNameInSource(id:String, infoId:String):MovieClip
    {
        var mc:Class = getClassByName(id, infoId);
        var item:MovieClip = new mc();
        return item;
    }

    /**
     * 根据索引获取声音实例
     * @param id
     * @return
     *
     */
	static public function getSoundById(id:String):Sound
    {
        var sound:Class = getClassByName(id);
        return new sound();
    }

    /**
     * 根据路径动态加载
     * @param id
     * @param feedBack 回调
     * @param showLoading 是否显示loading
     * @param path 路径
     *
     */
	static public function getSysMCByName(id:String, feedBack:Function, showLoading:Boolean=true, path:String=null):void
    {
        if (!path)
        {
            var asset:ConfigVO = resourceDict[id];
            path=asset.link;
        }
        //			Debug.log('getSysMCByName:'+id+',,'+path);
        //			trace('getSysMCByName:',id,path);

        //			如果已经加载成功过
        if (hasClass(id) && getLoaderInfoByPath(path))
        {
            if (feedBack.length == 0)
            {
                (feedBack).apply();
            }
            else
            {
                (feedBack).apply(null, [getMCByName(id)]);
            }
        }
        else
        {
//            var fileLoader:FileRetryLoader = new FileRetryLoader();
//            if (isReleaseVer)
//            {
//                fileLoader.retryLoad(new FileRetryLoaderVO(FileType.BIN, AssetsCenter.getReleasePath(path), null, {'id': id, 'path': path, 'feedBack': feedBack, 'showLoading': showLoading}));
//            }
//            else
//            {
//                fileLoader.retryLoad(new FileRetryLoaderVO(FileType.SWF, AssetsCenter.getFullPath(path), null, {'id': id, 'path': path, 'feedBack': feedBack, 'showLoading': showLoading}));
//            }
//            fileLoader.addEventListener(Event.COMPLETE, sysHandler);

//            if (showLoading)
//                eventDispatcher.dispatchEvent(new Event(WindowType.ASSET_LOADING));
        }
    }

    /**
     * 转换二进制
     * @param bytes
     * @param link
     *
     */
	static private function converByteToMC(bytes:ByteArray, param:Object):void
    {
        AssetsCenter.transformBinTOMC(bytes);

        var id:String = param.id;
        //			var feedBack:Function = param.feedBack;
        var loader:Loader = new Loader;
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
        var lc:LoaderContext = new LoaderContext();
        lc.allowCodeImport=true;
        loader.loadBytes(bytes, lc);

        function loaded(e:Event):void
        {
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaded);
            addLoaderInfo((param.path), loader.contentLoaderInfo);
            //				ad/dSWF(param.@id,loader.contentLoaderInfo);
            sysFinish(param);
        }
    }

//    /**
//     * 动态加载成功回调方法
//     * @param e
//     *
//     */
//	static private function sysHandler(e:Event):void
//    {
//        var fileLoader:FileRetryLoader = e.currentTarget as FileRetryLoader;
//        fileLoader.removeEventListener(Event.COMPLETE, sysHandler);
//        if (isReleaseVer)
//        {
//            converByteToMC(fileLoader.data as ByteArray, fileLoader.params);
//        }
//        else
//        {
//            addSWF(fileLoader.params.id, fileLoader.loaderInfo);
//            addLoaderInfo((fileLoader.params.path), fileLoader.loaderInfo);
//            sysFinish(fileLoader.params);
//        }
//    }

	static private function sysFinish(params:Object):void
    {
        if (params.feedBack.length == 0)
        {
            (params.feedBack).apply();
        }
        else
        {
            (params.feedBack).apply(null, [getMCByName(params.asset.@id)]);
        }

        //			if(params.showLoading)eventDispatcher.dispatchEvent(new Event(WindowType.ASSET_LOADING,EventType.HIDE_WINDOW));
    }
}
}
