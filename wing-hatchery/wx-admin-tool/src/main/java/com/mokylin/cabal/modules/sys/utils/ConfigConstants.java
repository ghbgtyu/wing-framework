package com.mokylin.cabal.modules.sys.utils;

import com.mokylin.cabal.common.config.Global;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/23 17:03
 * 项目: cabal-tools
 * <p>
 * 全局常量
 */
public class ConfigConstants {

    public static final String SELECTED_SERVER_KEY = "curServerId";


    //操作类型

    public static final String OPERATION_TYPE_SILENCE = "0";    //禁言

    public static final String OPERATION_TYPE_FREEZE = "1";     //封号

    public static final String OPERATION_TYPE_CANCEL_SILENCE = "3"; //取消禁言

    public static final String OPERATION_TYPE_CANCEL_FREEZE = "4";  //取消封号


    public static final String REDIS_HOST = Global.propertiesLoader.getProperty("global.redis.host"); //

    public static final Integer REDIS_PORT = Global.propertiesLoader.getInteger("global.redis.port");

    public static final Integer CHAT_REDIS_INDEX = Global.propertiesLoader.getInteger("chat.redis.index");

    public static final Integer GAME_REDIS_INDEX = Global.propertiesLoader.getInteger("game.redis.index");

    public static final Integer CROSS_AREA_REDIS_INDEX = Global.propertiesLoader.getInteger("crossArea.redis.index");
}
