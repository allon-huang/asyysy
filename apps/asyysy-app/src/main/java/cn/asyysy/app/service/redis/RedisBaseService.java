package cn.asyysy.app.service.redis;


import cn.asyysy.app.model.short_url.ShortUrl;

public interface RedisBaseService {
    /**
     * 根据key获取obj
     * @param key
     * @return
     */
    ShortUrl get(String key);

    /**
     * 保持短网址到redis
     * @param longUrl
     */
    void saveShortUrl(String longUrl);

}
