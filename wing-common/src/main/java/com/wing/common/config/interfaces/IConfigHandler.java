package com.wing.common.config.interfaces;

/**
 * Created by nijia on 2017/9/3.
 */
public interface IConfigHandler<D,E> {


    /**解析文件*/
    public E parse(D d)throws Exception ;
}
