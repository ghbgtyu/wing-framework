package com.mokylin.cabal.common.persistence;

import com.alibaba.fastjson.JSON;
import com.mokylin.cabal.modules.tools.entity.GameNotice;
import org.junit.Test;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/30 11:46
 * 项目: cabal-tools
 */
public class GameNoticeTest extends BaseTest {


    @Test
    public void testSelectById(){
        GameNotice gameNotice = toolDaoTemplate.selectOne("gameNotice.selectOneById",1);
        System.out.println(JSON.toJSONString(gameNotice));
    }
}
