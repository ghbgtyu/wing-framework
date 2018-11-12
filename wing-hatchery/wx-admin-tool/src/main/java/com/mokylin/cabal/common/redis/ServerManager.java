package com.mokylin.cabal.common.redis;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.mokylin.cabal.common.persistence.MybatisParameter;
import com.mokylin.cabal.common.persistence.ToolDaoTemplate;
import com.mokylin.cabal.common.utils.IdGen;
import com.mokylin.cabal.modules.tools.entity.GamePlatform;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.*;

@Component
public class ServerManager {

    private static final Logger logger = LoggerFactory.getLogger(ServerManager.class);

    @Resource
    private ToolDaoTemplate toolDaoTemplate;

    /**
     * 存放redis中的服务器信息的
     */
    // key-pid value-Map
    private Map<String, GameAreaMap> gameAreaMap = Maps.newHashMap();
    private Map<String, BaseCrossArea> crossAreaMap = new HashMap<>();
    // key-wordId value-Server
    private Map<Integer, Server> gameServerMap = Maps.newHashMap();
    private Map<Integer, Server> crossServerMap = Maps.newHashMap();

    private Server globalServer;

    @Resource
    private RedisManager redisManager;

    public ServerManager() {
    }

    @PostConstruct
    public void init() {
        logger.info("项目启动-缓存初始化开始");

        //初始化 gameAreaMap 从本地数据库中取
        List<Server> servers = toolDaoTemplate.selectList("gameArea.findAllGameArea");
        for (Server server : servers) {
            GameAreaMap gam = gameAreaMap.get(server.getPlatformId());
            if (gam == null) {
                gam = new GameAreaMap();
                gameAreaMap.put(server.getPlatformId(), gam);
            }
            gam.addGameArea(server);
        }
        logger.info("项目启动-缓存初始化,gameAreaMap初始化结束，大小[{}]", gameAreaMap.size());

        List<Server> serverList = redisManager.getServerList(RedisConstant.KEY_SERVER_GAME);
        // 初始化 gameServerMap
        for (Server server : serverList) {
            syncGameServer(server);
            gameServerMap.put(server.getWorldId(), server);
        }
        logger.info("项目启动-缓存初始化,gameServerMap初始化结束，大小[{}]", gameServerMap.size());

		List<Server> crossServerList = getRedisManager().getServerList(RedisConstant.KEY_SERVER_CROSS);
		// 初始化 crossServerMap
		for (Server server : crossServerList) {
			if (server.getType() == 2) {// TODO shenggm 应该为getSubType
				crossServerMap.put(server.getWorldId(), server);
			}
		}
		logger.info("项目启动-缓存初始化,crossServerList初始化结束，大小[{}]", crossServerMap.size());
		
		// 初始化 crossServerMap
		List<BaseCrossArea> crossAreas = redisManager.selectALLCrossAreaFromRedis();
		for (BaseCrossArea b : crossAreas) {
			crossAreaMap.put(b.getCrossAreaId(), b);
		}
		logger.info("项目启动-缓存初始化,crossAreaMap初始化结束，大小[{}]", crossAreaMap.size());
    }

    public Server getGameServer(int serverId) {
        return gameServerMap.get(serverId);
    }

    public Server getCrossServer(int serverId) {
        return crossServerMap.get(serverId);
    }

    public List<Server> getCrossServerList() {
        return new ArrayList<>(crossServerMap.values());
    }

    public Server getGlobalServer() {
        return globalServer;
    }

    public void destory(int type, int worldId) {
        logger.info("注销服务器 type={}，worldId={}", type, worldId);
        Server server = null;
        switch (type) {
            case SystemConstant.SERVER_TYPE_GAME: {
                destoryGameServer(worldId);
                break;
            }
            case SystemConstant.SERVER_TYPE_CROSS: {
                server = crossServerMap.get(worldId);
                break;
            }
            case SystemConstant.SERVER_TYPE_GLOBAL: {
                server = globalServer;
                break;
            }
        }
        if (server != null) {
            server.setStatus(SystemConstant.SERVER_STATUS_STOPED);
        }
    }

    public void register(Server server) {
        logger.info("添加服务器 server={}", server.toString());
        switch (server.getType()) {
            case SystemConstant.SERVER_TYPE_GAME: {
                syncGameServer(server);
                gameServerMap.put(server.getWorldId(), server);
                break;
            }
            case SystemConstant.SERVER_TYPE_CROSS: {
                // crossServerMap.put(server.getWorldId(), server);
                break;
            }
            case SystemConstant.SERVER_TYPE_GLOBAL: {
                // globalServer = server;
                break;
            }
        }
    }

    public RedisManager getRedisManager() {
        return redisManager;
    }

    /**
     * 注册游戏服务器
     *
     * @param server
     */
    private void registerGameServer(Server server) {
        try {
            MybatisParameter parameter = createNewMybatisParameter();
            parameter.put("server", server);
            List<Map<String, Object>> gameServer = toolDaoTemplate.selectList("gameArea.findGameAreaByWorldId", parameter);
            if (null != gameServer && gameServer.size() > 0) {
                toolDaoTemplate.update("gameArea.update", parameter);
            } else {
                toolDaoTemplate.insert("gameArea.insert", parameter);
            }
            gameServerMap.put(server.getWorldId(), server);
        } catch (Exception ex) {
            logger.error(ex.getMessage(), ex);
        }
    }

    /**
     * 注销游戏服务器
     *
     * @param worldId
     */
    private void destoryGameServer(int worldId) {
        try {
            MybatisParameter parameter = createNewMybatisParameter();

            parameter.put("worldId", worldId);
            //List<Map<String, Object>> gameServer = toolDaoTemplate.selectList("gameArea.findGameAreaByWorldId", parameter);
            Server gameServer = gameServerMap.get(worldId);
            if (null != gameServer) {
                Server server = getGameServerByServerId(gameServer.getPlatformId(), gameServer.getWorldId());
                if (server != null) {
                    parameter.put("status", SystemConstant.SERVER_STATUS_STOPED);// 设置服务器为停止状态
                    toolDaoTemplate.update("gameArea.update", parameter);
                }
            }

            gameServerMap.remove(worldId);
        } catch (Exception ex) {
            logger.error(ex.getMessage(), ex);
        }
    }

    /**
     * 创建执行sql的基本条件，设置必须的初始值
     *
     * @return
     */
    private MybatisParameter createNewMybatisParameter() {
        MybatisParameter parameter = new MybatisParameter<>();
        parameter.put("id", IdGen.uuid());
        return parameter;
    }

    /**
     * 先保存平台，在保存服务器信息
     * @param server
     */
    private void insertGameAreaAndGamePlatform(Server server){
        saveGamePlatform(server);
        insert(server);
    }

    /**
     * 如果平台不存在则保存平台
     * @param server
     */
    private void saveGamePlatform(Server server){
        MybatisParameter parameter = new MybatisParameter();
        parameter.put("pid", String.valueOf(server.getPlatformId()));
        GamePlatform gamePlatform = toolDaoTemplate.selectOne("gamePlatform.findGamePlatformByPid",parameter);
        if(gamePlatform == null){
            parameter.put("id", IdGen.uuid());
            parameter.put("name",String.valueOf(server.getPlatformId()));
            parameter.put("pid", String.valueOf(server.getPlatformId()));
            parameter.put("description", String.valueOf(server.getPlatformId()));
            toolDaoTemplate.insert("gamePlatform.insert",parameter);
        }
    }

    private void insert(Server server) {
        //更新gameAreaMap
        GameAreaMap map = gameAreaMap.get(server.getPlatformId());
        if (map == null) {
            map = new GameAreaMap();
            gameAreaMap.put(server.getPlatformId(), map);
            logger.info("gameAreaMap 添加数据，大小【{}】",gameAreaMap.size());
        }
        map.addGameArea(server);
        server.setOpenTime(new Date());
        //更新数据库
        MybatisParameter parameter = createNewMybatisParameter();
        parameter.put("server", server);
        parameter.put("pid", server.getPlatformId());
        toolDaoTemplate.insert("gameArea.insert", parameter);
    }


    /**
     * 服务器重启的时候，获取redis中最新的服务器列表信息，更新到数据库
     * 订阅的服务器也走这边
     * 如果本地数据库中不存在当前服，则插入，否则更新本地数据库
     *
     * @param server
     */
    public void syncGameServer(Server server) {
        Server gameServer = getGameServerByServerId(server.getPlatformId(), server.getWorldId());
        if (gameServer == null) {
            insertGameAreaAndGamePlatform(server);
        } else {
            if (!gameServer.equals(server)) {
                MybatisParameter parameter = createNewMybatisParameter();
                parameter.put("worldId", server.getWorldId());
                parameter.put("server", server);
                parameter.put("pid", server.getPlatformId());
                toolDaoTemplate.update("gameArea.updateByWorldId", parameter);
            }
        }
    }

    public Server getGameServerByServerId(String pid, int serverId) {
        Server server = null;
        GameAreaMap temp = gameAreaMap.get(pid);
        if (temp != null) {
            server = temp.getGameAreaByWordId(serverId);
        }
        return server;
    }

    public Map<Integer, Server> getGameServerMap() {
        return gameServerMap;
    }

    public List<Server> getGameServerList(List<String> serverId) {
        List<Server> serverList = Lists.newArrayList();
        for (String id : serverId) {
            serverList.add(this.getGameServer(Integer.parseInt(id)));
        }
        return serverList;
    }

    public List<Server> getGameServerList() {
        List<Server> serverList = Lists.newArrayList();
        for (Map.Entry<Integer, Server> entry : gameServerMap.entrySet()) {
            serverList.add(entry.getValue());
        }
        return serverList;
    }

    // 更具平台ID获取服务器列表
    public Collection<Server> getGameServerList(String pid) {
        GameAreaMap map = gameAreaMap.get(pid);
        if (map == null) {
            return Collections.emptyList();
        }
        return map.values();
    }

    // 获取所有平台的ID
    public Collection<String> getPlatformIdList() {
        return gameAreaMap.keySet();
    }

    public class GameAreaMap {
        private Map<Integer, Server> serverMap = Maps.newHashMap();

        public void addGameArea(Server server) {
            serverMap.put(server.getWorldId(), server);
        }

        public Server getGameAreaByWordId(Integer wordId) {
            return serverMap.get(wordId);
        }

        public Collection<Server> values() {
            return serverMap.values();
        }

        public Set<Integer> keys() {
            return serverMap.keySet();
        }
    }

//	/**
//	 * 获取战区信息
//	 * 
//	 * @return
//	 */
//	public Map<String, BaseCrossArea> getCrossAreaMap() {
//		return crossAreaMap;
//	}

    /**
     * 获取匹配服务器战区信息
     *
     * @return
     */
    public List<BaseCrossArea> getBattleCrossArea() {
        List<BaseCrossArea> result = new ArrayList<>();
        for (BaseCrossArea b : crossAreaMap.values()) {
            if (b.getCrossType() == SystemConstant.BATTLE_CROSS) {
                result.add(b);
            }
        }
        return result;
    }

	/**
	 * 获取国家战区信息
	 * 
	 * @return
	 */
	public List<BaseCrossArea> getCountryCrossArea() {
		List<BaseCrossArea> result = new ArrayList<>();
		for (BaseCrossArea b : crossAreaMap.values()) {
			if (b.getCrossType() == SystemConstant.COUNTRY_CROSS) {
				result.add(b);
			}
		}
		return result;
	}
	/**
	 * 获取所有战区信息
	 * 
	 * @return
	 */
	public List<BaseCrossArea> getAllCrossArea() {
		return new ArrayList<>(crossAreaMap.values());
	}

	/**
	 * 添加战场区域
	 * @param bca
	 */
	public void addCrossArea(BaseCrossArea bca) {
		crossAreaMap.put(bca.getCrossAreaId(), bca);
		redisManager.getCrossAreaCache().hset(RedisConstant.KEY_CROSS_AREA, bca.getCrossAreaId(), bca.toJson());
	}
	
	/**
	 * 通过战区类型和战区ID,获取指定的战区
	 * @param crossAreaType 战区类型
	 * @param wroldId 跨服服务器ID
	 * @return
	 */
	public BaseCrossArea getCrossArea(String crossAreaType,String wroldId) {
		return crossAreaMap.get(crossAreaType+"_"+wroldId);
	}
	/**
	 * 删除所有战区信息
	 */
	public void removeAllCrossArea() {
		crossAreaMap.clear();
		redisManager.getCrossAreaCache().del(RedisConstant.KEY_CROSS_AREA);
	}
	/**
	 * 删除指定的战区信息
	 * @param bca
	 */
	public void removeCrossArea(BaseCrossArea bca) {
		crossAreaMap.remove(bca.getCrossAreaId());
		redisManager.getCrossAreaCache().hdel(RedisConstant.KEY_CROSS_AREA, bca.getCrossAreaId());;
	}
	/**
	 * 删除指定的战区信息
	 * @param crossAreaType 战区类型
	 * @param crossAreaId 跨服服务器ID
	 */
	public void removeCrossAreaById(String crossAreaType,String crossAreaId) {
		crossAreaMap.remove(crossAreaType+"_"+crossAreaId);
		redisManager.getCrossAreaCache().hdel(RedisConstant.KEY_CROSS_AREA, crossAreaType+"_"+crossAreaId);;
	}
    /**
     * 获取所有战区信息
     *
     * @return
     */
    public List<BaseCrossArea> getALlCrossArea() {
        return new ArrayList<>(crossAreaMap.values());
    }

    public void addCrossArea(int crossAreaType, BaseCrossArea bca) {
        crossAreaMap.put(crossAreaType + "_" + bca.getCrossServer().getWorldId(), bca);
    }

    public void getCrossArea(int crossAreaType, int wroldId) {
        crossAreaMap.get(crossAreaType + "_" + wroldId);
    }

}
