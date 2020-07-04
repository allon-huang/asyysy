package cn.asyysy.asyysy.app.model.wechat;

import lombok.Data;

@Data
public class WxConfig {
    /**
     * 生成签名的时间戳
     */
    private String timestamp;

    /**
     * 生成签名的随机串
     */
    private String nonceStr;

    /**
     * 签名
     */
    private String signature;

    /**
     * 微信appid
     */
    public String appid;
}
