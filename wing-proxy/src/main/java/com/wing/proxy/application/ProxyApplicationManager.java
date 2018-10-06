package com.wing.proxy.application;

import com.wing.common.context.AbsProcessContextManager;

/**
 * Created by nijia on 2018/4/27.
 */
public class ProxyApplicationManager extends AbsProcessContextManager<ProxyApplication> {


    private ProxyApplication proxyApplication;

    @Override
    public ProxyApplication getApplicationContext() {
        return proxyApplication;
    }

    @Override
    public void initApplicationContext() throws Exception {
        proxyApplication = new ProxyApplication();
        proxyApplication.init();
    }
}
