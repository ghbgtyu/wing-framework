package com.mokylin.cabal.common.game.api;

import com.mokylin.cabal.common.persistence.Result;

import java.util.List;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/11/17 13:52
 * 项目: cabal-tools
 */
public interface RoleOperation {

    Result jinYan(String serverId, String roleId);

    Result batchJinYan(List<String> roleIds);

    Result batchFenHao(List<String> roleIds);

    Result batchCancelJinYan(List<String> roleIds);

    Result batchCancelFenHao(List<String> roleIds);

    Result updateRoleType(String serverId, String roleId, String roleType);

    Result delete(String serverId, Long roleId);
}
