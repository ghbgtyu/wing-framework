package com.wing.common.bootstrap;

import com.wing.common.bootstrap.core.IRouteChannelHandler;
import com.wing.common.bootstrap.core.netty.NettyRpcServerChannelInitializer;
import com.wing.common.util.LogUtil;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.buffer.PooledByteBufAllocator;
import io.netty.channel.*;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioServerSocketChannel;

import java.net.InetSocketAddress;

/**
 * Created by nijia on 2018/4/27.
 */
public class NettyRpcServerBootStrap implements IBootStrap {


    private EventLoopGroup bossGroup = new NioEventLoopGroup(2);
    private EventLoopGroup workerGroup = new NioEventLoopGroup();
    private final ServerBootstrap bootstrap = new ServerBootstrap();

    private IRouteChannelHandler handler;
    private final int port ;


    public NettyRpcServerBootStrap(int port,ClientObjectChannelHandler handler){
        this.port = port;
        this.handler = handler;
    }


    @Override
    public void start() throws Exception {

        bootstrap.group(bossGroup, workerGroup);
        bootstrap.channel(NioServerSocketChannel.class);

        bootstrap.childHandler(new NettyRpcServerChannelInitializer(handler));
        bootstrap.childOption(ChannelOption.TCP_NODELAY, true);
        bootstrap.childOption(ChannelOption.SO_KEEPALIVE, true);
        bootstrap.option(ChannelOption.SO_REUSEADDR, true);
        //bootstrap.option(ChannelOption.ALLOCATOR, PooledByteBufAllocator.DEFAULT);
        bootstrap.childOption(ChannelOption.ALLOCATOR, PooledByteBufAllocator.DEFAULT);

        try {
            bootstrap.bind(new InetSocketAddress(port)).sync();
        } catch (Exception e) {
            LogUtil.info("{} rpc server start on {} failed", port);
            throw new Exception(e);
        }



    }

    @Override
    public void stop() throws Exception {
        bossGroup.shutdownGracefully();
        bossGroup.terminationFuture();

        workerGroup.shutdownGracefully();
        workerGroup.terminationFuture();
    }
}
