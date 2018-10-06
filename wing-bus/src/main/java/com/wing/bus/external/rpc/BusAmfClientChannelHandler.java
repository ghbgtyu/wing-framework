package com.wing.bus.external.rpc;

import com.wing.common.util.LogUtil;
import com.wing.common.bootstrap.ClientObjectChannelHandler;
import com.wing.common.bootstrap.core.IRouteChannel;


/**
 * Created by nijia on 2017/9/11.
 */

public class BusAmfClientChannelHandler extends ClientObjectChannelHandler{


    @Override
    public void channelActive(IRouteChannel channel) throws Exception {
        LogUtil.info("channelActive");
    }

    @Override
    public void channelInactive(IRouteChannel channel) throws Exception {
        LogUtil.info("channelInactive");
    }

    @Override
    protected void channelRead1(IRouteChannel channel, Object[] msg) {
        LogUtil.info("channelRead1");
    }
}
