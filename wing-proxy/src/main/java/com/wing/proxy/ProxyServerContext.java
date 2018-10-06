package com.wing.proxy;

import com.wing.proxy.application.ProxyApplicationManager;

/**
 * Created by nijia on 2017/12/10.
 */
public class ProxyServerContext {

    private static ProxyApplicationManager proxyApplicationManager;

    /**proxy 模块系统上下文管理器*/
    public static ProxyApplicationManager getProxyApplicationManager() {
        return proxyApplicationManager;
    }

    /**设置系统上下文管理器*/
    public static void setProxyApplicationManager(ProxyApplicationManager busApplicationManager){
        ProxyServerContext.proxyApplicationManager = busApplicationManager;
    }
}
