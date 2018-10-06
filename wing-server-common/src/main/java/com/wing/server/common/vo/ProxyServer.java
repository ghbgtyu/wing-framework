package com.wing.server.common.vo;

import com.wing.server.common.constants.ServerConstants;

/**
 * Created by nijia on 2018/4/27.
 */
public class ProxyServer extends AbsServer{


    public ProxyServer(int id){
        super(id);
    }

    @Override
    protected String getSelfType() {
        return ServerConstants.SEVER_PROXY;
    }
}
