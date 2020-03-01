package cn.asyysy.platform.controller.common;


import cn.asyysy.app.annotation.PassToken;
import cn.asyysy.app.consts.BaseConsts;
import cn.asyysy.app.controller.BaseController;
import cn.asyysy.app.exception.BaseException;
import cn.asyysy.app.model.common.ApiResponse;
import cn.asyysy.app.model.wechat.WxConfig;
import cn.asyysy.app.service.redis.RedisBaseService;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@PassToken
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
        try {
            return ApiResponse.SUCCESS("获取系统信息成功", systemInfo());
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return ApiResponse.ERROR(e.getMessage());
        } catch (Exception e){
            logger.error("保存短网址异常:{}", e.getMessage(), e);
            return ApiResponse.ERROR("保存短网址异常", e);
        }
    }

    /**
     * 微信token信息
     * @return
     */
    @RequestMapping("wxConfig")
    public Object getWxConfig(){
        try {
            Object wxConfig = redisBaseService.get(BaseConsts.REDIS_KEY.WX_INFO);
            return ApiResponse.SUCCESS("获取微信token信息", (null == wxConfig) ? null: JSON.parseObject(wxConfig.toString(), WxConfig.class));
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return ApiResponse.ERROR(e.getMessage());
        } catch (Exception e){
            logger.error("保存短网址异常:{}", e.getMessage(), e);
            return ApiResponse.ERROR("保存短网址异常", e);
        }
    }

    /**
     * 新冠病毒信息
     * @return
     */
    @RequestMapping("ncpInfo")
    public Object getNcpInfo(){
        try {
            Object wxConfig = redisBaseService.get(BaseConsts.REDIS_KEY.WX_INFO);
            return ApiResponse.SUCCESS("获取新型肺炎信息", commonService.ncpApi());
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return ApiResponse.ERROR(e.getMessage());
        } catch (Exception e){
            logger.error("保存短网址异常:{}", e.getMessage(), e);
            return ApiResponse.ERROR("保存短网址异常", e);
        }
    }
}
