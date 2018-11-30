package com.mokylin.cabal.common.cache;

import com.mokylin.cabal.common.utils.StringUtils;
import net.sf.ehcache.CacheException;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Ehcache;


public class EhcacheCacheManager implements ICacheManager {

    private CacheManager cacheManager;

    public EhcacheCacheManager(CacheManager cacheManager) {
        this.cacheManager = cacheManager;
    }

    @Override
    public final <K, V> ICache<K, V> getCache(String name) throws CacheException {
        if (StringUtils.isEmpty(name)) {
            throw new IllegalArgumentException("参数 name 非法！");
        }
        try {
            Ehcache cache = cacheManager.getEhcache(name);
            if (cache == null) {
                cacheManager.addCache(name);
                cache = cacheManager.getCache(name);
            }
            return new EhcacheCache<K, V>(cache);
        } catch (Throwable t) {
            throw new CacheException(t);
        }
    }

}