package com.wing.common.bootstrap.core.netty;

import com.wing.common.bootstrap.core.IRouteChannelHandler;
import com.wing.common.bootstrap.core.netty.codec.Amf3Decoder;
import com.wing.common.bootstrap.core.netty.codec.Amf3Encoder;
import com.wing.common.bootstrap.core.netty.codec.SimpleEncrypt;
import io.netty.channel.Channel;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelPipeline;
import io.netty.handler.codec.ByteToMessageDecoder;
import io.netty.handler.codec.MessageToByteEncoder;
import io.netty.handler.timeout.IdleStateHandler;
import org.apache.commons.lang3.mutable.MutableBoolean;

import java.util.UUID;

/**
 * Created by nijia on 2017/7/14.
 * channel 的加解密以及消息格式定义、接收消息handler
 */
public class NettyClientChannelInitializer extends ChannelInitializer<Channel> {


    private NettyClientChannelAdapter nettyClientChannelAdapter;
    private String tick;

    public NettyClientChannelInitializer(IRouteChannelHandler handler,String tick){
        this.nettyClientChannelAdapter = new NettyClientChannelAdapter(handler);
        this.tick = tick;
    }

    @Override
    protected void initChannel(Channel channel) throws Exception {
        //amf 的编码解码器
        String key = UUID.randomUUID().toString();
        MutableBoolean common=new MutableBoolean(true);
        SimpleEncrypt encrypt = new SimpleEncrypt(key, tick);
        ByteToMessageDecoder decoder =  new Amf3Decoder(false, encrypt,common);
        MessageToByteEncoder encoder = new Amf3Encoder(common);



        ChannelPipeline p = channel.pipeline();
        p.addLast("idle", new IdleStateHandler(0, 0, 0));
        p.addLast("decoder", decoder);

        p.addLast("encoder", encoder);
        p.addLast("handle",  nettyClientChannelAdapter);
    }
}
