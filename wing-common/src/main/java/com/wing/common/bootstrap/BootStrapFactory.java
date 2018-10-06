package com.wing.common.bootstrap;

import com.wing.common.bootstrap.ClientObjectChannelHandler;
import com.wing.common.bootstrap.IBootStrap;
import com.wing.common.bootstrap.NettyAmfBootStrap;

/**
 * Created by nijia on 2017/7/19.
 *
 *
 */
public class BootStrapFactory {

    /**创建netty client bootstrap实例
     * <br>
     * @param  port TCP端口
     * @param  tick 消息加密串
     * @param  handler 消息接收处理类
     *
     * */
    public static IBootStrap createAmfBootStrap(int port,String tick, ClientObjectChannelHandler handler){


        return new NettyAmfBootStrap(port,handler,tick);
    }
}
