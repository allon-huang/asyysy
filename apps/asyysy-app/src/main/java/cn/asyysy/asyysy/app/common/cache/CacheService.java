package cn.asyysy.asyysy.app.common.cache;

public interface CacheService {
    String get(String id);

    String delete(String id);

    String save(String id, String value);

    String update(String id, String value);
}
