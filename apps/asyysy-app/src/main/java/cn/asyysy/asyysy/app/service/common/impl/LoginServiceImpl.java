package cn.asyysy.asyysy.app.service.common.impl;

import cn.asyysy.asyysy.app.common.token.TokenUtil;
import cn.asyysy.asyysy.app.dto.UserLoginDTO;
import cn.asyysy.asyysy.app.listener.SessionListener;
import cn.asyysy.asyysy.app.model.core.User;
import cn.asyysy.asyysy.app.service.common.LoginService;

import cn.asyysy.asyysy.app.service.user.UserService;
import cn.asyysy.asyysy.app.service.user.impl.UserServiceImpl;
import cn.asyysy.asyysy.common.constants.BaseConstants;
import cn.asyysy.asyysy.common.exception.BaseException;
import cn.asyysy.asyysy.common.utils.HttpServletUtil;
import cn.asyysy.asyysy.common.utils.StringUtil;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import io.jsonwebtoken.Claims;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 登录逻辑
 * @author hyy
 */
@Service
public class LoginServiceImpl implements LoginService {
    /**
     * log日志
     */
    public static Logger logger = (Logger) LoggerFactory.getLogger(UserServiceImpl.class);

    /**
     * 用户信息
     */
    @Autowired
    UserService userService;

    /**
     * 校验登录
     * @return User
     * @throws BaseException
     */
    @Override
    public UserLoginDTO checkLogin() throws BaseException {
        HttpServletRequest request = HttpServletUtil.getRequest();
        // 获取Authorization
        String[] authorizations = HttpServletUtil.getAuthorization(request);
        Claims claims;
        UserLoginDTO loginUser;
        try {
            if (null == authorizations) {
                throw new BaseException("TOKEN为空");
            }
            // 
            String authorization = authorizations[0];
            String authorizationType = authorizations[1];
            // 获取token中的用户信息
            claims = TokenUtil.parseJWT(authorization);
            if (null == claims || claims.isEmpty()) {
                throw new BaseException("TOKEN失效");
            }
            // Jwt超时时间
            Date expiration = claims.getExpiration();
            if (null == expiration || System.currentTimeMillis() > expiration.getTime()) {
                throw new BaseException("登录信息超时");
            }
            if (BaseConstants.LOGIN.AUTH_TOKEN_ID_SESSION.equals(authorizationType)) {
                loginUser = (UserLoginDTO)HttpServletUtil.getSession().getAttribute(BaseConstants.LOGIN.SESSION_ID);
            } else {
                // 查看用户是否存在
                EntityWrapper<User> ew = new EntityWrapper();
                ew.where("user_name={0}", claims.getId());
                User userDb = this.userService.selectOne(ew);
                if (null == userDb) {
                    throw new BaseException("用户不存在");
                }
                loginUser = new UserLoginDTO();
                // copy字段值
                BeanUtils.copyProperties(userDb, loginUser);
                loginUser.setAuthorization(authorizations[0]);
            }            
            logger.warn("用户【{}】超时时间-{}-剩余时间-{}秒", loginUser.getUserName(), expiration, (expiration.getTime() - System.currentTimeMillis()) / 1000);
        } catch (BaseException e) {
            this.logout();
            throw e;
        } catch (Exception e) {
            this.logout();
            throw new BaseException("登录信息超时");
        }

        // session中的用户信息为空重新session
        Object obj = request.getSession().getAttribute(BaseConstants.LOGIN.SESSION_ID);
        if (null == obj) {
            // cookie中用户生效 自动将user 放到session中
            request.getSession().setAttribute(BaseConstants.LOGIN.SESSION_ID, loginUser);
        }
        return loginUser;
    }

    /**
     * 获取登录用户信息
     * @return user
     */
    @Override
    public UserLoginDTO userInfo() {
        try {
            // 校验登录
            return this.checkLogin();
        } catch (Exception e) {
            logger.info(e.getMessage());
        }
        return null;
    }

    @Override
    public String getAuthorization() {
        Object authorization = HttpServletUtil.getSession().getAttribute(BaseConstants.LOGIN.AUTH_TOKEN_ID);
        if (null == authorization) {
            return null;
        }        
        return authorization.toString();
    }

    /**
     * 退出登录
     */
    @Override
    public void logout() {
        HttpServletRequest request = HttpServletUtil.getRequest();
        HttpServletResponse response = HttpServletUtil.getResponse();
        // 获取Authorization
        String[] authorization = HttpServletUtil.getAuthorization(request);
        if (null == authorization) {
            return;
        }
        // Authorization
        Cookie cooikeAuthorization = new Cookie(BaseConstants.LOGIN.AUTH_TOKEN_ID, authorization[0]);
        cooikeAuthorization.setMaxAge(0);
        response.addCookie(cooikeAuthorization);
        // 移除 Seesion 登录 信息
        request.getSession().removeAttribute(BaseConstants.LOGIN.SESSION_ID);
        // 移除 Seesion 中的authorization
        request.getSession().removeAttribute(BaseConstants.LOGIN.AUTH_TOKEN_ID);
        String backUrl = request.getParameter("backUrl");
        // 退出登录回调
        if (StringUtil.isEmpty(backUrl)) {
            return;
        }
        try {
            response.sendRedirect(backUrl);
        } catch (IOException e) {
            logger.error("退出登录回调地址：{}-失败：{}", backUrl, e.getMessage(), e);
        }
    }

    /**
     * 登录
     * @param userName 用户名
     * @param password 密码
     */
    @Override
    public void login(String userName, String password) {
        HttpServletRequest request = HttpServletUtil.getRequest();
        HttpServletResponse response = HttpServletUtil.getResponse();
        HttpSession session = request.getSession();
        String sessionId = session.getId();
        logger.info("user/login-sessisID:" + sessionId);
        // 校验是否登录
        UserLoginDTO userLogined = this.userInfo();
        if (null != userLogined) {
            throw new BaseException("已登录");
        }
        if (StringUtils.isEmpty(userName)) {
            throw new BaseException("用户名不可为空");
        }
        if (StringUtils.isEmpty(password)) {
            throw new BaseException("用户名密码不可为空");
        }

        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.where("user_name={0}", userName);
        User user = userService.selectOne(entityWrapper);
        if (user == null) {
            throw new BaseException("用户不存在");
        }
        if (!password.equals(user.getPassword())) {
            throw new BaseException("用户密码错误");
        }
        // 登录用户dto
        UserLoginDTO userDTO = new UserLoginDTO();
        // copy字段值
        BeanUtils.copyProperties(user, userDTO);
        String token = TokenUtil.createJwtToken(userName);
        // session超时时间
        session.setMaxInactiveInterval(Integer.valueOf(BaseConstants.LOGIN.SESSION_TIMEOUT));
        session.setAttribute(BaseConstants.LOGIN.SESSION_ID, userDTO);
        session.setAttribute(BaseConstants.LOGIN.AUTH_TOKEN_ID, token);
        // Authorization
        Cookie cooikeAuthorization = new Cookie(BaseConstants.LOGIN.AUTH_TOKEN_ID, token);
        //cooikeAuthorization.setDomain(StringUtil.removeUrlHttp(systemInfo().getDomain()));
        cooikeAuthorization.setMaxAge(60 * 60 * 24);
        response.addCookie(cooikeAuthorization);
        AtomicInteger userCount = SessionListener.userCount;
        userCount.set(userCount.getAndIncrement() + 1);
    }
}
