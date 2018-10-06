package com.wing.center.register.client;

import com.wing.center.register.redis.RedisServerConstants;
import com.wing.common.redis.Redis;
import com.wing.common.util.JsonUtil;
import com.wing.server.common.constants.ServerConstants;
import com.wing.server.common.vo.AbsServer;


/**
 * Created by nijia on 2017/11/1.
 */
public class RedisServerCenterClient<T extends AbsServer> extends AbsServerCenterClient<T> {

    /**注册的redis*/
    private Redis redis ;

    private String centerServerIp;
    private int port;

    /**
     *
     *
     * */
    public RedisServerCenterClient(String ip, int port,int index){
      this.centerServerIp = ip;
      this.port = port;
      redis = new Redis(centerServerIp,port,index);

    }


    @Override
    public boolean start(AbsServer absRpcServer) throws Exception{

        absRpcServer.setState(ServerConstants.SERVER_STATUS_OPENING);
        updateServerJson(absRpcServer);

        return true;
    }

    private void updateServerJson(AbsServer absRpcServer)throws Exception{
        try {
            String jsonStr = JsonUtil.mapper.writeValueAsString(absRpcServer);
            redis.hset(RedisServerConstants.SERVER_KEY,String.valueOf(absRpcServer.getId()),jsonStr);
        }catch (Exception e){
            throw e;
        }

    }

    @Override
    public boolean update(AbsServer absRpcServer) throws Exception{
        updateServerJson(absRpcServer);
        return true;
    }

    @Override
    public boolean close(AbsServer absRpcServer) throws Exception {
        absRpcServer.setState(ServerConstants.SERVER_STATUS_STOPED);
        updateServerJson(absRpcServer);
        return true;
    }


}
