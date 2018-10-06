package com.wing.common.config.annotation;

import java.lang.annotation.*;

/**
 * Created by nijia on 2017/7/1.
 * 用于解析config配置<br>
 * 用于标识配置文件是哪种类型
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Config {

    Type type () default Type.PROPERTY;

    public enum Type{
        XML,
        PROPERTY
    }

    @Target({ElementType.FIELD})
    @Retention(RetentionPolicy.RUNTIME)
    @Documented
    public @interface ConfigAttribute{
        /**配置文件的key*/
        String key () default "";
        /**xml配置文件的节点名字*/
        String xmlElementName () default "";
    }

}
