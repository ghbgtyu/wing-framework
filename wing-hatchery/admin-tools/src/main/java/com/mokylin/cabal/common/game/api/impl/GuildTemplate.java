package com.mokylin.cabal.common.game.api.impl;

import com.alibaba.fastjson.JSONObject;
import com.mokylin.cabal.common.game.api.GuildOperation;
import com.mokylin.cabal.common.persistence.Result;
import com.mokylin.cabal.modules.tools.utils.GameAreaUtils;
import org.springframework.web.client.RestTemplate;

import java.net.URI;

/**
 * 作者: 稻草鸟人
 * 日期: 2015/1/8 17:08
 * 项目: admin-tools
 * 公会操作
 */
public class GuildTemplate extends AbstractGameOperations implements GuildOperation {

    private static final String API_URL_GUILD_DELETE_SUFFIX = "/guild/delete";

    public GuildTemplate(RestTemplate restTemplate) {
        super(restTemplate);
    }

    /**
     * 解散公会
     * @param serverId
     * @param guildId 公会Id
     * @return
     */
    @Override
    public Result delete(String serverId, Long guildId) {
        String url = GameAreaUtils.getGameRemoteUrlByServerId(serverId);
        URI uri = buildUri(url + API_URL_GUILD_DELETE_SUFFIX);
        JSONObject object = new JSONObject();
        object.put("guildId",guildId);
        return execute(object,uri);
    }
}
