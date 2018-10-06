package com.wing.bus;

import com.wing.bus.application.BusApplicationManager;
import com.wing.bus.route.service.RouteModelService;
import com.wing.center.CenterClient;
import com.wing.common.service.IModelService;
import com.wing.server.common.vo.BusServer;
import org.springframework.context.ApplicationContext;

/**
 * Created by nijia on 2017/9/11.
 */
public class BusService implements IModelService{



    @Override
    public void onStart() throws Exception {


        //初始化系统上下文，一些配置信息和基础环境
        BusApplicationManager busApplicationManager = new BusApplicationManager();
        busApplicationManager.initApplicationContext();

        BusServerContext.setBusApplicationManager(busApplicationManager);

        //spring 上下文，用于获取所管理的类
        ApplicationContext applicationContext = busApplicationManager.getApplicationContext().getApplicationContext();




        //route 模块启动 ，与客户端的tcp连接等。
        RouteModelService routeModelService = applicationContext.getBean(RouteModelService.class);




        routeModelService.onStart();

        BusServer busServer = busApplicationManager.getApplicationContext().getBusServer();
        CenterClient.getInstance().getServerCenterClient().start(busServer);

        //告知服务中心，bus服起来了

    }



    @Override
    public void onStop() throws Exception {
        ApplicationContext applicationContext = BusServerContext.getBusApplicationManager().getApplicationContext().getApplicationContext();

        //关闭的时候，先和别人说，我关闭了
        BusServer busServer = BusServerContext.getBusApplicationManager().getApplicationContext().getBusServer();
        CenterClient.getInstance().getServerCenterClient().close(busServer);

        RouteModelService routeModelService = applicationContext.getBean(RouteModelService.class);
        routeModelService.onStop();





    }
}
