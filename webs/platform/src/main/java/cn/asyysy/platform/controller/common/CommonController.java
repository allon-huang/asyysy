package cn.asyysy.platform.controller.common;


import cn.asyysy.app.consts.BaseConsts;
import cn.asyysy.app.controller.BaseController;
import cn.asyysy.app.model.wechat.WxConfig;
import cn.asyysy.app.service.redis.RedisBaseService;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("common")
@RestController
public class CommonController extends BaseController {
    
    /**
     redis 服务层
     */
    @Autowired
    private RedisBaseService redisBaseService;


    /**
     * 系统信息
     * @return
     */
    @RequestMapping("sysInfo")
    public Object getSysInfo(){
        return systemInfo();
    }

    /**
     * 微信token信息
     * @return
     */
    @RequestMapping("wxConfig")
    public Object getWxConfig(){
        Object wxConfig = redisBaseService.get(BaseConsts.REDIS_KEY.WX_INFO);
        return (null == wxConfig) ? null: JSON.parseObject(wxConfig.toString(), WxConfig.class);
    }
}
