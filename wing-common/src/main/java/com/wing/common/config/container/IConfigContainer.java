package com.wing.common.config.container;

import com.wing.common.config.interfaces.IConfigHandler;

/**
 * Created by nijia on 2017/9/4.
 */
public interface IConfigContainer<H> {


    /**注册handler*/
    public void registerHandler(H handler);

    /**开始解析配置文件*/
    public void parseStart() throws Exception;
    /**重新加载*/
    public void reload() throws Exception;

    /**得到对应配置*/
    public <E>E get(Class<E> e);

}
