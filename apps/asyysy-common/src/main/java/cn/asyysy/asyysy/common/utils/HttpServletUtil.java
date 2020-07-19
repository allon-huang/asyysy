package cn.asyysy.asyysy.common.utils;

import cn.asyysy.asyysy.common.constants.BaseConstants;
import cn.asyysy.asyysy.common.exception.BaseException;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * HttpServlet工具栏
 *
 * @author hyy
 */
public class HttpServletUtil {

    /**
     * 获取 HttpServletRequest
     * @return
     */
    public static HttpServletRequest getRequest() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        return request;
    }

    /**
     * 获取 HttpServletResponse
     * @return
     */
    public static HttpServletResponse getResponse() {
        HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getResponse();
        return response;
    }

    /**
     * 获取 Session
     * @return
     */
    public static HttpSession getSession() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        return request.getSession();
    }

    /**
     * 根据cookie获取Cookie
     * @param name
     * @param request
     * @return
     */
    public static Cookie getCookieByName(String name, HttpServletRequest request) {
        if (StringUtils.isEmpty(name)) {
            throw new BaseException("cookie name不可为空");
        }
        Cookie[] cookies = request.getCookies();
        if (null == cookies || cookies.length == 0) {
            return null;
        }
        Cookie temp = null;
        for (Cookie cookie : cookies) {
            String cookieName = cookie.getName();
            if (StringUtils.isEmpty(cookieName)) {
                continue;
            }
            if (name.equals(cookieName)) {
                temp = cookie;
                break;
            }
        }
        return temp;
    }


    /**
     * 获取Authorization
     * @param request
     * @return 
     *  [0] Authorization
     *  [1] Authorization type
     */
    public static String[] getAuthorization(HttpServletRequest request) {
        // Seesion 中的authorization
        Object sessionAuthorization = request.getSession().getAttribute(BaseConstants.LOGIN.AUTH_TOKEN_ID);
        if (null != sessionAuthorization) {
            return new String[]{sessionAuthorization.toString(), BaseConstants.LOGIN.AUTH_TOKEN_ID_SESSION};
        }
        
        // 获取请求头的token
        String token = request.getHeader(BaseConstants.LOGIN.AUTH_TOKEN_ID);
        if (StringUtil.isNotEmpty(token)) {
            return new String[]{token, BaseConstants.LOGIN.AUTH_TOKEN_ID_HEADER};
        } else {
            Cookie authorizationCookie = HttpServletUtil.getCookieByName(BaseConstants.LOGIN.AUTH_TOKEN_ID, request);
            if (StringUtils.isEmpty(token) && null != authorizationCookie && StringUtils.isNotEmpty(authorizationCookie.getValue())) {
                return new String[]{authorizationCookie.getValue(), BaseConstants.LOGIN.AUTH_TOKEN_ID_COOKIE};
            }
        }
        return null;
    }
}
