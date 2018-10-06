package com.wing.proxy.application.config;

import com.wing.common.config.container.FileConfigContainer;
import com.wing.common.config.interfaces.IStaticConfigHandler;
import com.wing.proxy.external.config.ProxyServerConfigHandler;

/**
 * Created by nijia on 2018/4/27.
 */
public class ProxyConfigManager {

    private ProxyConfig proxyConfig;


    public void init() throws Exception{
        //加载配置文件
        FileConfigContainer config = new FileConfigContainer("");

        IStaticConfigHandler proxyServerConfigHandler = new ProxyServerConfigHandler();
        config.registerHandler(proxyServerConfigHandler);




        config.parseStart();


        ProxyConfig proxyConfig = config.get(ProxyConfig.class);


        this.proxyConfig = proxyConfig;

    }









    public ProxyConfig getProxyConfig() {
        return proxyConfig;
    }


}
