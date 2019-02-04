package com.mokylin.cabal.redis;

import com.alibaba.fastjson.JSON;
import com.mokylin.cabal.common.persistence.BaseTest;
import com.mokylin.cabal.common.redis.RedisConstant;
import com.mokylin.cabal.common.redis.RedisManager;
import org.junit.Test;

import javax.annotation.Resource;

/**
 * 作者: 稻草鸟人
 * 日期: 2015/1/16 9:54
 * 项目: admin-tools
 */
public class RedisTest extends BaseTest {

    @Resource
    private RedisManager redisManager;

    @Test
    public void testGameCache() {
        System.out.println("========================game============================");
        System.out.println(JSON.toJSONString(redisManager.getServerList(RedisConstant.KEY_SERVER_GAME)));
        System.out.println("========================game============================");
        //System.out.println(JSON.toJSONString(redisManager.getServerList(RedisConstant.KEY_SERVER_CROSS)));
        System.out.println("========================game============================");
    }

}
