package com.wing.common.config.abs;

import com.wing.common.config.abs.AbsConfigHelper;

import java.io.File;

/**
 * Created by nijia on 2017/8/20.
 */
  public abstract class StaticAbsConfigHelper extends AbsConfigHelper<File> {

    protected File file ;



    @Override
    public void registerSource(File file) throws Exception{
        this.file = file;
        registerFile(file);
    }

    /**注册配置文件*/
    public abstract void registerFile(File file) throws Exception;
}
