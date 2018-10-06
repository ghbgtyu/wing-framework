package com.wing.common.context;

/**
 * Created by nijia on 2017/12/7.
 * 管理系统上下文
 */
public interface IProcessContextManager<T extends IApplication> {

    /**获取当前系统上下文*/
    public T getApplicationContext();

    /**系统上下文初始化*/
    public void initApplicationContext() throws Exception;

}
