package com.wing.bus.route.export;

import com.wing.common.bootstrap.BootStrapType;
import com.wing.common.bootstrap.ClientObjectChannelHandler;
import com.wing.bus.route.service.RouteManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by nijia on 2017/7/18.
 */
@Service
public class RouteExportService implements IRouteExportService {

    @Autowired
    private RouteManager routeManager;

    @Override
    public void registerClient(int port, String tick,ClientObjectChannelHandler handler,BootStrapType type)throws  Exception {
        routeManager.registerClient(port,tick,handler,type);
    }
}
