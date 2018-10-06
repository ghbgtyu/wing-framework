package com.wing.proxy;

import com.wing.center.CenterClient;
import com.wing.common.service.IModelService;
import com.wing.proxy.application.ProxyApplicationManager;
import com.wing.server.common.vo.BusServer;
import com.wing.server.common.vo.ProxyServer;
import org.springframework.context.ApplicationContext;

/**
 * Created by nijia on 2018/4/27.
 */
public class ProxyService implements IModelService {




    @Override
    public void onStart() throws Exception {
        //初始化系统上下文，一些配置信息和基础环境
        ProxyApplicationManager proxyApplicationManager = new ProxyApplicationManager();
        proxyApplicationManager.initApplicationContext();

        ProxyServerContext.setProxyApplicationManager(proxyApplicationManager);

        //spring 上下文，用于获取所管理的类
        ApplicationContext applicationContext = proxyApplicationManager.getApplicationContext().getApplicationContext();




        //route 模块启动 ，与客户端的tcp连接等。

        //告知服务中心，proxy服起来了
        ProxyServer proxyServer = proxyApplicationManager.getApplicationContext().getProxyServer();
        CenterClient.getInstance().getServerCenterClient().start(proxyServer);



    }

    @Override
    public void onStop() throws Exception {
        ApplicationContext applicationContext = ProxyServerContext.getProxyApplicationManager().getApplicationContext().getApplicationContext();

        //关闭的时候，先和别人说，我关闭了
        ProxyServer proxyServer = ProxyServerContext.getProxyApplicationManager().getApplicationContext().getProxyServer();
        CenterClient.getInstance().getServerCenterClient().close(proxyServer);


    }
}
