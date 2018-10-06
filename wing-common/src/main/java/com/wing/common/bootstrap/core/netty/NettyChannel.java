package com.wing.common.bootstrap.core.netty;

import com.wing.common.util.LogUtil;
import com.wing.common.bootstrap.core.IRouteChannel;
import io.netty.channel.Channel;
import io.netty.util.Attribute;

import java.util.concurrent.TimeUnit;

/**
 * Created by nijia on 2017/7/12.
 */
public class NettyChannel implements IRouteChannel  {

    private Channel channel;

    NettyChannel(Channel channel){
        this.channel = channel;
    }



    @Override
    public void writeAndFlush(Object msg) {
        if (channel.isActive()) {
            channel.writeAndFlush(msg);
        }
        if (channel.isWritable()) {
            // channel.writeAndFlush(content);// ,channel.voidPromise()
        } else {
            LogUtil.debug("channel={},isActive={},isWritable={}", channel, channel.isActive(), channel.isWritable());
        }
    }

    @Override
    public void write(Object msg) {
        channel.write(msg);
    }

    @Override
    public void flush() {
        if (channel.isActive()) {
            channel.flush();
        }
        if (channel.isWritable()) {
            // channel.writeAndFlush(content);// ,channel.voidPromise()
        } else {
            LogUtil.debug("channel={},isActive={},isWritable={}", channel, channel.isActive(), channel.isWritable());
        }
    }

    @Override
    public void close() {
        if (channel.isActive()) {
            // fix ：An exceptionCaught() event was fired, and it reached at the
            // tail of the pipeline. It usually means the last handler in the
            // pipeline did not handle the exception.: java.io.IOException: Too
            // many open files
            // Netty server does not close/release socket
            try {
                channel.close().awaitUninterruptibly(1, TimeUnit.SECONDS);
            } catch (Exception e) {
                LogUtil.error(e.getMessage(), e);
            }

        }
    }

    @Override
    public String toString() {
        return channel.toString();
    }
}
