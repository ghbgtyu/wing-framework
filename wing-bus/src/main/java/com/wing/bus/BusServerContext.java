package com.wing.bus;

import com.wing.bus.application.BusApplicationManager;

/**
 * Created by nijia on 2017/12/10.
 */
public class BusServerContext {

    private static  BusApplicationManager busApplicationManager= null;

    /**bus 模块系统上下文管理器*/
    public static BusApplicationManager getBusApplicationManager() {
        return busApplicationManager;
    }
    /**设置系统上下文管理器*/
    public static void setBusApplicationManager(BusApplicationManager busApplicationManager){
        BusServerContext.busApplicationManager = busApplicationManager;
    }
}
