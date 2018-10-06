package com.wing.bus.route.service;

import com.wing.common.bootstrap.BootStrapFactory;
import com.wing.common.util.LogUtil;
import com.wing.common.bootstrap.BootStrapType;
import com.wing.common.bootstrap.ClientObjectChannelHandler;
import com.wing.common.bootstrap.IBootStrap;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by nijia on 2017/7/18.
 */
@Service
public class RouteManager {



    /**客户端boostrap TCP 端口*/
    private Map<Integer,IBootStrap> clientBootStrapMap = new HashMap<>();

    /**注册客户端路由*/
    public void registerClient(int port,String tick, ClientObjectChannelHandler handler,BootStrapType type) throws  Exception{
        IBootStrap bootStrap = BootStrapFactory.createAmfBootStrap(port,tick,handler);
        if(this.clientBootStrapMap.containsKey(port)){
            LogUtil.error("该端口已经注册过了,port={}"+port);
            throw  new Exception("该端口已经注册过了,port:"+port);
        }
        this.clientBootStrapMap.put(port,bootStrap);

    }

    public void start() throws  Exception {
        for( IBootStrap bootStrap:clientBootStrapMap.values() ){
            bootStrap.start();
        }
    }
    public void stop() throws  Exception {
        for( IBootStrap bootStrap:clientBootStrapMap.values() ){
            bootStrap.stop();
        }
    }
}
