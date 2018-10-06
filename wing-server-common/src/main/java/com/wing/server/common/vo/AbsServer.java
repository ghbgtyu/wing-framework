package com.wing.server.common.vo;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * Created by nijia on 2017/11/3.
 * RPC server 父类
 */
public abstract class AbsServer {

    private int id;
    /**服务器内网IP*/
    private String innerIp;
    /**服务器类型*/
    private String type;
    /**服务器状态*/
    private int state;

    public AbsServer(int id){
        //自动获取内网IP
        InetAddress iAddress = null;
        try {
            iAddress = InetAddress.getLocalHost();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        if(iAddress !=null){
            innerIp = iAddress.getHostAddress();
        }
        //获取服务器类型
        this.type = getSelfType();
        this.id = id;
    }
    /**
     * 获取自身类型
     * */
    protected abstract String getSelfType();

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getInnerIp() {
        return innerIp;
    }

    public void setInnerIp(String innerIp) {
        this.innerIp = innerIp;
    }
}
