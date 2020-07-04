package cn.asyysy.asyysy.app.model.wechat;

import lombok.Data;

import java.util.Date;

@Data
public class WxMessage {
    /**
     * 主键
     */
    private Integer pkid;
    /**
     * openId
     */
    private  String openId;
    /**
     * 消息内容
     */
    private  String message;
    /**
     * 整体报文
     */
    private  String allMessage;
    /**
     * 消息类型
     */
    private  String type;
    /**
     * 消息创建时间
     */
    private Date date;

    public WxMessage(String openId, String message, String allMessage, String type, Date date) {
        this.openId = openId;
        this.message = message;
        this.allMessage = allMessage;
        this.type = type;
        this.date = date;
    }
}
