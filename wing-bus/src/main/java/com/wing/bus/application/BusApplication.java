package com.wing.bus.application;

import com.wing.bus.application.config.BusConfigManager;

import com.wing.common.context.AbsApplication;
import com.wing.server.common.vo.BusServer;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

/**
 * Created by nijia on 2017/12/7.
 * bus 模块 上下文
 */
public class BusApplication extends AbsApplication {

    /**配置文件管理器*/
    private BusConfigManager busConfigManager = new BusConfigManager();

    /**spring 上下文信息*/
    private ApplicationContext applicationContext;


    private BusServer busServer ;



    public void init() throws Exception{

        //加载spring
        ApplicationContext applicationContext = new FileSystemXmlApplicationContext(new String[] { "classpath:spring-config.xml" });
        this.applicationContext = applicationContext;

        busConfigManager.init();

        busServer = new BusServer(busConfigManager.getBusConfig().getId());

    }

    public BusServer getBusServer() {
        return busServer;
    }

    public BusConfigManager getBusConfigManager() {
        return busConfigManager;
    }


    public ApplicationContext getApplicationContext() {
        return applicationContext;
    }
}
