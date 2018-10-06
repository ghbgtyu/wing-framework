package com.wing.center.application;

import com.wing.center.application.config.CenterConfigManager;
import com.wing.center.register.client.IServerCenterClient;
import com.wing.common.context.AbsApplication;
import com.wing.server.common.vo.AbsServer;

/**
 * Created by nijia on 2018/4/3.
 */
public class CenterApplication extends AbsApplication {


    private CenterConfigManager centerConfigManager = new CenterConfigManager();

    private IServerCenterClient<AbsServer>serverClient;

    public void init() throws Exception{
        centerConfigManager.init();
    }


    public CenterConfigManager getCenterConfigManager() {
        return centerConfigManager;
    }
}
