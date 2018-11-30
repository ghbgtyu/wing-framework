package com.mokylin.cabal.cache;

import com.mokylin.cabal.common.cache.DefaultCacheManager;
import com.mokylin.cabal.common.cache.ICache;
import com.mokylin.cabal.common.cache.ICacheManager;
import org.junit.Test;

public class CacheTest {

    @Test
    public void test() {
        ICacheManager cacheManager = new DefaultCacheManager();
        ICache<String, Object> cache = cacheManager.getCache("cache_name");

        for (int i = 1; i <= 100; i++) {
            cache.put("key" + i, "value" + i);
        }

        for (int i = 1; i <= 100; i++) {
            Object value = cache.get("key" + i);
            System.out.println("key" + i + " => " + value);
        }
    }
}
