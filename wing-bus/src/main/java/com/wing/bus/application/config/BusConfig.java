package com.wing.bus.application.config;

/**
 * Created by nijia on 2017/7/19.
 *
 * <br>
 *  服务器的配置
 *
 */


public class BusConfig {

    private int id;

    /**内部rpc端口*/
    private int innerRpcPort;

    public int getInnerRpcPort() {
        return innerRpcPort;
    }

    public void setInnerRpcPort(int innerRpcPort) {
        this.innerRpcPort = innerRpcPort;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
