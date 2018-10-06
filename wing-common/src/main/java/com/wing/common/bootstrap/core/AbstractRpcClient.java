package com.wing.common.bootstrap.core;

import com.wing.common.bootstrap.IClientBootStrap;

/**
 * Created by nijia on 2018/5/11.
 * RPC client 抽象类<br>
 * 作为client端，需要考虑<br>
 * 1. timeout 与服务端超时连接
 * 2. connect 重新与服务端连接
 * 3. disconnect 断开与服务端的连接
 *
 *
 */
public abstract class AbstractRpcClient implements IClientBootStrap {




}
