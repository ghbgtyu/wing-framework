package com.wing.center.register.client;


import com.wing.server.common.vo.AbsServer;

/**
 * Created by nijia on 2017/11/1.
 */
public interface IServerCenterClient<T extends AbsServer> {
    /**启动*/
    public boolean start(T t)throws Exception;

    /**更新*/
    public boolean update(T t)throws Exception;

    /**关闭*/
    public boolean close(T t)throws Exception;



}
