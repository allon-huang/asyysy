package cn.asyysy.app.service.redis;


public interface RedisBaseService {
    /**
     * 根据key获取obj
     * @param key
     * @return
     */
    Object get(String key);

    /**
     * 保存数据到redis
     * @param key redis key
     * @param obj value
     */
    void set(String key, Object obj);

    /**
     * 保存数据到redis（有超时时间）
     * @param key
     * @param obj
     * @param ttl
     */
    void set(String key, Object obj , int ttl);

    /**
     * redis 删除数据
     * @param key
     */
    void delete(String key);

    /**
     * key是否存在
     * @param key
     * @return
     */
    Boolean hasKey(String key);
}
