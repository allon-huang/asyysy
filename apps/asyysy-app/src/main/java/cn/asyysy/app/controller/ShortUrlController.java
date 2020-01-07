package cn.asyysy.app.controller;

import cn.asyysy.app.exception.BaseException;
import cn.asyysy.app.model.common.ApiResponse;
import cn.asyysy.app.model.short_url.ShortUrl;
import cn.asyysy.app.service.redis.RedisBaseService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONPObject;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;

/**
 * 短网址-前台控制器
 * @author hyy
 */
@Controller
@RequestMapping("d")
public class ShortUrlController extends BaseController {
    /** log日志. */
    private static Logger logger = (Logger) LoggerFactory.getLogger(ShortUrlController.class);

    @Autowired
    private RedisBaseService redisBaseService;

    @RequestMapping(value = "saveUrl")
    @ResponseBody
    public Object saveShortUrl(){
        redisBaseService.saveShortUrl("http://www.asyysy.cn");
        return "success";
    }

    @RequestMapping(value = "/{url}")
    @ResponseBody
    public Object shortUrl(HttpServletResponse response, @PathVariable (value="url") String url){
        try{
            // 是否存在短网址
            ShortUrl d =  redisBaseService.get(url);
            if (null == d) {
                throw new BaseException("短网址不存在，请确认后继续操作");
            }
            // 重定向到长网址
            response.sendRedirect(d.getLongUrl());
            return ApiResponse.createSuccessResponse("success", JSONArray.toJSONString(d));
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return ApiResponse.createFailResponse(e.getMessage() );
        } catch (Exception e){
            logger.error("短网址跳转异常:{}", e.getMessage(), e);
            return ApiResponse.createFailResponse("短网址异常", e);
        }
    }
}
