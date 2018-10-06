package com.wing.common.bootstrap;

import com.wing.common.bootstrap.core.IRouteChannelHandler;
import io.netty.bootstrap.Bootstrap;
import io.netty.buffer.PooledByteBufAllocator;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioSocketChannel;

import java.net.InetSocketAddress;

/**
 * Created by nijia on 2018/4/27.
 */
public class NettyRpcClientBootStrap implements IClientBootStrap {


    private EventLoopGroup workerGroup = new NioEventLoopGroup(4);
    private final Bootstrap bootstrap = new Bootstrap();

    private IRouteChannelHandler handler;
    private final int port ;


    public NettyRpcClientBootStrap(int port, ClientObjectChannelHandler handler){
        this.port = port;
        this.handler = handler;
    }


    @Override
    public void start() throws Exception {

        bootstrap.group(workerGroup);
        bootstrap.channel(NioSocketChannel.class);
        bootstrap.option(ChannelOption.TCP_NODELAY, true);

        bootstrap.option(ChannelOption.ALLOCATOR, PooledByteBufAllocator.DEFAULT);


    }

    @Override
    public void stop() throws Exception {
        workerGroup.shutdownGracefully();
        workerGroup.terminationFuture();

    }



    @Override
    public boolean isConnected() {
        return false;
    }

    @Override
    public void connect() {

    }

    @Override
    public void disconnect() {

    }
}
