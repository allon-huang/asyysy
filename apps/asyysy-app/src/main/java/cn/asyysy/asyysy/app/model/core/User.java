package cn.asyysy.asyysy.app.model.core;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

import java.util.Date;

/**
 * <p>
 *
 * </p>
 *
 * @author huangyaoyu
 * @since 2019-05-08
 */
@Data
public class User {

    private static final long serialVersionUID = 1L;

    @TableId(value = "pkid", type = IdType.AUTO)
    private Long pkid;
    /**
     * 用户名
     */
    private String userName;
    /**
     * 密码
     */
    private String password;
    /**
     * 电子邮箱
     */
    private String eMail;
    /**
     * QQ号
     */
    private String qq;
    /**
     * 手机号
     */
    private String telphone;
    /**
     * qq登录openid
     */
    private String qqOpenId;
    /**
     * qq登录accessToken
     */
    private String qqAccessToken;
    /**
     * qq UnionId
     */
    private String qqUnionId;
    /**
     * 创建时间
     */
    private Date createDate;
    /**
     * 类型 默认1
     */
    private Integer type;
    /**
     * 最近更新时间
     */
    private Date updateDate;
}
