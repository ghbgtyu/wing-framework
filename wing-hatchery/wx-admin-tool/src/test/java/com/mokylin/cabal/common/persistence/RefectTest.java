package com.mokylin.cabal.common.persistence;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import com.mokylin.cabal.common.utils.Reflections;
import com.mokylin.cabal.modules.sys.entity.User;
import com.mokylin.cabal.modules.tools.entity.GameNotice;
import org.junit.Test;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.HashMap;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/17 15:34
 * 项目: cabal-tools
 */
public class RefectTest {

    @Test
    public void test() {
        MybatisParameter<User> parameterObject = new MybatisParameter();
        Page<User> page = new Page(1, 3);
        parameterObject.setPage(page);
        Page<User> userPage = (Page<User>) Reflections.getFieldValue(parameterObject, "page");
        System.out.println(userPage.getPageNo() + "\t" + userPage.getPageSize() + "\t" + userPage.toString());
    }

    @Test
    public void getFields() {
        GameNotice gameNotice = new GameNotice();
        gameNotice.setContent("Hello");
        gameNotice.setServerIds("1,2,3,12,31,23,");
        execute(gameNotice);
    }

    protected <T> void execute(Object obj) {
//        Field[] fields = obj.getClass().getDeclaredFields();
//        JSONObject object = new JSONObject();
//        for(Field field : fields){
//            System.out.println(field.getName());
//            object.put(field.getName(),Reflections.invokeGetter(obj,field.getName()));
//        }
        Field[] fields = obj.getClass().getDeclaredFields();
        for (Field field : fields) {
            if (field.getName().equals("serverIds")) {
                Reflections.invokeSetter(obj, "serverIds", "");
            }
        }
//
        System.out.println(obj.toString());
    }
}
