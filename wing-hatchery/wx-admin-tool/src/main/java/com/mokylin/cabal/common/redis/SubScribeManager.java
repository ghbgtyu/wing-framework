package com.mokylin.cabal.common.redis;

import com.alibaba.fastjson.JSON;
import com.mokylin.cabal.common.service.ServiceException;
import org.apache.commons.lang3.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import redis.clients.jedis.JedisPubSub;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

@Component
public class SubScribeManager extends JedisPubSub implements Runnable {
    private final Logger logger = LoggerFactory.getLogger(getClass());
    //	private final String GAME_SERVER_REDIS_KEY = "game";
    private Redis redis;
    @Resource
    private ServerManager serverManager;


    @PostConstruct
    public void init() {
        this.redis = serverManager.getRedisManager().getGameCache();

        Thread thread = new Thread(this);
        thread.setDaemon(true);
        thread.setName("SubScribe Monitor");
        thread.start();
    }

    @Override
    public void run() {
        try {
            redis.subscribe(this, RedisConstant.CHANNEL_SERVER_GLOBAL, RedisConstant.CHANNEL_SERVER_CROSS, RedisConstant.CHANNEL_SERVER_GAME);//现在的服务器列表，订阅的RedisConstant.CHANNEL_SERVER_GAME
        } catch (ServiceException e) {
            logger.error("订阅线程无故退出", e);
        }
    }

    // 取得订阅的消息后的处理
    public void onMessage(String channel, String message) {
        try {
            if (NumberUtils.isNumber(message)) {
                // 删除服务器
                int worldId = Integer.parseInt(message);
                switch (channel) {
                    case RedisConstant.CHANNEL_SERVER_GAME: {
                        serverManager.destory(SystemConstant.SERVER_TYPE_GAME, worldId);
                        break;
                    }
                    case RedisConstant.CHANNEL_SERVER_CROSS: {
                        serverManager.destory(SystemConstant.SERVER_TYPE_CROSS, worldId);
                        break;
                    }
                    case RedisConstant.CHANNEL_SERVER_GLOBAL: {
                        serverManager.destory(SystemConstant.SERVER_TYPE_GLOBAL, worldId);
                        break;
                    }
                }
            } else {
                Server server = JSON.parseObject(message, Server.class);
                serverManager.register(server);
            }

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }

    }

    // 初始化订阅时候的处理

    /**
     * @param channel      订阅的频道
     * @param channelIndex 订阅的频道序号
     */
    public void onSubscribe(String channel, int channelIndex) {
        logger.info("订阅的频道 channel={},index={}", channel, channelIndex);
    }

    // 取消订阅时候的处理
    public void onUnsubscribe(String channel, int subscribedChannels) {

    }

    // 初始化按表达式的方式订阅时候的处理

    /**
     * @param pattern            订阅的key模式
     * @param subscribedChannels 订阅的频道序号
     */
    public void onPSubscribe(String pattern, int subscribedChannels) {

    }

    // 取消按表达式的方式订阅时候的处理
    public void onPUnsubscribe(String pattern, int subscribedChannels) {

    }

    // 取得按表达式的方式订阅的消息后的处理
    public void onPMessage(String pattern, String channel, String message) {

    }

}
