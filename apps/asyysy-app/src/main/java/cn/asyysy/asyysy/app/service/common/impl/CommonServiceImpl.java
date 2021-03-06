package cn.asyysy.asyysy.app.service.common.impl;

import cn.asyysy.asyysy.common.utils.HttpUtil;
import cn.asyysy.asyysy.app.model.SystemInfo;
import cn.asyysy.asyysy.common.constants.BaseConstants;
import cn.asyysy.asyysy.common.exception.BaseException;
import cn.asyysy.asyysy.app.service.common.CommonService;
import cn.asyysy.asyysy.app.service.redis.RedisBaseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

/**
 * 系统公共服务实现类层
 * @author hyy
 */
@Service
public class CommonServiceImpl implements CommonService {
    /**
     * log日志
     */
    public static Logger logger = (Logger) LoggerFactory.getLogger(CommonServiceImpl.class);
    /**
     * 系统对应配置
     */
    @Autowired
    private SystemInfo systemInfo;
    /**
     redis 服务层
     */
    @Autowired
    private RedisBaseService redisBaseService;

    @Override
    public Object ncpApi() {
        Object ncpData = null;
        try {
            // redis数据
            ncpData = redisBaseService.get(BaseConstants.REDIS_KEY.NCP_DATA);
            if (null != ncpData) {
                return ncpData;
            }

            // 参数
            Map<String, Object> map = new HashMap();
            map.put("version", systemInfo.getNcpApiVersion());
            map.put("appid", systemInfo.getWeatherAppid());
            map.put("appsecret", systemInfo.getWeatherAppSecret());
            ncpData = HttpUtil.sendGet(systemInfo.getNcpApiUrl(),
                    "version=" + systemInfo.getNcpApiVersion() + "&appid=" + systemInfo.getWeatherAppid() + "&appsecret=" + systemInfo.getWeatherAppSecret(),
                    "GBK");
            if (null == ncpData) {
               throw new BaseException("新冠病毒疫情数据不存在");
            }
            // 保持数据到redis（有超时时间）
            redisBaseService.set(BaseConstants.REDIS_KEY.NCP_DATA, ncpData, systemInfo.getNcpDataTimeout());
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return ncpData;
    }
}
