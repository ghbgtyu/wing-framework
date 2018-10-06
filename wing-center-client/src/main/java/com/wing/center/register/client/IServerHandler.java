package com.wing.center.register.client;

import com.wing.server.common.vo.AbsServer;

/**
 * Created by nijia on 2017/11/20.
 */
public interface IServerHandler<T extends AbsServer> {

    public void handler(T t);

}
