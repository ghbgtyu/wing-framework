package com.wing.proxy.application;

import com.wing.common.context.AbsApplication;
import com.wing.proxy.application.config.ProxyConfigManager;
import com.wing.server.common.vo.ProxyServer;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

/**
 * Created by nijia on 2018/4/26.
 */
public class ProxyApplication extends AbsApplication {



    private ProxyConfigManager proxyConfigManager;

    private ProxyServer proxyServer;

    /**spring 上下文信息*/
    private ApplicationContext applicationContext;

    public void init() throws Exception{
        //加载spring
        ApplicationContext applicationContext = new FileSystemXmlApplicationContext(new String[] { "classpath:spring-config.xml" });
        this.applicationContext = applicationContext;

        proxyConfigManager = new ProxyConfigManager();
        proxyConfigManager.init();

        proxyServer = new ProxyServer(proxyConfigManager.getProxyConfig().getId());
    }




    public ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    public ProxyServer getProxyServer() {
        return proxyServer;
    }

    public ProxyConfigManager getProxyConfigManager() {
        return proxyConfigManager;
    }
}
