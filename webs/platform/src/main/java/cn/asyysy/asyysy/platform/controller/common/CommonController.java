package cn.asyysy.asyysy.platform.controller.common;


import cn.asyysy.asyysy.common.constants.BaseConstants;
import cn.asyysy.asyysy.app.controller.common.BaseController;
import cn.asyysy.asyysy.common.exception.BaseException;
import cn.asyysy.asyysy.common.rest.common.BaseResponse;
import cn.asyysy.asyysy.app.model.wechat.WxConfig;
import cn.asyysy.asyysy.app.service.redis.RedisBaseService;
import cn.asyysy.asyysy.common.utils.HttpClientUtil;
import cn.asyysy.asyysy.common.utils.SendmailUtil;
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

    @RequestMapping("sysInfo")
    public Object getSysInfo(){
        try {
            return BaseResponse.SUCCESS("获取系统信息成功", systemInfo());
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return BaseResponse.ERROR(e.getMessage());
        } catch (Exception e){
            logger.error("保存短网址异常:{}", e.getMessage(), e);
            return BaseResponse.ERROR("保存短网址异常", e);
        }
    }

    /**
     * 微信token信息
     * @return
     */

    @RequestMapping("wxConfig")
    public Object getWxConfig(){
        try {
            Object wxConfig = redisBaseService.get(BaseConstants.REDIS_KEY.WX_INFO);
            return BaseResponse.SUCCESS("获取微信token信息", (null == wxConfig) ? null: JSON.parseObject(wxConfig.toString(), WxConfig.class));
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return BaseResponse.ERROR(e.getMessage());
        } catch (Exception e){
            logger.error("微信token信息异常:{}", e.getMessage(), e);
            return BaseResponse.ERROR("微信token信息异常", e);
        }
    }

    /**
     * 新冠病毒信息
     * @return
     */

    @RequestMapping("ncpInfo")
    public Object getNcpInfo(HttpServletResponse response){
        try {
            response.setHeader("Access-Control-Allow-Origin", "*");
            Object wxConfig = redisBaseService.get(BaseConstants.REDIS_KEY.WX_INFO);
            return BaseResponse.SUCCESS("获取新型肺炎信息", commonService.ncpApi());
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return BaseResponse.ERROR(e.getMessage());
        } catch (Exception e){
            logger.error("保存短网址异常:{}", e.getMessage(), e);
            return BaseResponse.ERROR("保存短网址异常", e);
        }
    }

    /**
     * 重名查询
     * @return
     */

    @RequestMapping("getCommonName")
    public BaseResponse getCommonName(@RequestBody Map<String, String> params){
        try {
            String name = params.get("name");
            if (StringUtils.isEmpty(name)) {
               throw new BaseException("请输入需要查询的名字");
            }
            Map<String, String> map = new HashMap<>();
            map.put("name", name);
            // 辽宁公安重名查询
            String result = HttpClientUtil.doGet("https://m.zwfw.gat.ln.gov.cn//api/query/countName", map);
            return BaseResponse.SUCCESS("获取重名查询数据", result);
        } catch (BaseException e){
            logger.error(e.getMessage(), e);
            return BaseResponse.ERROR(e.getMessage());
        } catch (Exception e){
            logger.error("保存短网址异常:{}", e.getMessage(), e);
            return BaseResponse.ERROR("保存短网址异常", e);
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
