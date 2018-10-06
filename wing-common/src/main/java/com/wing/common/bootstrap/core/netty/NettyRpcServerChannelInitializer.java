package com.wing.common.bootstrap.core.netty;

import com.wing.common.bootstrap.core.IRouteChannelHandler;
import com.wing.common.bootstrap.core.netty.codec.Amf3Decoder;
import com.wing.common.bootstrap.core.netty.codec.Amf3Encoder;
import com.wing.common.bootstrap.core.netty.codec.SimpleEncrypt;
import com.wing.common.rpc.protobuf.RpcMsgOuterClass;
import io.netty.channel.Channel;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelPipeline;
import io.netty.handler.codec.ByteToMessageDecoder;
import io.netty.handler.codec.MessageToByteEncoder;
import io.netty.handler.codec.protobuf.ProtobufDecoder;
import io.netty.handler.codec.protobuf.ProtobufEncoder;
import io.netty.handler.codec.protobuf.ProtobufVarint32FrameDecoder;
import io.netty.handler.codec.protobuf.ProtobufVarint32LengthFieldPrepender;
import io.netty.handler.timeout.IdleStateHandler;
import org.apache.commons.lang3.mutable.MutableBoolean;

import java.util.UUID;

/**
 * Created by nijia on 2017/7/14.
 * channel 的加解密以及消息格式定义、接收消息handler
 */
public class NettyRpcServerChannelInitializer extends ChannelInitializer<Channel> {


    private NettyClientChannelAdapter nettyClientChannelAdapter;


    public NettyRpcServerChannelInitializer(IRouteChannelHandler handler){
        this.nettyClientChannelAdapter = new NettyClientChannelAdapter(handler);
    }

    @Override
    protected void initChannel(Channel channel) throws Exception {


        ChannelPipeline p = channel.pipeline();
        p.addLast("idle", new IdleStateHandler(0, 0, 0));

        p.addLast("frameDecoder", new ProtobufVarint32FrameDecoder());
        p.addLast("protobufDecoder", new ProtobufDecoder(RpcMsgOuterClass.RpcMsg.getDefaultInstance()));
        p.addLast("frameEncoder", new ProtobufVarint32LengthFieldPrepender());
        p.addLast("protobufEncoder", new ProtobufEncoder());
        p.addLast("handler", nettyClientChannelAdapter);


    }
}
