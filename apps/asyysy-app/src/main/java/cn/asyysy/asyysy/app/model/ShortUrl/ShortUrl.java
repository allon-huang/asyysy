package cn.asyysy.asyysy.app.model.ShortUrl;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class ShortUrl implements Serializable {
    /**
     * 主键
     */
    @TableId(value = "pkid",type = IdType.AUTO)
    private Long pkid;

    /**
     * 短网址路径
     */
    private String shortUrl;
    /**
     * 长网址路径
     */
    private String longUrl;
    /**
     * 短网址唯一码
     */
    private String shortCode;
    /**
     * 创建时间
     */
    private Date cDate;
    /**
     * 转发次数
     */
    private Long redirctTime;
}
