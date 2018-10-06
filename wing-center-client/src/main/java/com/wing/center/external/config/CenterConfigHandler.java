package com.wing.center.external.config;

import com.wing.center.application.config.CenterConfig;
import com.wing.common.config.XmlConfigHelper;
import com.wing.common.config.bootstrap.XmlAbsConfigHandler;

/**
 * Created by nijia on 2017/9/5.
 */
public class CenterConfigHandler extends XmlAbsConfigHandler<CenterConfig>{




    @Override
    protected CenterConfig parseConfig(XmlConfigHelper helper) throws Exception{
        CenterConfig centerConfig = new CenterConfig();
        centerConfig.setPort(Integer.valueOf(helper.get("center.port")));
        centerConfig.setIp(helper.get("center.ip"));
        centerConfig.setIndex(Integer.valueOf(helper.get("center.index")));

        return centerConfig;
    }



    @Override
    public String getFileName() {
        return "center";
    }
}
