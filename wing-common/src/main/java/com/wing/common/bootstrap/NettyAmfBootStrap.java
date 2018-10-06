package com.wing.common.bootstrap;

import com.wing.common.util.LogUtil;
import com.wing.common.bootstrap.core.IRouteChannelHandler;
import com.wing.common.bootstrap.core.netty.GameMessageSizeEstimator;
import com.wing.common.bootstrap.core.netty.NettyClientChannelInitializer;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.buffer.PooledByteBufAllocator;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.handler.codec.ByteToMessageDecoder;
import io.netty.handler.codec.MessageToByteEncoder;

import java.net.InetSocketAddress;

/**
 * Created by nijia on 2017/7/18.
 */
 class NettyAmfBootStrap implements IBootStrap{


    private EventLoopGroup bossGroup = new NioEventLoopGroup(2);
    private EventLoopGroup workerGroup = new NioEventLoopGroup();
    private final ServerBootstrap bootstrap = new ServerBootstrap();
    private final int port ;
    private IRouteChannelHandler handler;
    private String tick;

    public  NettyAmfBootStrap(int port,ClientObjectChannelHandler handler,String tick) {
        this.port = port;
        this.handler = handler;
        this.tick = tick;
    }

    @Override
    public void start()throws Exception {
        LogUtil.info("初始化TCP服务开始");
        // Configure the server.

        bootstrap.group(bossGroup, workerGroup);
        bootstrap.channel(NioServerSocketChannel.class);
        bootstrap.option(ChannelOption.TCP_NODELAY, true);
        bootstrap.option(ChannelOption.SO_REUSEADDR, true);
        bootstrap.option(ChannelOption.SO_RCVBUF, 43690); // 43690 为默认值
        bootstrap.option(ChannelOption.SO_SNDBUF, 32768);// 32k

        bootstrap.childOption(ChannelOption.TCP_NODELAY, true);
        bootstrap.childOption(ChannelOption.SO_RCVBUF, 43690); // 43690 为默认值
        bootstrap.childOption(ChannelOption.SO_SNDBUF, 512 * 1024);// 32k为默认值,现在改成512K
        // 字节
        bootstrap.childOption(ChannelOption.MESSAGE_SIZE_ESTIMATOR, GameMessageSizeEstimator.DEFAULT);

        // 把boss线程给池化
        // bootstrap.option(ChannelOption.ALLOCATOR,
        // PooledByteBufAllocator.DEFAULT);
        // 把worker线程给池化
        bootstrap.childOption(ChannelOption.ALLOCATOR, PooledByteBufAllocator.DEFAULT);
        // Set up the pipeline factory.


        bootstrap.childHandler(new NettyClientChannelInitializer(handler,tick));

        // Bind and start to accept incoming connections.
        try {
            bootstrap.bind(new InetSocketAddress(port)).sync();
            LogUtil.info("game tcp server start on {}", port);
            LogUtil.info("初始化TCP服务完毕");
        } catch (Exception e) {
            LogUtil.info("初始化TCP服务失败");
            throw e;
        }
    }

    @Override
    public void stop() throws Exception {
        bossGroup.shutdownGracefully();
        workerGroup.shutdownGracefully();
    }
}
