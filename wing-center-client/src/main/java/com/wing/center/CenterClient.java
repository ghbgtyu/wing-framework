package com.wing.center;

import com.wing.center.application.CenterApplicationManager;
import com.wing.center.application.config.CenterConfig;
import com.wing.center.register.client.IServerCenterClient;
import com.wing.center.register.client.RedisServerCenterClient;
import com.wing.common.util.LogUtil;
import com.wing.server.common.vo.AbsServer;

/**
 * Created by nijia on 2018/4/10.
 * <br>
 * 服务中心客户端
 * 1. 提供服务的注册、状态修改功能
 * 2. 提供动态配置的读写功能
 *
 *
 */
public class CenterClient {

    private CenterApplicationManager centerApplicationManager ;

    private static final CenterClient centerClient = new CenterClient();

    private IServerCenterClient<AbsServer>serverCenterClient;

    CenterClient(){
        //初始化
        centerApplicationManager = new CenterApplicationManager();
        try {
            centerApplicationManager.initApplicationContext();
        } catch (Exception e) {
            LogUtil.error("centerClient 初始化失败",e);
        }
        CenterConfig centerConfig = centerApplicationManager.getApplicationContext().getCenterConfigManager().getCenterConfig();
        serverCenterClient = new RedisServerCenterClient<AbsServer>(centerConfig.getIp(),centerConfig.getPort(),centerConfig.getIndex());
    }



    public static final CenterClient getInstance(){
        return centerClient;
    }

    public IServerCenterClient<AbsServer> getServerCenterClient() {
        return serverCenterClient;
    }
}
