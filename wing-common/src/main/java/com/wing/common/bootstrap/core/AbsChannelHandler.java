package com.wing.common.bootstrap.core;

/**
 * Created by nijia on 2017/7/12.
 */
public abstract class AbsChannelHandler<T> implements IRouteChannelHandler<T>{


    @Override
    public void channelRead(IRouteChannel channel, Object msg) throws Exception {

        channelRead0(channel,(T)msg);

    }

    protected abstract void channelRead0(IRouteChannel channel,T msg);
}
