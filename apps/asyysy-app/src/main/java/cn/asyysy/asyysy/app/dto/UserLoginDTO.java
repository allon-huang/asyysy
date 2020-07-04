package cn.asyysy.asyysy.app.dto;

import lombok.Data;

import java.util.Date;

/**
 * 登录用户dto
 * @author hyy
 */
@Data
public class UserLoginDTO {

    /**
     * 数据编号
     */
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

    /**
     * 系统登录token id
     */
    private String authorization;
}
