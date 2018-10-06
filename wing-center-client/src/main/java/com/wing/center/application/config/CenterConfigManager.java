package com.wing.center.application.config;

import com.wing.center.external.config.CenterConfigHandler;
import com.wing.common.config.container.FileConfigContainer;
import com.wing.common.config.interfaces.IStaticConfigHandler;

/**
 * Created by nijia on 2018/4/3.
 */
public class CenterConfigManager {

    private CenterConfig centerConfig;


    public void init()throws Exception{
        //加载配置文件
        FileConfigContainer config = new FileConfigContainer("");



        IStaticConfigHandler centerConfigHandler = new CenterConfigHandler();
        config.registerHandler(centerConfigHandler);


        config.parseStart();



        CenterConfig centerConfig = config.get(CenterConfig.class);


        this.centerConfig = centerConfig;
    }


    public CenterConfig getCenterConfig() {
        return centerConfig;
    }


}
