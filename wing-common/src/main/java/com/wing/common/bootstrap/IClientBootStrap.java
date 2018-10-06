package com.wing.common.bootstrap;

/**
 * Created by nijia on 2018/5/11.
 */
public interface IClientBootStrap extends IBootStrap{


    /**链接是否正常激活状态*/
    public boolean isConnected();
    /**连接*/
    public void connect();
    /**断开链接*/
    public void disconnect();
}
