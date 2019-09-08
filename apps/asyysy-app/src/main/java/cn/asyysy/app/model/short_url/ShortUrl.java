package cn.asyysy.app.model.short_url;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class ShortUrl implements Serializable {
    /**
     * 短网址路径
     */
    private String shortUrl;
    /**
     * 长网址路径
     */
    private String longUrl;
    /**
     * 请求的路径
     */
    private String pathUrl;
    /**
     * 创建时间
     */
    private Date cDate;
    /**
     * 转发次数
     */
    private Long redirctTime;
}
