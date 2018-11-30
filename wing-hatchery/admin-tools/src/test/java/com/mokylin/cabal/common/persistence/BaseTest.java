package com.mokylin.cabal.common.persistence;

import com.mokylin.cabal.common.test.SpringTransactionalContextTests;

import javax.annotation.Resource;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/30 11:45
 * 项目: cabal-tools
 */
public class BaseTest extends SpringTransactionalContextTests {

    @Resource(name= "toolDaoTemplate")
    ToolDaoTemplate toolDaoTemplate;
}
