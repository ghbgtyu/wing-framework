package com.wing.common.config.bootstrap;

import com.wing.common.config.PropertyConfigHelper;
import com.wing.common.config.abs.StaticAbsConfigHandler;

import java.io.File;

/**
 * Created by nijia on 2017/9/2.
 * properties 格式配置文件处理类
 */
public abstract class PropertyAbsConfigHandler<T> extends StaticAbsConfigHandler<T,PropertyConfigHelper> {

    private PropertyConfigHelper helper = new PropertyConfigHelper();

    @Override
    protected PropertyConfigHelper getHelper(File file) throws Exception{

        helper.registerSource(file);
        return helper;
    }

    @Override
    public String getType() {
        return "properties";
    }
}
