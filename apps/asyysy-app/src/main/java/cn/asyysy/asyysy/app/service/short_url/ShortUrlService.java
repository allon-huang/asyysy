package cn.asyysy.asyysy.app.service.short_url;

import cn.asyysy.asyysy.app.model.ShortUrl.ShortUrl;
import com.baomidou.mybatisplus.service.IService;

public interface ShortUrlService extends IService<ShortUrl> {

    /**
     * 保存短网址
     * @param longUrl
     */
    ShortUrl save(String longUrl);

    /**
     * 保存短网址到Db
     * @param longUrl
     */
    ShortUrl saveForDb(String longUrl);

    /**
     * 根据短网址code获取短网址
     * @param shortUrl
     * @return
     */
    ShortUrl getByShortUrl(String shortUrl);

    /**
     * 更新转发次数
     * @param d
     */
    void updateRedirctTime(ShortUrl d);

}
