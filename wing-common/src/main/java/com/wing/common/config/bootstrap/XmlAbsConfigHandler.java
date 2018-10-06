package com.wing.common.config.bootstrap;

import com.wing.common.config.XmlConfigHelper;
import com.wing.common.config.abs.StaticAbsConfigHandler;

import java.io.File;

/**
 * Created by nijia on 2017/9/2.
 * xml格式配置文件处理类
 */
public abstract class XmlAbsConfigHandler<E> extends StaticAbsConfigHandler<E,XmlConfigHelper> {

    private XmlConfigHelper helper = new XmlConfigHelper();



    @Override
    protected XmlConfigHelper getHelper(File file)throws Exception {

        helper.registerSource(file);
        return helper;
    }

    @Override
    public String getType() {
        return "xml";
    }
}
