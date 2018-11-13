package com.mokylin.cabal.common.redis;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.mokylin.cabal.common.redis.CountryCrossArea.Country;
import com.mokylin.cabal.modules.sys.utils.ConfigConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.*;

/**
 * 作者: 稻草鸟人 日期: 2014/11/26 14:21 项目: cabal-tools
 */
@Component
public class RedisManager {
	private static final Logger logger = LoggerFactory.getLogger(RedisManager.class);

	/** 全局库缓存 */
	private Redis globalCache;
	private Redis gameCache;
	/**
	 * 战区缓存
	 */
	private Redis crossAreaCache;

	public RedisManager() {
	}

	public RedisManager(String ip, int port, int index) {
		globalCache = new Redis(ip, port, index);
	}

	//@PostConstruct
	public void init() {
		globalCache = new Redis(ConfigConstants.REDIS_HOST, ConfigConstants.REDIS_PORT.intValue(), ConfigConstants.CHAT_REDIS_INDEX.intValue());
		gameCache = new Redis(ConfigConstants.REDIS_HOST, ConfigConstants.REDIS_PORT.intValue(), ConfigConstants.GAME_REDIS_INDEX.intValue());
		crossAreaCache = new Redis(ConfigConstants.REDIS_HOST, ConfigConstants.REDIS_PORT.intValue(), ConfigConstants.CROSS_AREA_REDIS_INDEX.intValue());
	}

	public void init(String ip, int port, int globalIndex, int gameIndex) {
		globalCache = new Redis(ip, port, globalIndex);
		gameCache = new Redis(ip, port, gameIndex);
	}

	public Map<String, String> getKeywords() {
		Map<String, String> map = Maps.newHashMap();
		Set<String> keys = globalCache.keys("keyword_*");
		for (String key : keys) {
			map.put(key, globalCache.get(key));
		}

		return map;
	}

	public void addKeyword(String key, String value) {
		globalCache.set(key, value);
	}

	public void deleteKeyword(String key) {
		globalCache.del(key);
	}

	public List<String> getChatContent() {
		return globalCache.lrange("chat_records", 0, -1);
	}

	public long lpush(String key, String value) {
		return globalCache.lpush(key, value);
	}

	public static void main(String[] args) throws InterruptedException {
		RedisManager manager = new RedisManager("192.168.1.27", 6379, 4);
		Map<String, String> result = manager.getGlobalCache().hgetAll(RedisConstant.KEY_SERVER_CROSS);
		// {27={"followerId":0,"innerIp":"192.168.1.27","innerPort":9528,"platformId":0,"status":0,"subType":0,"tcpPort":0,"type":2,"webPort":10088,"worldId":27,"worldName":"C65000"},
		// 550={"followerId":0,"innerIp":"192.168.1.27","innerPort":9528,"status":0,"subType":0,"tcpPort":0,"type":2,"webPort":10088,"worldId":550,"worldName":"C65000"}}
		System.out.println(result);
	}

	public List<Server> getServerList(String type) {

		List<Server> ret = Lists.newArrayList();
		Map<String, String> map = gameCache.hgetAll(type);
		Collection<String> list = map.values();
		for (String e : list) {
			Server server = JSON.parseObject(e, Server.class);
			ret.add(server);
		}
		return ret;
	}

	public Server getServer(String keyServerGlobal) {
		return null;
	}

	public Redis getGlobalCache() {
		return globalCache;
	}

	public Redis getGameCache() {
		return gameCache;
	}

	public Redis getCrossAreaCache() {
		return crossAreaCache;
	}

	public void saveCrossAreaToRedis(BaseCrossArea crossArea) {
		this.crossAreaCache.hset(RedisConstant.KEY_CROSS_AREA, crossArea.getCrossType() + "_" + crossArea.getCrossServer().getWorldId(), crossArea.toJson());
	}

	/**
	 * 从redis中加载所有的战区信息
	 * 
	 * @return
	 */
	public List<BaseCrossArea> selectALLCrossAreaFromRedis() {
		Map<String, String> jsonList = this.crossAreaCache.hgetAll(RedisConstant.KEY_CROSS_AREA);
		List<BaseCrossArea> result = new ArrayList<>();
		for (String key : jsonList.keySet()) {
			// 根据key的开头可以区分战区类型
			if (key.startsWith(SystemConstant.BATTLE_CROSS + "")) {
				result.add(JSONObject.parseObject(jsonList.get(key), BattleCrossArea.class));
			} else if (key.startsWith(SystemConstant.COUNTRY_CROSS + "")) {
				//将redis中的json反序列化成 CountryCrossArea 对象
				JSONObject obj = JSONObject.parseObject(jsonList.get(key));
				JSONArray allServersJson = (JSONArray) obj.get("allServers");
				JSONObject countrysJson = (JSONObject) obj.get("countrys");
				String crossAreaNameJson = (String) obj.get("crossAreaName");
				JSONObject crossServerJson = (JSONObject) obj.get("crossServer");
				List<JSONObject> allServers = JSONObject.parseObject(allServersJson.toJSONString(), ArrayList.class);
				Server cs = JSONObject.parseObject(crossServerJson.toJSONString(), Server.class);
				CountryCrossArea cca = new CountryCrossArea(crossAreaNameJson, cs);
				Map<Integer, Country> ccsOld = cca.getCountrys();
				// 获取国家列表
				HashMap<String, JSONObject> countryJson = JSONObject.parseObject(countrysJson.toJSONString(), HashMap.class);
				for (JSONObject countryJsonInfo : countryJson.values()) {
					// 获取国家列表中的游戏服务器列表
					List<Integer> allServerId = (List) countryJsonInfo.get("allServerId");
					// 对比所有的游戏服务器列表,相同的则设置改游戏服务器为列表中的一个选项
					for (int serverId : allServerId) {
						for (JSONObject serverJson : allServers) {
							Server server = JSONObject.parseObject(serverJson.toJSONString(), Server.class);
							if (serverId == server.getWorldId()) {
								Country c = ccsOld.get(countryJsonInfo.getIntValue("country"));
								c.setFightPower(countryJsonInfo.getIntValue("fightPower"));
								c.addServer(server);
							}
						}
					}
				}
				result.add(cca);
			}
		}
		return result;
	}
}
