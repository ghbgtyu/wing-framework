/**
 * Copyright &copy; 2014-2015 <a href="https://github.com/mokylin/cabal">cabal</a> All rights reserved.
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.mokylin.cabal.modules.sys.utils;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.subject.Subject;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.sql.JoinType;

import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.mokylin.cabal.common.service.BaseService;
import com.mokylin.cabal.common.utils.SpringContextHolder;
import com.mokylin.cabal.modules.sys.dao.AreaDao;
import com.mokylin.cabal.modules.sys.dao.MenuDao;
import com.mokylin.cabal.modules.sys.dao.OfficeDao;
import com.mokylin.cabal.modules.sys.dao.RoleDao;
import com.mokylin.cabal.modules.sys.dao.UserDao;
import com.mokylin.cabal.modules.sys.entity.Area;
import com.mokylin.cabal.modules.sys.entity.Menu;
import com.mokylin.cabal.modules.sys.entity.Office;
import com.mokylin.cabal.modules.sys.entity.Role;
import com.mokylin.cabal.modules.sys.entity.User;
import com.mokylin.cabal.modules.sys.security.SystemAuthorizingRealm;
import com.mokylin.cabal.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.mokylin.cabal.modules.tools.dao.GamePlatformDao;
import com.mokylin.cabal.modules.tools.entity.GamePlatform;

/**
 * 用户工具类
 *
 * @author 稻草鸟人
 * @version 2014-5-29
 */
public class UserUtils extends BaseService {

    private static UserDao userDao = SpringContextHolder.getBean(UserDao.class);
    private static RoleDao roleDao = SpringContextHolder.getBean(RoleDao.class);
    private static MenuDao menuDao = SpringContextHolder.getBean(MenuDao.class);
    private static AreaDao areaDao = SpringContextHolder.getBean(AreaDao.class);
    private static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);
    private static GamePlatformDao gamePlatformDao = SpringContextHolder.getBean(GamePlatformDao.class);

    public static final String CACHE_USER = "user";
    public static final String CACHE_ROLE_LIST = "roleList";
    public static final String CACHE_MENU_LIST = "menuList";
    public static final String CACHE_AREA_LIST = "areaList";
    public static final String CACHE_OFFICE_LIST = "officeList";
    public static final String CACHE_GAME_PLATFORM_SET = "gamePlatformSet";
    public static final String CACHE_GAME_PLATFORM_LIST = "gamePlatformList";
    public static final String CACHE_ROLE_USER_ID_LIST = "roleUserIdList";

    public static User getUser() {
        User user = (User) getCache(CACHE_USER);
        if (user == null) {
            try {
                Subject subject = SecurityUtils.getSubject();
                Principal principal = (Principal) subject.getPrincipal();
                if (principal != null) {
                    user = userDao.get(principal.getId());
//					Hibernate.initialize(user.getRoleList());
                    putCache(CACHE_USER, user);
                }
            } catch (UnavailableSecurityManagerException e) {

            } catch (InvalidSessionException e) {

            }
        }
        if (user == null) {
            user = new User();
            try {
                SecurityUtils.getSubject().logout();
            } catch (UnavailableSecurityManagerException e) {

            } catch (InvalidSessionException e) {

            }
        }
        return user;
    }

    public static User getUser(boolean isRefresh) {
        if (isRefresh) {
            removeCache(CACHE_USER);
        }
        return getUser();
    }

    public static List<Role> getRoleList() {
        @SuppressWarnings("unchecked")
        List<Role> list = (List<Role>) getCache(CACHE_ROLE_LIST);
        if (list == null) {
            User user = getUser();
            DetachedCriteria dc = roleDao.createDetachedCriteria();
            dc.createAlias("office", "office");
            dc.createAlias("userList", "userList", JoinType.LEFT_OUTER_JOIN);
            dc.add(dataScopeFilter(user, "office", "userList"));
            dc.add(Restrictions.eq(Role.FIELD_DEL_FLAG, Role.DEL_FLAG_NORMAL));
            dc.addOrder(Order.asc("office.code")).addOrder(Order.asc("name"));
            list = roleDao.find(dc);
            putCache(CACHE_ROLE_LIST, list);
        }
        return list;
    }

    public static List<Menu> getMenuList() {
        @SuppressWarnings("unchecked")
        List<Menu> menuList = (List<Menu>) getCache(CACHE_MENU_LIST);
        if (menuList == null) {
            User user = getUser();
            if (user.isAdmin()) {
                menuList = menuDao.findAllList();
            } else {
                menuList = menuDao.findByUserId(user.getId());
            }
            putCache(CACHE_MENU_LIST, menuList);
        }
        return menuList;
    }


    //用户是否具有全平台访问权限
    public static boolean hasAllPlatformPermission(User user) {
        boolean flag = false;
        for (Role role : user.getRoleList()) {
            if (role.hasAllPlatformPermission()) {
                flag = true;
            }
        }
        return flag;
    }

    /**
     * 根据UserId取得具有相同角色的所有的UserId，这个用于查询数据时权限
     * @param user
     * @return
     */
    public static List<String> getTheSameRoleUserIds(User user) {
        List<String> roleUserIdList = (List<String>) getCache(CACHE_ROLE_USER_ID_LIST);
        if (roleUserIdList == null) {
            roleUserIdList = userDao.findUserIdsByUserId(user.getId());
            putCache(CACHE_ROLE_USER_ID_LIST, roleUserIdList);
        }
        return roleUserIdList;
    }


    public static List<GamePlatform> getAllGamePlatform() {
        List<GamePlatform> gamePlatformList = (List<GamePlatform>) getCache(CACHE_GAME_PLATFORM_LIST);
        if (gamePlatformList == null) {
            gamePlatformList = gamePlatformDao.findAllList();

            putCache(CACHE_GAME_PLATFORM_LIST, gamePlatformList);
        }

        return gamePlatformList;
    }

    /**
     * 管理员具有所有服的权限，Role属性isGlobal为1的也具有所有平台权限
     * 不同角色可能具有相同平台权限，这里去除了重复的平台
     * @return
     */
    public static List<GamePlatform> getGamePlatformList() {
        Set<GamePlatform> gamePlatforms;
        User user = getUser();
        if (user.isAdmin()) {
            gamePlatforms = new HashSet<GamePlatform>(getAllGamePlatform());
        } else {
            gamePlatforms = Sets.newHashSet();
            for (Role role : user.getRoleList()) {
                if (role.hasAllPlatformPermission()) {
                    gamePlatforms = new HashSet<GamePlatform>(getAllGamePlatform());
                    break;
                }
                for (GamePlatform gamePlatform : role.getGamePlatformList()) {
                    gamePlatforms.add(gamePlatform);
                }
            }
        }
        return new ArrayList<GamePlatform>(gamePlatforms);
    }

    /**
     *
     * @return
     */
    public static List<GamePlatform> getGamePlatformListContainServer() {
        List<GamePlatform> gamePlatforms = getGamePlatformList();

        for (GamePlatform gamePlatform : gamePlatforms) {

        }

        return new ArrayList<GamePlatform>(gamePlatforms);
    }

//    //当前用户所有,这里有重复的平台
//    public static List<GamePlatform> getCurrentUserGamePlatformList() {
//        List<GamePlatform> gamePlatformList = Lists.newArrayList();
//        for (Role role : getUser().getRoleList()) {
//            for (GamePlatform gamePlatform : role.getGamePlatformList()) {
//                gamePlatformList.add(gamePlatform);
//            }
//        }
//        return gamePlatformList;
//    }

    public static List<Area> getAreaList() {
        @SuppressWarnings("unchecked")
        List<Area> areaList = (List<Area>) getCache(CACHE_AREA_LIST);
        if (areaList == null) {
//			User user = getUser();
//			if (user.isAdmin()){
            areaList = areaDao.findAllList();
//			}else{
//				areaList = areaDao.findAllChild(user.getArea().getId(), "%,"+user.getArea().getId()+",%");
//			}
            putCache(CACHE_AREA_LIST, areaList);
        }
        return areaList;
    }


    public static List<Office> getOfficeList() {
        @SuppressWarnings("unchecked")
        List<Office> officeList = (List<Office>) getCache(CACHE_OFFICE_LIST);
        if (officeList == null) {
            User user = getUser();
//			if (user.isAdmin()){
//				officeList = officeDao.findAllList();
//			}else{
//				officeList = officeDao.findAllChild(user.getOffice().getId(), "%,"+user.getOffice().getId()+",%");
//			}
            DetachedCriteria dc = officeDao.createDetachedCriteria();
            dc.add(dataScopeFilter(user, dc.getAlias(), ""));
            dc.add(Restrictions.eq("delFlag", Office.DEL_FLAG_NORMAL));
            dc.addOrder(Order.asc("code"));
            officeList = officeDao.find(dc);
            putCache(CACHE_OFFICE_LIST, officeList);
        }
        return officeList;
    }


    public static User getUserById(String id) {
        if (StringUtils.isNotBlank(id)) {
            return userDao.get(id);
        } else {
            return null;
        }
    }

    // ============== User Cache ==============

    public static Object getCache(String key) {
        return getCache(key, null);
    }

    public static Object getCache(String key, Object defaultValue) {
        Object obj = getCacheMap().get(key);
        return obj == null ? defaultValue : obj;
    }

    public static void putCache(String key, Object value) {
        getCacheMap().put(key, value);
    }

    public static void removeCache(String key) {
        getCacheMap().remove(key);
    }

    public static Map<String, Object> getCacheMap() {
        Map<String, Object> map = Maps.newHashMap();
        try {
            Subject subject = SecurityUtils.getSubject();
            SystemAuthorizingRealm.Principal principal = (SystemAuthorizingRealm.Principal) subject.getPrincipal();
            return principal != null ? principal.getCacheMap() : map;
        } catch (UnavailableSecurityManagerException e) {

        } catch (InvalidSessionException e) {

        }
        return map;
    }

}
