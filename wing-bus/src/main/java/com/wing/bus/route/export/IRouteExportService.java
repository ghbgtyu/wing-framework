package com.wing.bus.route.export;

import com.wing.common.bootstrap.BootStrapType;
import com.wing.common.bootstrap.ClientObjectChannelHandler;

/**
 * Created by nijia on 2017/7/18.
 * 对外接口
 */
public interface IRouteExportService {


    /**注册客户端路由*/
    public void registerClient(int port,String tick, ClientObjectChannelHandler handler,BootStrapType type)throws  Exception;
}
