package cn.asyysy.api.wechat;



import cn.asyysy.app.model.WxMessage;
import cn.asyysy.app.model.WxReplyModel;
import cn.asyysy.app.model.wechat.TextMeaasge;
import cn.asyysy.app.service.user.WxMainService;
import cn.asyysy.app.service.user.WxReplyModelService;
import cn.asyysy.common.wechat.CheckoutUtil;
import cn.asyysy.common.wechat.MessageUtil;
import org.dom4j.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@RestController
@RequestMapping(value = "mp")
public class WxMpConroller {
    Logger  logger = Logger.getLogger("WxMpConroller");

    @Autowired
    private WxMainService wxMainService;
    @Autowired
    private WxReplyModelService wxReplyModelService;
 /*   // 与接口配置信息中的Token要一致
    private static String token = "";
    @Autowired
    private Environment env;
    //servet 初始化时加载该方法
    @PostConstruct
    public void init() {
        token =env.getProperty("wx_token");
    }
*/
    @GetMapping(value = "token")
    public String  geTokenGetForWx(Model model, @RequestParam Map<String,Object> params, HttpServletRequest request){
        logger.info("=============开始验证（Token）=================geTokenGetForWx===============params：" + params.toString());
        // 微信加密签名
        String signature = params.get("signature") + "";
        // 时间戳
        String timestamp = params.get("timestamp") + "";
        // 随机数
        String nonce = params.get("nonce") + "";
        // 随机字符串
        String echostr = params.get("echostr") + "";
        // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
        boolean checkResult = CheckoutUtil.checkSignature(signature, timestamp, nonce);
        logger.info("=============正在验证（Token）====loading....===================通过检验signature结果：" + checkResult);
        String returnStr = (signature != null && checkResult)?echostr:"";
        logger.info("=============验证完成（Token）=============================returnStr：" + returnStr);
        return returnStr;
    }


    @PostMapping(value = "token")
    public Object geTokenPostForWx( @RequestParam Map<String,Object> params,HttpServletRequest request)throws IOException, DocumentException {
        logger.info("=============开始处理（信息）=====================POST==============params：" + params.toString());
        Map<String, String> map = MessageUtil.xmlToMap(request);
        // 发送方帐号（一个OpenID）
        String fromUserName = map.get("FromUserName");
        // 开发者微信号
        String toUserName = map.get("ToUserName");
        // 消息类型
        String msgType = map.get("MsgType");
        // 默认回复一个"success"
        String responseMessage = "success";
        // 用户输入的消息
        String message=map.get("Content");
         //保存数据
        WxMessage wx = new WxMessage(fromUserName,message,map.toString(),msgType,new Date());
        //调用线程处理
        //startMonitor(new WxMessage(fromUserName,message,map.toString(),msgType,new Date()));
        wxMainService.inserWxInCharge(wx);
        // 对文本消息进行处理
        if(MessageUtil.EVENT_TYPE_SUBSCRIBE.equals(msgType)) {
            //事件类型：subscribe(订阅)

        }
        else if(MessageUtil.EVENT_TYPE_UNSUBSCRIBE.equals(msgType)) {
            //事件类型：unsubscribe(取消订阅)
        }
        else if(MessageUtil.EVENT_TYPE_CLICK.equals(msgType)) {
            // 事件类型：CLICK(自定义菜单点击事件)
        }
        else if(MessageUtil.REQ_MESSAGE_TYPE_EVENT.equals(msgType)) {
            // 请求消息类型：推送

        }else if (MessageUtil.RESP_MESSAGE_TYPE_TEXT.equals(msgType)) {
            // 文本消息
             TextMeaasge textMessage=new TextMeaasge();
             textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
             textMessage.setToUserName(fromUserName);
             //注意这里的toUserName 是刚才接收xml中的FromUserName
             textMessage.setFromUserName(toUserName);
             textMessage.setCreateTime(System.currentTimeMillis());
             String str = new String(message);

             //System.out.println("str-------"+str);
            List<WxReplyModel> wxReplys =  wxReplyModelService.selectWxReplyModelByKeyword(str);
             if(wxReplys != null && wxReplys.size() != 0  ){
                 str = wxReplys.get(0).getReplyText();
                 textMessage.setContent(str);
                 responseMessage = MessageUtil.textMessageToXML(textMessage);
                 // 更新回复次数
                 wxReplyModelService.updateReplyModelSendTime(wxReplys.get(0).getPkid());
             }
         }else if(MessageUtil.REQ_MESSAGE_TYPE_VOICE.equals(msgType)){
            // 请求消息类型：音频
             // 文本消息
             TextMeaasge textMessage=new TextMeaasge();
             textMessage.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
             textMessage.setToUserName(fromUserName);
             //注意这里的toUserName 是刚才接收xml中的FromUserName
             textMessage.setFromUserName(toUserName);
             textMessage.setCreateTime(System.currentTimeMillis());
             //System.out.println("str-------"+str);
             textMessage.setContent("你发送了一个语音消息");
             responseMessage = MessageUtil.textMessageToXML(textMessage);
        }else if(MessageUtil.RESP_MESSAGE_TYPE_MUSIC.equals(msgType)) {
            /**      * 请求消息类型：文本      */
            //public static final String REQ_MESSAGE_TYPE_TEXT = "text";
            /**      * 请求消息类型：图片      */
           // public static final String REQ_MESSAGE_TYPE_IMAGE = "image";
            /**      * 请求消息类型：链接      */
           // public static final String REQ_MESSAGE_TYPE_LINK = "link";
            /**      * 请求消息类型：地理位置      */
            //public static final String REQ_MESSAGE_TYPE_LOCATION = "location";
            /**      * 请求消息类型：音频      */
            //public static final String REQ_MESSAGE_TYPE_VOICE = "voice";
            /**      * 请求消息类型：推送      */
            //public static final String REQ_MESSAGE_TYPE_EVENT = "event";
        }
        logger.info("=============处理结束（信息）=====================POST==============结果");
        logger.info(responseMessage);
        //System.out.println("=============处理结束（信息）=====================POST==============结果：" + responseMessage);
        return responseMessage;
    }

/*
    public String dateFormat(){
        Calendar now = Calendar.getInstance();
        System.out.println("年：" + now.get(Calendar.YEAR));
        System.out.println("月：" + (now.get(Calendar.MONTH) + 1));
        System.out.println("日：" + now.get(Calendar.DAY_OF_MONTH));
        System.out.println("时：" + now.get(Calendar.HOUR_OF_DAY));
        System.out.println("分：" + now.get(Calendar.MINUTE));
        System.out.println("秒：" + now.get(Calendar.SECOND));
        //使用Date
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //System.out.println("当前时间：" + sdf.format(d));
        return sdf.format(d);
    }

    public void startMonitor(WxMessage wx) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                System.out.println("线程启动");
                if(wx != null){
                    execuInsert(wx);
                }else{
                    System.out.println("线程启动失败");
                }
            }
        }).start();
    }

    public void execuInsert(WxMessage wx){
        boolean result = wxMainService.inserWxInCharge(wx);
        System.out.println("线程启动成功+结果" + result);
    }
*/


}