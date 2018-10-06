package com.wing.common.config.abs;

import com.wing.common.config.interfaces.IConfigHandler;

import java.io.File;

/**
 * Created by nijia on 2017/9/2.
 */
 abstract class AbsConfigHandler<H,D,E> implements IConfigHandler<D,E> {

    protected abstract H getHelper(D d)throws Exception;

    @Override
    public E parse(D d) throws Exception {
        H h = getHelper(d);


        return parseConfig(h);

    }
    /**
     *
     * 解析配置文件
     * @param  helper  配置解析器
     *
     * */
    protected abstract E parseConfig(H helper) throws  Exception;

}
