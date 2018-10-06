package com.wing.common.util;

import java.util.Properties;


public class PropertyUtil {
	public static int getInt(Properties pro, String key)throws Exception {
		if (pro == null) {
			throw new Exception("Properties == null");
		}
		String value = pro.getProperty(key);
		if (value == null) {
			throw new Exception(String.format("缺少属性%s", key));
		} else {
			return Integer.valueOf(value);
		}
	}

	public static boolean getBoolean(Properties pro, String key)throws Exception {
		if (pro == null) {
			throw new Exception("Properties == null");
		}
		String value = pro.getProperty(key);
		if (value == null) {
			throw new Exception(String.format("缺少属性%s", key));
		} else {
			return Boolean.valueOf(value);
		}
	}

	public static String getString(Properties pro, String key)throws Exception {
		if (pro == null) {
			throw new Exception("Properties == null");
		}
		String value = pro.getProperty(key);
		if (value == null) {
			throw new Exception(String.format("缺少属性%s", key));
		} else {
			return value;
		}
	}
}
