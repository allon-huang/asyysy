package cn.asyysy.app.service.redis.impl;

import cn.asyysy.app.service.redis.RedisBaseService;
import cn.asyysy.common.config.SystemInfo;
import cn.asyysy.consts.BaseConsts;
import cn.asyysy.app.model.short_url.ShortUrl;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Date;

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
     * 根据key获取obj
     * @param key
     * @return
     */
    @Override
    public Object get(String key) {
        return redisTemplate.opsForValue().get(key);
    }

    /**
     * 保持短网址到redis
     *
     * @param longUrl
     */
    @Override
    public void saveShortUrl(String longUrl) {
        // 获取随机字符串
        String shortCode= RandomStringUtils.randomAlphanumeric(10);
        String shortUrl = systemConfig.SHORT_URL_DOAMIN + shortCode;
        ShortUrl dao = new ShortUrl();
        dao.setShortUrl(shortUrl);
        dao.setPathUrl(shortCode);
        dao.setRedirctTime(0L);
        dao.setCDate(new Date());
        dao.setLongUrl(longUrl);
        redisTemplate.opsForValue().set(BaseConsts.REDIS_KEY.SHORT_URL + shortCode, JSON.toJSONString(dao));
    }
}
