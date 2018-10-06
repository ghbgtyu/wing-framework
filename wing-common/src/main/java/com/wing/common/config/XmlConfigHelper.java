package com.wing.common.config;

import com.wing.common.config.abs.StaticAbsConfigHelper;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.XMLConfiguration;

import java.io.File;

/**
 * Created by nijia on 2017/8/20.
 * xml解析器
 */
public class XmlConfigHelper extends StaticAbsConfigHelper {

    private XMLConfiguration config;

    @Override
    public String get(String key) throws ConfigurationException {

        return config.getString(key);
    }

    @Override
    public void registerFile(File file) throws Exception {
        config = new XMLConfiguration(file);
    }
}
