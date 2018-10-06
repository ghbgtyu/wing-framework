package com.wing.center.application;

import com.wing.common.context.AbsProcessContextManager;

/**
 * Created by nijia on 2018/4/3.
 */
public class CenterApplicationManager extends AbsProcessContextManager<CenterApplication> {


    private CenterApplication application;

    @Override
    public CenterApplication getApplicationContext() {
        return application;
    }

    @Override
    public void initApplicationContext() throws Exception {
        application = new CenterApplication();
        application.init();
    }
}
