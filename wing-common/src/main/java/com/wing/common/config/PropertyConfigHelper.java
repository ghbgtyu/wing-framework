package com.wing.common.config;

import com.wing.common.config.abs.StaticAbsConfigHelper;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;

import java.io.File;

/**
 * Created by nijia on 2017/8/20.
 */
public class PropertyConfigHelper extends StaticAbsConfigHelper {

    private PropertiesConfiguration propertyConfig;

    @Override
    public String get(String key) throws Exception {
        return propertyConfig.getString(key);
    }

    @Override
    public void registerFile(File file)throws ConfigurationException {
        propertyConfig = new PropertiesConfiguration(file);
    }
}
