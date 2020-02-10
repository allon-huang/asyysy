package cn.asyysy.app.service.short_url.impl;

import cn.asyysy.app.common.StringUtil;
import cn.asyysy.app.common.config.SystemInfo;
import cn.asyysy.app.exception.BaseException;
import cn.asyysy.app.mapper.short_url.ShortUrlMapper;
import cn.asyysy.app.model.short_url.ShortUrl;
import cn.asyysy.app.service.redis.RedisBaseService;
import cn.asyysy.app.service.short_url.ShortUrlService;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class ShortUrlServiceImpl extends ServiceImpl<ShortUrlMapper, ShortUrl> implements ShortUrlService {
    /**
     * log日志
     */
    public static Logger logger = (Logger) LoggerFactory.getLogger(ShortUrlServiceImpl.class);

    /**
     * 系统对应配置
     */
    @Autowired
    SystemInfo systemConfig;

    /**
     redis 服务层
     */
    @Autowired
    private RedisBaseService redisBaseService;

    /**
     * 短网址Mapper
     */
    @Autowired
    private ShortUrlMapper shortUrlMapper;

    /**
     * 保存短网址到redis
     *
     * @param longUrl
     */
    @Override
    public ShortUrl save(String longUrl) {
        if (StringUtils.isEmpty(longUrl)){
            throw new BaseException("转换的长网址不存在");
        }
        // 校验长网址格式
        if (!StringUtil.verifyUrl(longUrl)) {
            throw new BaseException("转换的长网址格式不正确（如" + systemConfig.getDomain() + "）");
        }
        // 数据库中查询短网址数据
        EntityWrapper ew = new EntityWrapper();
        ew.setEntity(new ShortUrl());
        ew.where("long_url={0}" , longUrl);
        Integer count = shortUrlMapper.selectCount(ew);
        if (count > 0) {
            throw new BaseException("当前短网址数据已存在");
        }
        // 保存 保存短网址到Db
        ShortUrl bean = this.saveForDb(longUrl);
        // 保存短网址数据到redis
        this.saveRddis(bean);
        return bean;
    }

    /**
     * 保存短网址到Db
     * @param longUrl
     */
    @Override
    public ShortUrl saveForDb(String longUrl) {
        // 获取随机字符串
        String shortCode= RandomStringUtils.randomAlphanumeric(10);
        // 短网址
        String shortUrl = systemConfig.getShortUrlDomain() + systemConfig.getContextPath() + "/d/" + shortCode;
        ShortUrl bean = new ShortUrl();
        bean.setShortUrl(shortUrl);
        bean.setShortCode(shortCode);
        bean.setRedirctTime(0L);
        bean.setCDate(new Date());
        bean.setLongUrl(longUrl);
        // 保存到数据库
        shortUrlMapper.insert(bean);
        return bean;
    }
    
    /**
     * 根据短网址code获取短网址
     * @param shortUrl
     * @return
     */
    @Override
    public ShortUrl getByShortUrl(String shortUrl) {
        if (StringUtils.isEmpty(shortUrl)) {
            throw new BaseException("短网址不可为空");
        }
        // redis 获取短网址
        ShortUrl redisData = this.getRedis(shortUrl);
        if (null != redisData) {
            return redisData;
        }

        logger.info("获取短网址-redis中无数据shortUrl:", shortUrl);
        // 数据库中查询短网址数据
        ShortUrl bean = new ShortUrl();
        bean.setShortCode(shortUrl);
        ShortUrl dbData = shortUrlMapper.selectOne(bean);
        if (null != dbData) {
            // 数据库中有数据redis中无数据
            this.saveRddis(dbData);
        }
        if (null == dbData) {
            throw new BaseException("短网址不存在，请前往申请短网址");
        }
        return dbData;
    }

    /**
     * 保存短网址数据到redis
     * @param bean
     * @return
     */
    private void saveRddis(ShortUrl bean) {
        redisBaseService.set("D_" + bean.getShortCode(), bean);
    }

    /**
     * redis 获取短网址
     * @param shortUrl
     * @return
     */
    private ShortUrl getRedis(String shortUrl) {
        Object data = redisBaseService.get("D_" + shortUrl);
        if (null == data) {
            return null;
        }
        // 转换为对象
        return JSON.parseObject(data.toString(), ShortUrl.class);
    }

    /**
     * 更新转发次数
     * @param d
     */
    @Override
    public void updateRedirctTime(ShortUrl d) {
        d.setRedirctTime( ( null == d.getRedirctTime()) ? 1 : (d.getRedirctTime() + 1));
        // 更新redis数据
        redisBaseService.set("D_" + d.getShortCode(), d);
        // 更新数据库信息
        EntityWrapper ew = new EntityWrapper();
        ew.setEntity(new ShortUrl());
        ew.where("pkid={0}" , d.getPkid());
        shortUrlMapper.update(d, ew);
    }
}
