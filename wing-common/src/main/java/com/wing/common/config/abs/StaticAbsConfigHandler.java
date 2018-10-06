package com.wing.common.config.abs;

import com.wing.common.config.interfaces.IStaticConfigHandler;

import java.io.File;

/**
 * Created by nijia on 2017/9/2.
 * 静态配置文件抽象类
 */
 public abstract class StaticAbsConfigHandler<E,H> extends AbsConfigHandler<H,File,E> implements IStaticConfigHandler<File,E> {







}
