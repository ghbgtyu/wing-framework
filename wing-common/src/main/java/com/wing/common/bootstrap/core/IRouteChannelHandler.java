package com.wing.common.bootstrap.core;

/**
 * Created by nijia on 2017/7/12.
 */
public interface IRouteChannelHandler <T>{

    /**连接激活的时候*/
    public void channelActive(IRouteChannel channel) throws Exception ;

    /**断开连接*/
    public void channelInactive(IRouteChannel channel) throws Exception;

    /**接收信息*/
    public void channelRead(IRouteChannel channel, T msg) throws Exception;

}
