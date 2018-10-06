package com.wing.common.config.abs;

import com.wing.common.config.interfaces.IConfigHelper;

/**
 * Created by nijia on 2017/8/19.
 */
 abstract class AbsConfigHelper<D> implements IConfigHelper {

    /**注册数据源*/
    public abstract void registerSource(D d) throws Exception;


}
