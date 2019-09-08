package cn.asyysy.app.redis;


public interface RedisBaseService {
    /**
     * 根据key获取obj
     * @param key
     * @return
     */
    Object get(String key);

    /**
     * 保持短网址到redis
     * @param longUrl
     */
    void saveShortUrl(String longUrl);

}
