package com.mokylin.cabal.common.game.api.impl;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.mokylin.cabal.common.game.api.RoleOperation;
import com.mokylin.cabal.common.persistence.Result;
import com.mokylin.cabal.common.persistence.dynamicDataSource.LookupContext;
import com.mokylin.cabal.modules.tools.utils.GameAreaUtils;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.util.List;

/**
 * 作者: 稻草鸟人
 * 日期: 2014/11/17 13:53
 * 项目: cabal-tools
 */
public class RoleTemplate extends AbstractGameOperations implements RoleOperation {

    private static final String API_URL_ROLE_BATCH_JINYAN_SUFFIX = "/role/batchJinYan";

    private static final String API_URL_ROLE_BATCH_FENHAO_SUFFIX = "/role/batchFenHao";

    private static final String API_URL_ROLE_BATCH_CANCEL_JINYAN_SUFFIX = "/role/batchCancelJinYan";

    private static final String API_URL_ROLE_BATCH_CANCEL_FENHAO_SUFFIX = "/role/batchCancelFenHao";

    public static final String API_URL_ROLE_UPDATE_ROLE_TYPE = "/role/updateRoleType";

    public static final String API_URL_ROLE_DELETE = "/role/delete";

    public RoleTemplate(RestTemplate restTemplate) {
        super(restTemplate);
    }

    @Override
    public Result jinYan(String serverId, String roleId) {
        String remoteUrl = GameAreaUtils.getGameRemoteUrlByServerId(serverId);
        URI uri = buildUri(remoteUrl + API_URL_ROLE_BATCH_JINYAN_SUFFIX);
        List<String> roleIds = Lists.newArrayList();
        roleIds.add(roleId);
        return execute(roleIds, uri);
    }

    @Override
    public Result batchJinYan(List<String> roleIds) {
        String remoteUrl = GameAreaUtils.getGameRemoteUrlByServerId(LookupContext.getCurrentServerId());
        URI uri = buildUri(remoteUrl + API_URL_ROLE_BATCH_JINYAN_SUFFIX);
        return execute(roleIds, uri);
    }

    @Override
    public Result batchFenHao(List<String> roleIds) {
        String remoteUrl = GameAreaUtils.getGameRemoteUrlByServerId(LookupContext.getCurrentServerId());
        URI uri = buildUri(remoteUrl + API_URL_ROLE_BATCH_FENHAO_SUFFIX);
        return execute(roleIds, uri);
    }

    @Override
    public Result batchCancelJinYan(List<String> roleIds) {
        String remoteUrl = GameAreaUtils.getGameRemoteUrlByServerId(LookupContext.getCurrentServerId());
        URI uri = buildUri(remoteUrl + API_URL_ROLE_BATCH_CANCEL_JINYAN_SUFFIX);
        return execute(roleIds, uri);
    }

    @Override
    public Result batchCancelFenHao(List<String> roleIds) {
        String remoteUrl = GameAreaUtils.getGameRemoteUrlByServerId(LookupContext.getCurrentServerId());
        URI uri = buildUri(remoteUrl + API_URL_ROLE_BATCH_CANCEL_FENHAO_SUFFIX);
        return execute(roleIds, uri);
    }

    @Override
    public Result updateRoleType(String serverId, String roleId, String roleType) {
        String remoteUrl = GameAreaUtils.getGameRemoteUrlByServerId(serverId);
        URI uri = buildUri(remoteUrl + API_URL_ROLE_UPDATE_ROLE_TYPE);
        JSONObject object = new JSONObject();
        object.put("roleId", roleId);
        object.put("roleType", roleType);
        return execute(object, uri);
    }

    @Override
    public Result delete(String serverId, Long roleId) {
        String url = GameAreaUtils.getGameRemoteUrlByServerId(serverId);
        URI uri = buildUri(url + API_URL_ROLE_DELETE);
        JSONObject object = new JSONObject();
        object.put("roleId", roleId);
        return execute(object, uri);
    }
}
