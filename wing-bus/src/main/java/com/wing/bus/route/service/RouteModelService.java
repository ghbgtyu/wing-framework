package com.wing.bus.route.service;

import com.wing.bus.BusServerContext;
import com.wing.bus.application.config.BusConfig;
import com.wing.common.service.IModelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by nijia on 2017/7/7.
 *
 * 路由服务
 * 生命周期 {服务启动、关闭}
 * 服务内容 {客户端路由转发、http路由转发、内部rpc转发}
 */
@Service
public class RouteModelService implements IModelService{

    @Autowired
    private RouteManager routeManager;

    @Override
    public void onStart() throws  Exception {

        BusConfig busConfig = BusServerContext.getBusApplicationManager().getApplicationContext().getBusConfigManager().getBusConfig();
        //加载与客户端的tcp连接
        //  routeManager.registerClient(serverConfig.getInnerRpcPort(),"SHOWMETHEMONEY20MILLION",new BusAmfClientChannelHandler(), BootStrapType.AMF);




        routeManager.start();
    }

    @Override
    public void onStop() throws  Exception {
        routeManager.stop();
    }
}
