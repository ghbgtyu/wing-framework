package com.wing.common.service;

/**
 * Created by nijia on 2017/7/7.
 * 每个模块服务接口
 *
 */
public interface IModelService {
    /**服务启动*/
    public void onStart() throws  Exception;
    /**服务关闭*/
    public void onStop() throws  Exception;
}
