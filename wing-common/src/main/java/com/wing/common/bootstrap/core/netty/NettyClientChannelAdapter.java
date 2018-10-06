package com.wing.common.bootstrap.core.netty;

import com.wing.common.util.LogUtil;
import com.wing.common.bootstrap.core.IRouteChannel;
import com.wing.common.bootstrap.core.IRouteChannelHandler;
import io.netty.channel.ChannelHandler;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.handler.timeout.IdleStateEvent;
import io.netty.util.Attribute;
import io.netty.util.AttributeKey;

/**
 * Created by nijia on 2017/7/12.
 *
 * 此类需要保证线程安全
 *
 */
@ChannelHandler.Sharable
public class NettyClientChannelAdapter extends SimpleChannelInboundHandler<Object[]>{

    private IRouteChannelHandler handler;

    public static final AttributeKey<NettyChannel> NETTY_CHANNEL_KEY = AttributeKey.valueOf("netty.channel");

    public NettyClientChannelAdapter(IRouteChannelHandler handler){
        this.handler = handler;
    }

    @Override
    public void userEventTriggered(ChannelHandlerContext ctx, Object e) throws Exception {
        if (e instanceof IdleStateEvent) {
            IdleStateEvent event = (IdleStateEvent) e;
            LogUtil.info("close the channel: heartbeat {},type={}", ctx.channel(),
                    event.state());
            try {
                ctx.close();
            } catch (Exception ex) {
                LogUtil.error(ex.getMessage(), ex);
            }
        }


    }
    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable e) {
        LogUtil.error(e.getMessage(),e);
        if (ctx.channel().isActive()) {
            // fix ：An exceptionCaught() event was fired, and it reached at the
            // tail of the pipeline. It usually means the last handler in the
            // pipeline did not handle the exception.: java.io.IOException: Too
            // many open files
            // Netty server does not close/release socket
            try {
                ctx.close();
            } catch (Exception ex) {
                LogUtil.error(ex.getMessage(), ex);
            }
        }
    }

    /** 断开连接 原先的channelClosed */
    @Override
    public void channelInactive(ChannelHandlerContext ctx) throws Exception {
        LogUtil.info("{} channelClosed", ctx.channel());

        Attribute<NettyChannel> attr = ctx.channel().attr(NETTY_CHANNEL_KEY);
        NettyChannel channel = attr.getAndRemove();
        handler.channelInactive(channel);


    }

    /** 建立连接 channelConnected */
    @Override
    public void channelActive(ChannelHandlerContext ctx) throws Exception {

        Attribute<NettyChannel> attr = ctx.channel().attr(NETTY_CHANNEL_KEY);
        NettyChannel nChannel = attr.get();
        if(nChannel==null){
            NettyChannel channel = new NettyChannel(ctx.channel());
            nChannel = attr.setIfAbsent(channel);
        }

        handler.channelActive(nChannel);



    }

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, Object[] msg) throws Exception {

        Attribute<NettyChannel> attr = ctx.channel().attr(NETTY_CHANNEL_KEY);
        NettyChannel channel = attr.get();

        handler.channelRead(channel,msg);
    }
}
