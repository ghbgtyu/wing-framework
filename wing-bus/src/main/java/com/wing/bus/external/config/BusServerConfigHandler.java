package com.wing.bus.external.config;

import com.wing.bus.application.config.BusConfig;
import com.wing.common.config.XmlConfigHelper;
import com.wing.common.config.bootstrap.XmlAbsConfigHandler;

/**
 * Created by nijia on 2017/9/5.
 */
public class BusServerConfigHandler extends XmlAbsConfigHandler<BusConfig>{




    @Override
    protected BusConfig parseConfig(XmlConfigHelper helper) throws Exception{
        BusConfig busConfig = new BusConfig();
        busConfig.setId(Integer.valueOf(helper.get("server.id")));

        return busConfig;
    }



    @Override
    public String getFileName() {
        return "bus";
    }
}
