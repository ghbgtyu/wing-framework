package com.wing.server.common.constants;

/**
 * Created by nijia on 2018/4/11.<br>
 * 服务器常量
 */
public class ServerConstants {


    /** 服务器处于正常运行状态 */
    public final static int SERVER_STATUS_OPENING = 1;
    /** 服务器处于运维维护状态 */
    public final static int SERVER_STATUS_MAINTAIN = 2;
    /** 服务器处于停服状态 */
    public final static int SERVER_STATUS_STOPED = 0;

    /** bus业务服务器*/
    public final static String SERVER_BUS = "server_bus";
    /** proxy 服务器*/
    public final static String SEVER_PROXY = "server_proxy";

}
