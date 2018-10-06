package com.wing.common.bootstrap.core.netty.codec;

import java.nio.charset.Charset;
import java.util.List;

import com.wing.common.util.LogUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.mutable.MutableBoolean;


import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.ByteToMessageDecoder;

/** 解码器 */

public class Amf3Decoder extends ByteToMessageDecoder {
	private final static String POLICY = "<?xml version=\"1.0\"?><cross-domain-policy><allow-access-from domain=\"*\" to-ports=\"*\"/></cross-domain-policy>\0";
	private final static String POLICY_REQUEST = "<policy-file-request/>";
	// private boolean tgwMode;
	private boolean amf3;
	private final SimpleEncrypt encrypt;
	private boolean firstPackReceived;
	private MutableBoolean common;// 策略文件请求 false,正常消息true

	public Amf3Decoder(boolean tgwMode, SimpleEncrypt encrypt, MutableBoolean common) {
		// this.tgwMode = tgwMode;
		this.encrypt = encrypt;
		this.common = common;
	}

	@Override
	protected void decode(ChannelHandlerContext ctx, ByteBuf byteBuf, List<Object> objects) throws Exception {
		//logger.trace("Amf3Decoder");
//		if (tgwMode) {
//			this.handleTgw(byteBuf);
//		}

		if (byteBuf.readableBytes() < 4) {
			return;
		}
		// mark读索引
		byteBuf.markReaderIndex();
		int length = byteBuf.readInt();
		if (length > 65536) {
			byteBuf.resetReaderIndex();
			byte[] content = new byte[byteBuf.readableBytes()];
			byteBuf.readBytes(content);
			String request = new String(content);
			this.handle4LargeMsg(request, ctx, byteBuf);
			return;
		}
		if (length < 0) {
			LogUtil.error("request msg length <0,length={}", length);
			byteBuf.resetReaderIndex();
			ctx.close();
			return;
		}

		if (byteBuf.readableBytes() < length) {
			byteBuf.resetReaderIndex();
			return;
		}

		if (amf3) {
			// logger.info("length={},msg={}", content.length, content);
			int msgType = byteBuf.readInt();
			byte[] content = new byte[length - 4];
			byteBuf.readBytes(content);
			content = encrypt.decode(content);
		//	Object[] msg = (Object[]) Amf3.parse(content);
			if(objects!=null){
				objects.add(new Object[]{msgType,content});
			}
			//throw new ServiceException(1);
			//objects.add(content.length);
		} else {
			// logger.info("length={},msg={}", content.length, content);
			byte[] content = new byte[length];
			byteBuf.readBytes(content);
			String key = encrypt.getKey();
			LogUtil.info("handshake from {} by {} key={}", ctx.channel().remoteAddress(), new String(content), key);
			ctx.channel().writeAndFlush(key.getBytes());
			amf3 = true;
		}

	}

	private void handle4LargeMsg(String request, ChannelHandlerContext ctx, ByteBuf byteBuf) {
		// 怀疑是请求安全策略
		if (request.indexOf(POLICY_REQUEST) >= 0) {
			common.setFalse();
			ctx.channel().writeAndFlush(POLICY.getBytes());
			LogUtil.warn("该用户无法访问843端口，从主端口获取安全策略 address={}", ctx.channel().remoteAddress());
		} else {
			LogUtil.error("request msg length > 65536,address={}", ctx.channel().remoteAddress());
			byteBuf.resetReaderIndex();
			ctx.close();
		}
	}


	private void handleTgw(ByteBuf byteBuf) {
		if (!firstPackReceived) {
			// mark读索引
			byteBuf.markReaderIndex();
			byte[] content = new byte[byteBuf.readableBytes()];
			byteBuf.readBytes(content);
			String str = new String(content, Charset.forName("UTF-8"));
			// logger.info("str={}",str);
			int doubleCRLFindex = StringUtils.indexOf(str, "\r\n\r\n");
			if (doubleCRLFindex > 0) {
				// 有头部信息tgw_l7_forward\r\nHost:s{0}.app1101340201.qqopenapp.com:8001\r\n\r\n
				String httpHeader = str.substring(0, doubleCRLFindex + 4);
				LogUtil.info("http-header:{}", httpHeader);
				// 重置到上次的读索引
				byteBuf.resetReaderIndex();
				// 越过httpHeader.getBytes().length字节
				int length = httpHeader.getBytes(Charset.forName("UTF-8")).length;
				byteBuf.skipBytes(length);
				firstPackReceived = true;
			} else {
				byteBuf.resetReaderIndex();
			}
			return;
		} else {
			// logger.debug("不是第一个包，忽略TGW处理");
		}
	}
}
