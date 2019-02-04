/**
 * Copyright &copy; 2014-2015 <a href="https://github.com/mokylin/cabal">cabal</a> All rights reserved.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.mokylin.cabal.modules.sys.dao;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.mokylin.cabal.common.persistence.BaseDao;
import com.mokylin.cabal.common.persistence.Parameter;
import com.mokylin.cabal.modules.sys.entity.User;

/**
 * 用户DAO接口
 * @author 稻草鸟人
 * @version 2014-8-23
 */
@Repository
public class UserDao extends BaseDao<User> {

    public List<User> findAllList() {
        return find("from User where delFlag=:p1 order by id", new Parameter(User.DEL_FLAG_NORMAL));
    }

    public User findByLoginName(String loginName) {
        return getByHql("from User where loginName = :p1 and delFlag = :p2", new Parameter(loginName, User.DEL_FLAG_NORMAL));
    }

    public int updatePasswordById(String newPassword, String id) {
        return update("update User set password=:p1 where id = :p2", new Parameter(newPassword, id));
    }

    public int updateLoginInfo(String loginIp, Date loginDate, String id) {
        return update("update User set loginIp=:p1, loginDate=:p2 where id = :p3", new Parameter(loginIp, loginDate, id));
    }

    /**
     * 得到有相同role角色的所有userId
     * @param id
     * @return
     */
    public List<String> findUserIdsByUserId(String id) {
        return findBySql("select DISTINCT ui.id as userId from sys_user ui,sys_user_role ur where ur.user_id=ui.id and ur.role_id in (\n" +
                "\t\tselect ur.role_id from sys_user ui,sys_user_role ur where ui.id=ur.user_id and ui.id = :p1\n" +
                "\t)\n", new Parameter(id));
    }

}
