package cn.asyysy.app.common.cache.impl;

import cn.asyysy.app.common.cache.CacheService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;

import java.util.HashMap;
import java.util.Map;

public class CacheServiceImpl implements CacheService {
    /**
     * log日志
     */
    public static Logger logger = (Logger) LoggerFactory.getLogger(CacheServiceImpl.class);

    private final Map<String, String> enties = new HashMap<>();

    public CacheServiceImpl() {
        enties.put("1", "this no 1");
    }
    @Autowired
    private CacheManager cacheManager;

    @Override
    public String get(String id) {
        // 记录数据产生的时间，用于测试对比
        long time = System.currentTimeMillis();
        // 打印使用到的cacheManager
        logger.info("The cacheManager is" + cacheManager);
        // 当数据不是从cache里面获取时，打印日志
        logger.info("Get value by id=" + id + ", The time is " + time);
        return "Get value by id=" + id + ",the value is" + enties.get(id);
    }

    @Override
    public String delete(String id) {
        return enties.remove(id);
    }

    @Override
    public String save(String id, String value) {
        logger.info("save value " + value + " with key " + id);
        enties.put(id, value);
        return value;
    }

    @Override
    public String update(String id, String value) {
        return enties.put(id, value);
    }
}
