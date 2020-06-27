package cn.asyysy.app.service.user.impl;

import cn.asyysy.app.common.token.TokenUtil;
import cn.asyysy.app.consts.BaseConsts;
import cn.asyysy.app.exception.BaseException;
import cn.asyysy.app.mapper.user.UserMapper;
import cn.asyysy.app.model.core.User;
import cn.asyysy.app.service.user.UserService;
import cn.asyysy.app.util.StringUtil;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import io.jsonwebtoken.Claims;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author huangyaoyu
 * @since 2019-05-08
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    /**
     * log日志
     */
    public static Logger logger = (Logger) LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    private UserMapper userMapper;

    @Override
    public Page<User> selectPage(User user, Page<User> page) {

        return null;
    }

    
    @Override
    public User checkLoginThrowException(HttpServletRequest request) {
        // 获取session中的用户信息
        Object user = request.getSession().getAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY);
        boolean loginFlag = (null == user);
        logger.info("user/getUser-是否登录：" + !loginFlag);
        // 未登录
        if (loginFlag) {
            throw new BaseException(BaseConsts.MSG.UN_ON_LINE);
        }
        // 获取请求头的token
        String token=request.getHeader("Authorization");
        // 请求头token是否为空
        boolean tokenFlag = true;
        if (StringUtils.isEmpty(token)) {
            tokenFlag = false;
        }

        boolean cookieTokenFlag = true;
        Cookie[] cookies = request.getCookies();
        if (null == cookies || cookies.length == 0) {
            cookieTokenFlag = false;
        }
        String cookieToken = "";
        for (Cookie cookie: cookies ) {
            String cookieName = cookie.getName();
            if (StringUtils.isNotEmpty(cookieName) && "token".equals(cookieName)) {
                cookieToken = cookie.getValue();
                break;
            }        
        }
        if (StringUtils.isEmpty(token) && StringUtils.isEmpty(cookieToken) ) {
            throw new BaseException("TOKEN为空");
        }
        // 请求头token为空取cookie中的
        if (StringUtils.isEmpty(token)) {
            token = cookieToken;
        }
        // 获取token中的用户信息
        Claims claims = TokenUtil.parseJWT(token);
        if (null == claims || claims.isEmpty()) {
            throw new BaseException("TOKEN失效");
        }
        User vo = new User();
        vo.setUserName(claims.getId());
        User bean = userMapper.selectOne(vo);
        if (null == bean) {
            throw new BaseException("用户不存在");
        }
        return bean;
    }

    @Override
    public User checkLogin(HttpServletRequest request) {
        EntityWrapper<User> ew = new EntityWrapper<>();
        ew.where("user_name={0}", request.getParameter("userName"));
        this.userMapper.selectList(ew);
        try {
            // 验证是否登录
            return this.checkLoginThrowException(request);
        } catch (BaseException e) {
            logger.error(e.getMessage(), e);
        } catch (Exception e) {
            logger.error("系统错误", e);
        }
        return null;
    }
}
