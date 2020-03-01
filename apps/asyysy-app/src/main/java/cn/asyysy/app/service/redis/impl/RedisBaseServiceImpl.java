package cn.asyysy.app.service.redis.impl;

import cn.asyysy.app.config.SystemInfo;
import cn.asyysy.app.service.redis.RedisBaseService;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service("redisBaseService")
public class RedisBaseServiceImpl implements RedisBaseService {
    /**
     * 系统对应配置
     */
    @Autowired
    SystemInfo systemConfig;

    /**
     redis
     */
    @Autowired
    private RedisTemplate redisTemplate;

    /**
     redis
     */
    @Autowired
    private StringRedisTemplate stringredisTemplate;


    /**
     * 根据key获取obj
     * @param key
     * @return
     */
    @Override
    public Object get(String key) {
        return redisTemplate.opsForValue().get(key);
    }

    @Override
    public void set(String key, Object obj) {
        if (this.hasKey(key)) {
            this.delete(key);
        }
        redisTemplate.opsForValue().set(key, JSON.toJSONString(obj));
    }

    @Override
    public void set(String key, Object obj, int ttl) {
        redisTemplate.opsForValue().set(key, obj, ttl, TimeUnit.SECONDS);
    }

    @Override
    public void delete(String key) {
        redisTemplate.delete(key);
    }

    @Override
    public Boolean hasKey(String key) {
        return redisTemplate.hasKey(key);
    }
}
