package cn.asyysy.platform.controller;

import cn.asyysy.app.common.SendmailUtil;
import cn.asyysy.app.controller.BaseController;
import cn.asyysy.app.model.WxReplyModel;
import cn.asyysy.app.service.user.WxReplyModelService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author hyy21
 */
@Controller
public class IndexController extends BaseController {
    /*@Autowired
    private WxReplyModelService wxReplyModelService;*/

    private final WxReplyModelService wxReplyModelService;

    public IndexController(WxReplyModelService wxReplyModelService) {
        this.wxReplyModelService = wxReplyModelService;
    }

    @RequestMapping(value = "index")
    public String index(@RequestParam Map<String,Object> params, HttpServletRequest request) {
        List<WxReplyModel> wxReplys =  wxReplyModelService.selectWxReplyModelList();
        request.setAttribute("list",wxReplys);
        logger.info("wx_token:{}", environment().getProperty("wx_token"));
        return  "index";
    }

    @ResponseBody
    @RequestMapping(value = "/indexJson")
    public Object indexJson(@RequestParam Map<String,Object> params,HttpServletRequest request){
        DateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        logger.info("==============================MainController=====调用时间{}=indexJson=========params：{}"
                , format1.format(new Date()), params.toString());
        List<WxReplyModel> wxReplys =  wxReplyModelService.selectWxReplyModelList();
        request.setAttribute("list",wxReplys);
        logger.info("wx_token:{}", environment().getProperty("wx_token"));
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
        logger.info("==============================MainController=====调用时间{}mail：E_mail:{}}|title:{}|content:{}",
                format1.format(new Date()), mail, title, content);
        return 200;
    }
}
