package com.wing.proxy.application.config;

/**
 * Created by nijia on 2018/4/27.
 */
public class ProxyConfig {
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
