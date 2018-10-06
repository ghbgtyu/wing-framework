package com.wing.common.bootstrap.core;

/**
 * Created by nijia on 2017/7/12.
 *
 *
 *
 */
public interface IRouteChannel {

    /**发送消息及时刷新,*/
    public void writeAndFlush(Object msg);
    /**发送消息，先不刷新*/
    public void write(Object msg);
    /**刷新消息*/
    public void flush();

    /**关闭连接*/
    public void close();
}
