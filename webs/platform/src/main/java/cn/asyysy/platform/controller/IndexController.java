package cn.asyysy.platform.controller;

import cn.asyysy.app.model.WxReplyModel;
import cn.asyysy.app.service.redis.RedisBaseService;
import cn.asyysy.app.service.user.WxMainService;
import cn.asyysy.app.service.user.WxReplyModelService;
import cn.asyysy.common.SendmailUtil;
import cn.asyysy.common.config.SystemInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author hyy21
 */
@Controller
public class IndexController {
    /**
     * 系统对应配置
     */
    @Autowired
    private SystemInfo systemInfo;

    Logger logger = Logger.getLogger("IndexController");
    @Autowired
    private WxMainService wxMainService;
    @Autowired
    private WxReplyModelService wxReplyModelService;

    @Autowired
    private RedisBaseService redisBaseService;
    @Autowired
    private Environment env;

    @RequestMapping(value = "index")
    public String index(@RequestParam Map<String,Object> params, HttpServletRequest request) {
        logger.info("==============================MainController===============params：" + params.toString());
        List<WxReplyModel> wxReplys =  wxReplyModelService.selectWxReplyModelList();
        request.setAttribute("list",wxReplys);
        logger.info(env.getProperty("wx_token"));
        return  "index";
    }

    @ResponseBody
    @RequestMapping(value = "/indexJson")
    public Object indexJson(@RequestParam Map<String,Object> params,HttpServletRequest request){
        DateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        logger.info("==============================MainController=====调用时间" + format1.format(new Date()) + "=indexJson=========params：" + params.toString());
        List<WxReplyModel> wxReplys =  wxReplyModelService.selectWxReplyModelList();
        request.setAttribute("list",wxReplys);
        logger.info(env.getProperty("wx_token"));
        return  wxReplys;
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
        logger.info("==============================MainController=====调用时间" + format1.format(new Date()) + "mail：E_mail:" + mail + "|title:" + title + "|content:" + content);
        return 200;
    }
}
