package com.mokylin.cabal.common.persistence;

import com.mokylin.cabal.common.game.api.GameTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/10/23 9:53
 * 项目: cabal-tools
 */
public class MybatisBaseDao {

    protected final Logger LOG = LoggerFactory.getLogger(getClass());

    @Resource
    protected ToolDaoTemplate toolDaoTemplate;


    protected LogDaoTemplate logDaoTemplate;


    protected GameDaoTemplate gameDaoTemplate;


    protected GlobalDaoTemplate globalDaoTemplate;  //全局数据库，报表数据库


    @Resource
    protected GameTemplate gameTemplate;        //请求游戏接口Template


}
