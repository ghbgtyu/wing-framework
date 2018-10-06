package com.wing.proxy.external.config;

import com.wing.common.config.XmlConfigHelper;
import com.wing.common.config.bootstrap.XmlAbsConfigHandler;
import com.wing.proxy.application.config.ProxyConfig;

/**
 * Created by nijia on 2017/9/5.
 */
public class ProxyServerConfigHandler extends XmlAbsConfigHandler<ProxyConfig>{




    @Override
    protected ProxyConfig parseConfig(XmlConfigHelper helper) throws Exception{
        ProxyConfig busConfig = new ProxyConfig();
        busConfig.setId(Integer.valueOf(helper.get("server.id")));

        return busConfig;
    }



    @Override
    public String getFileName() {
        return "proxy";
    }
}
