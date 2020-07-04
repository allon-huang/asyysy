package cn.asyysy.asyysy.app.service.common;

import cn.asyysy.asyysy.app.dto.UserLoginDTO;
import cn.asyysy.asyysy.common.exception.BaseException;

/**
 * 登录逻辑
 * @author hyy
 */
public interface LoginService {

    /**
     * 校验登录
     * @return User
     * @throws BaseException
     */
    UserLoginDTO checkLogin() throws BaseException;

    /**
     * 获取登录用户信息
     * @return user
     */
    UserLoginDTO userInfo();

    /**
     * 获取Authorization
     * @return Authorization
     */
    String getAuthorization();

    /**
     * 退出登录
     */
    void logout();

    /**
     * 登录
     * @param userName 用户名
     * @param password 密码
     */
    void login(String userName, String password);
}
