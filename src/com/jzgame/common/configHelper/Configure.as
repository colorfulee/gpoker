package com.jzgame.common.configHelper
{
import com.jzgame.common.configHelper.vo.AchievementConfigModel;
import com.jzgame.common.configHelper.vo.ActivityConfig;
import com.jzgame.common.configHelper.vo.DailyBonusConfig;
import com.jzgame.common.configHelper.vo.ErrorCode;
import com.jzgame.common.configHelper.vo.FestervalDayConfig;
import com.jzgame.common.configHelper.vo.GiftConfig;
import com.jzgame.common.configHelper.vo.GuideConfigModel;
import com.jzgame.common.configHelper.vo.HunterConfig;
import com.jzgame.common.configHelper.vo.ItemConfig;
import com.jzgame.common.configHelper.vo.JackpotConfig;
import com.jzgame.common.configHelper.vo.LoginBonusConfig;
import com.jzgame.common.configHelper.vo.MTTConfig;
import com.jzgame.common.configHelper.vo.PackageItemConfig;
import com.jzgame.common.configHelper.vo.PlayerLevel;
import com.jzgame.common.configHelper.vo.SevenLoginBonusConfig;
import com.jzgame.common.configHelper.vo.SevenLoginTotalBonusConfig;
import com.jzgame.common.configHelper.vo.ShopGiftConfig;
import com.jzgame.common.configHelper.vo.ShopItemConfig;
import com.jzgame.common.configHelper.vo.ShopVipConfig;
import com.jzgame.common.configHelper.vo.SpeMTTConfig;
import com.jzgame.common.configHelper.vo.TableConfig;
import com.jzgame.common.configHelper.vo.TaskConfig;
import com.jzgame.common.configHelper.vo.VipConfig;

/**
 * 用于保存配置文件内容
 * @author Rakuten
 *
 */
public class Configure
{
    //==========================================================================
    //  Class variables
    //==========================================================================
	//这里的绑定的名字需与config.xml中绑定的名字一致
    static private const TYPE_GAME_CONFIG:String = "config";
    static private const TYPE_TASK_CONFIG:String = "task";
    static public const TYPE_TABLE_CONFIG:String = "table_config";
    static public const TYPE_GUIDE_CONFIG:String = "guide_config";
    static private const TYPE_ITEM_CONFIG:String = "item";
    static private const TYPE_GIFT_CONFIG:String = "gift";
    static private const TYPE_VIP_CONFIG:String = "vip";
	static private const TYPE_ACHIEVEMENT_CONFIG:String = "achievement";
	static private const TYPE_ERROR_CODE:String = "error";
	static private const TYPE_SHOP_ITEM:String = "shop_item";
	static private const TYPE_SHOP_GIFT:String = "shop_gift";
	static private const TYPE_SHOP_VIP:String = "shop_vip";
	static private const TYPE_DAILY_BONUS:String = "daily_bonus";
	//每日登录
	static private const TYPE_LOGIN_BONUS:String = "login_bonus";
	static private const TYPE_PLAYER_LEVEL:String = "player_level";
	static private const TYPE_BACK_GROUND:String = "back_groud";
	static private const TYPE_RECOMMEND:String = "recommend";
	static private const TYPE_MTT:String = "mtt";
	static private const SEVEN_LOGIN:String = "login_daybonus";
	static private const SEVEN_LOGIN_TB:String = "login_totalbonus";
	static private const TYPE_PACK_ITEM:String = "package";
	
	static private const TYPE_JACKPOT_CONFIG:String = "jackpot";
	static private const TYPE_ACTIVITY_CONFIG:String = "activity";
	static private const TYPE_ACTIVITY_FESTERVAL_CONFIG:String = "holiday_task";
	static private const TYPE_ACTIVITY_HUNTER_CONFIG:String = "bounty_hunter";
	static private const TYPE_SPE_MTT_CONFIG:String = "special_mtt";
	
//	shop_gift
//	gift
//	payment
//	player_level
//	lucky_wheel
//	package

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 构造一个<code>ConnectionManager</code>实例.
     *
     */
    public function Configure()
    {
		
    }
	
	init();
	/**
	 * 供静态初始化调用 
	 */	
	static private function init():void
	{
//		addConfig(TYPE_GAME_CONFIG, new ConfigModel());
		addConfig(TYPE_TASK_CONFIG, new TaskConfig());
		addConfig(TYPE_TABLE_CONFIG, new TableConfig());
		addConfig(TYPE_GUIDE_CONFIG, new GuideConfigModel());
		addConfig(TYPE_ITEM_CONFIG, new ItemConfig());
		addConfig(TYPE_GIFT_CONFIG, new GiftConfig());
		addConfig(TYPE_VIP_CONFIG, new VipConfig());
		addConfig(TYPE_ACHIEVEMENT_CONFIG, new AchievementConfigModel());
		addConfig(TYPE_ERROR_CODE, new ErrorCode());
		addConfig(TYPE_SHOP_ITEM, new ShopItemConfig());
		addConfig(TYPE_SHOP_GIFT, new ShopGiftConfig());
		addConfig(TYPE_SHOP_VIP, new ShopVipConfig());
		addConfig(TYPE_DAILY_BONUS, new DailyBonusConfig());
		addConfig(TYPE_LOGIN_BONUS, new LoginBonusConfig());
		addConfig(TYPE_PLAYER_LEVEL, new PlayerLevel());
		addConfig(TYPE_RECOMMEND, new PlayerLevel());
		addConfig(TYPE_MTT, new MTTConfig());
		addConfig(SEVEN_LOGIN, new SevenLoginBonusConfig());
		addConfig(SEVEN_LOGIN_TB, new SevenLoginTotalBonusConfig());
		addConfig(TYPE_PACK_ITEM, new PackageItemConfig());
		addConfig(TYPE_JACKPOT_CONFIG, new JackpotConfig());
		addConfig(TYPE_ACTIVITY_CONFIG, new ActivityConfig());
		addConfig(TYPE_ACTIVITY_FESTERVAL_CONFIG, new FestervalDayConfig());
		addConfig(TYPE_ACTIVITY_HUNTER_CONFIG, new HunterConfig());
		addConfig(TYPE_SPE_MTT_CONFIG, new SpeMTTConfig());
		
	}
    //==========================================================================
    //  Variables
    //==========================================================================
	
	static private var configDic:Object = {};
	
	/**
	 * 添加配置
	 * (暂时不提供外部调用) 
	 * @param configName
	 * @param target
	 */	
	static internal function addConfig(configName:String, target:IConfigHelper):void
	{
		configDic[configName] = target;
	}
	
	static public function getConfig(value:String):IConfigHelper
	{
		return configDic[value];
	}
	/**
	 * 获取spemtt配置 
	 * @return 
	 * 
	 */	
	static public function get speMttConfig():SpeMTTConfig
	{
		return configDic[TYPE_SPE_MTT_CONFIG];
	}
	/**
	 * 获取礼包配置 
	 * @return 
	 * 
	 */	
	static public function get packItemConfig():PackageItemConfig
	{
		return configDic[TYPE_PACK_ITEM];
	}
	/**
	 * activity 
	 * @return 
	 * 
	 */
	static public function get activityConfig():ActivityConfig
    {
        return configDic[TYPE_ACTIVITY_CONFIG];
    }
	/**
	 * activity 
	 * @return 
	 * 
	 */
	static public function get activityFestervalConfig():FestervalDayConfig
    {
        return configDic[TYPE_ACTIVITY_FESTERVAL_CONFIG];
    }
	/**
	 * activity 
	 * @return 
	 * 
	 */
	static public function get activityHunterConfig():HunterConfig
    {
        return configDic[TYPE_ACTIVITY_HUNTER_CONFIG];
    }
	/**
	 * mtt 
	 * @return 
	 * 
	 */
	static public function get mttConfig():MTTConfig
    {
        return configDic[TYPE_MTT];
    }
	static public function get sevenLoginBonus():SevenLoginBonusConfig
    {
        return configDic[SEVEN_LOGIN];
    }
	static public function get sevenLoginTotalBonus():SevenLoginTotalBonusConfig
    {
        return configDic[SEVEN_LOGIN_TB];
    }
	/**
	 * 获取玩家称号 
	 * @return 
	 * 
	 */	
	static public function get playerLevel():PlayerLevel
    {
        return configDic[TYPE_PLAYER_LEVEL];
    }
	/**
	 * 获取筹码限制
	 * @return 
	 * 
	 */	
	static public function get recommend():PlayerLevel
    {
        return configDic[TYPE_RECOMMEND];
    }
//	/**
//	 * 获取桌子背景
//	 * @return 
//	 * 
//	 */	
//	static public function get background():BackGroundConfig
//    {
//        return configDic[TYPE_BACK_GROUND];
//    }

	/**
	 * 任务 
	 * @return 
	 * 
	 */	
	static public function get taskConfig():TaskConfig
    {
        return configDic[TYPE_TASK_CONFIG];
    }

	static public function get tableConfig():TableConfig
    {
        return configDic[TYPE_TABLE_CONFIG];
    }

	static public function get guideConfig():GuideConfigModel
    {
        return configDic[TYPE_GUIDE_CONFIG];
    }

	static public function get itemConfig():ItemConfig
    {
        return configDic[TYPE_ITEM_CONFIG];
    }
	
	static public function get vipConfig():VipConfig
    {
        return configDic[TYPE_VIP_CONFIG];
    }
	
	static public function get giftConfig():GiftConfig
    {
        return configDic[TYPE_GIFT_CONFIG];
    }
	
	static public function get shopItemConfig():ShopItemConfig
    {
        return configDic[TYPE_SHOP_ITEM];
    }
	
	static public function get shopGiftConfig():ShopGiftConfig
    {
        return configDic[TYPE_SHOP_GIFT];
    }
	
	static public function get shopVipConfig():ShopVipConfig
    {
        return configDic[TYPE_SHOP_VIP];
    }
	
	static public function get jackpotConfig():JackpotConfig
	{
		return configDic[TYPE_JACKPOT_CONFIG];
	}
	
	/**
	 * 获取登录配置 
	 * @return 
	 * 
	 */	
	static public function get loginBonusConfig():LoginBonusConfig
    {
        return configDic[TYPE_LOGIN_BONUS];
    }
	
	/**
	 * 成就 
	 * @return 
	 * 
	 */	
	static public function get achievementConfig():AchievementConfigModel
	{
		return configDic[TYPE_ACHIEVEMENT_CONFIG];
	}
	
	/**
	 * 错误码 
	 * @return 
	 * 
	 */	
	static public function get errorCode():ErrorCode
	{
		return configDic[TYPE_ERROR_CODE];
	}
	
	static public function get shopItem():ShopGiftConfig
	{
		return configDic[TYPE_SHOP_ITEM];
	}
	/**
	 * 获取日常任务 
	 * @return 
	 * 
	 */	
	static public function get dailyBonus():DailyBonusConfig
	{
		return configDic[TYPE_DAILY_BONUS];
	}
	/**
	 * 根据id获得物品的类型 
	 * @param id
	 * @return 
	 * 
	 */	
	static public function getItemType(id:String):uint
	{
		return uint(id.substr(0,1));
	}
	/**
	 * 获取商店物品类型 
	 * @param id
	 * @return 
	 * 
	 */	
	static public function getShopItemType(id:String):uint
	{
		return uint(id.substr(0,3));
	}
	
	public static var BASE:uint = 1;
	public static var ITEM:uint = 4;
	public static var GIFT:uint = 3;
	public static var VIP:uint = 7;
	//礼包物品
	public static var PACK:uint = 5;
	public static var SHOP_GIFT:uint = 803;
	
}
}
