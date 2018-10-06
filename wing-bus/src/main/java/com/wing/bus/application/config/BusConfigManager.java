package com.wing.bus.application.config;

import com.wing.bus.external.config.BusServerConfigHandler;
import com.wing.common.config.container.FileConfigContainer;
import com.wing.common.config.interfaces.IStaticConfigHandler;

/**
 * Created by nijia on 2017/12/10.
 */
public class BusConfigManager {

    /**服务器配置*/
    private BusConfig busConfig;
    //private CenterConfig centerConfig;


    public void init() throws Exception{
        //加载配置文件
        FileConfigContainer config = new FileConfigContainer("");

        IStaticConfigHandler busServerConfigHandler = new BusServerConfigHandler();
        config.registerHandler(busServerConfigHandler);




        config.parseStart();


        BusConfig busConfig = config.get(BusConfig.class);


        this.busConfig = busConfig;

    }

    /**获取服务器配置*/
    public BusConfig getBusConfig() {
        return busConfig;
    }



}
