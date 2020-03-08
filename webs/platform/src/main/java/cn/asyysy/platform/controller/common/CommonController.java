package cn.asyysy.platform.controller.common;


import cn.asyysy.app.annotation.PassToken;
import cn.asyysy.app.consts.BaseConsts;
import cn.asyysy.app.controller.BaseController;
import cn.asyysy.app.exception.BaseException;
import cn.asyysy.app.model.common.ApiResponse;
import cn.asyysy.app.model.wechat.WxConfig;
import cn.asyysy.app.service.redis.RedisBaseService;
import cn.asyysy.app.util.HttpClientUtil;
import cn.asyysy.app.util.SendmailUtil;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


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
    @PassToken
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
    @PassToken
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
    @PassToken
    @RequestMapping("ncpInfo")
    public Object getNcpInfo(HttpServletResponse response){
        try {
            response.setHeader("Access-Control-Allow-Origin", "*");
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

    /**
     * 重名查询
     * @return
     */
    @PassToken
    @RequestMapping("getCommonName")
    public ApiResponse getCommonName(@RequestBody Map<String, String> params){
        try {
            String name = params.get("name");
            if (StringUtils.isEmpty(name)) {
               throw new BaseException("请输入需要查询的名字");
            }
            Map<String, String> map = new HashMap<>();
            map.put("name", name);
            // 辽宁公安重名查询
            String result = HttpClientUtil.doGet("https://m.zwfw.gat.ln.gov.cn//api/query/countName", map);
            return ApiResponse.SUCCESS("获取重名查询数据", result);
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return ApiResponse.ERROR(e.getMessage());
        } catch (Exception e){
            logger.error("保存短网址异常:{}", e.getMessage(), e);
            return ApiResponse.ERROR("保存短网址异常", e);
        }
    }

    /**
     * 发送邮件
     * @param mail 接收方邮件地址
     * @param title 邮件标题
     * @param content 邮件正文内容
     * @return
     */
    @RequestMapping(value = "/mail")
    @ResponseBody
    public Object mail(@RequestParam("mail") String mail, @RequestParam("title")String title, @RequestParam("content")String content){
        DateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        try {
            SendmailUtil.sendEmail(mail,title,content);
        } catch (Exception e) {
            return 500;
        }
        logger.info("==============================MainController=====调用时间{}mail：E_mail:{}}|title:{}|content:{}",
                format1.format(new Date()), mail, title, content);
        return 200;
    }
}
