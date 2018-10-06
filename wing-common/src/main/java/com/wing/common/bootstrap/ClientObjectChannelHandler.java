package com.wing.common.bootstrap;

import com.wing.common.bootstrap.core.AbsChannelHandler;
import com.wing.common.bootstrap.core.IRouteChannel;

/**
 * Created by nijia on 2017/7/13.
 *
 *  接收客户端消息处理类
 *
 */
public abstract class ClientObjectChannelHandler extends AbsChannelHandler<Object[]>{



    /**
     * @param  msg 接收的消息 ，格式 new Object[]{type(协议号),context(信息内容)}
     *
     * */
    protected abstract void channelRead1(IRouteChannel channel,Object[]msg);


    @Override
    protected void channelRead0(IRouteChannel channel,Object[]msg){
        channelRead1(channel,msg);
    }
}
