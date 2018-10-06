package com.wing.server.common.vo;

import com.wing.server.common.constants.ServerConstants;
import com.wing.server.common.vo.AbsServer;

/**
 * Created by nijia on 2018/4/10.
 * <br>
 * 业务服务器
 */
public class BusServer extends AbsServer {


    public BusServer(int id){
        super(id);
    }

    @Override
    protected String getSelfType() {
        return ServerConstants.SERVER_BUS;
    }
}
