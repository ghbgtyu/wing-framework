package com.wing.bus.application;

import com.wing.common.context.AbsProcessContextManager;

/**
 * Created by nijia on 2017/12/7.
 */
public class BusApplicationManager extends AbsProcessContextManager<BusApplication> {


    private BusApplication busApplication;

    @Override
    public void initApplicationContext() throws Exception {
        busApplication = new BusApplication();
        busApplication.init();
    }

    @Override
    public BusApplication getApplicationContext() {
        return busApplication;
    }
}
