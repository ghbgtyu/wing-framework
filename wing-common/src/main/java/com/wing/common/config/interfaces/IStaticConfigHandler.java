package com.wing.common.config.interfaces;

import java.io.File;

/**
 * Created by nijia on 2017/9/2.
 */
public interface IStaticConfigHandler<D,E> extends IConfigHandler<D,E>{


    public abstract String getType();

    /**配置所在文件名*/
    public abstract  String getFileName();

}
