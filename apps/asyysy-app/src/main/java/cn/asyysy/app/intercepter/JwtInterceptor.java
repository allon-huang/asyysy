package cn.asyysy.app.intercepter;

import cn.asyysy.app.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JwtInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    //RedisUtil redisUtil;

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {
        String token = request.getHeader("Authorization");
        if (token == null) {
            response.setStatus(401);
            return false;
        }
        String account = JwtUtil.getAccount(token);
        String sessionToken = (String)request.getSession().getAttribute(account);
        //String redisToken = redisUtil.get(RedisKey.TP_STORE_KEY + account);
        boolean isExpire = JwtUtil.checkToken(token, account);

        if (sessionToken == null || sessionToken != token || isExpire) {
            response.setStatus(401);
            return false;
        }
        return true;
    }
}
