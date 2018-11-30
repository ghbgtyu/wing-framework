/**
 * Copyright &copy; 2014-2015 <a href="https://github.com/mokylin/cabal">cabal</a> All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.mokylin.cabal.common.config;

import com.google.common.collect.Maps;
import com.mokylin.cabal.common.utils.PropertiesLoader;

import org.apache.commons.collections.MapUtils;
import org.springframework.util.Assert;

import java.util.Map;

/**
 * 全局配置类
 * @author 稻草鸟人
 * @version 2014-03-23
 */
public class Global {
	
	/**
	 * 保存全局属性值
	 */
	private static Map<String, String> map = Maps.newHashMap();
	
	/**
	 * 属性文件加载对象
	 */
	public static PropertiesLoader propertiesLoader = new PropertiesLoader("properties/application.properties");

	public static PropertiesLoader configFileLoader = new PropertiesLoader("properties/config-file.properties");

	public static PropertiesLoader commonLoader = new PropertiesLoader("properties/commons.properties");
	
	/**
	 * 获取配置
	 */
	public static String getConfig(String key) {
		String value = map.get(key);
		if (value == null){
			value = propertiesLoader.getProperty(key);
			map.put(key, value);
		}
		return value;
	}

	/////////////////////////////////////////////////////////
	
	/**
	 * 获取管理端根路径
	 */
	public static String getAdminPath() {
		return getConfig("adminPath");
	}
	
	/**
	 * 获取前端根路径
	 */
	public static String getFrontPath() {
		return getConfig("frontPath");
	}
	
	/**
	 * 获取URL后缀
	 */
	public static String getUrlSuffix() {
		return getConfig("urlSuffix");
	}
	
	/**
	 * 是否是演示模式，演示模式下不能修改用户、角色、密码、菜单、授权
	 */
	public static Boolean isDemoMode() {
		String dm = getConfig("demoMode");
		return "true".equals(dm) || "1".equals(dm);
	}

	/**
	 * 获取CKFinder上传文件的根目录
	 * @return
	 */
	public static String getCkBaseDir() {
		String dir = getConfig("userfiles.basedir");
		Assert.hasText(dir, "配置文件里没有配置userfiles.basedir属性");
		if(!dir.endsWith("/")) {
			dir += "/";
		}
		return dir;
	}


    public static Map<String, Object> getConfigFileMap() {
        return PropertiesLoader.getMap(configFileLoader.getProperties());
    }

    public static Map<String, Object> getCommonMap() {
        return PropertiesLoader.getMap(commonLoader.getProperties());
    }
    
    //用于配置页面显示配置文件类型
    public static String getCommon(String key){
    	return MapUtils.getString(getConfigFileMap(), key);
    }
}
