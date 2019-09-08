package cn.asyysy.app.intercepter;

import cn.asyysy.common.JsonResult;
import cn.asyysy.consts.BaseConsts;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.logging.Logger;

/**
 * @author admin
 */
@Component
public class ApiUserIntercepter extends HandlerInterceptorAdapter {

    Logger logger = Logger.getLogger("ApiUserIntercepter");

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //每一个项目对于登陆的实现逻辑都有所区别，我这里使用最简单的Session提取User来验证登陆。
        HttpSession session = request.getSession();
        Object user = session.getAttribute(BaseConsts.COMMON.SESSION_API_USER_KEY);
        logger.info("####################" + request.getRequestURL() + "|user:" + user);
        String requestUrl = request.getRequestURL().toString();
        if(null == user){
            /*if(requestUrl.contains("/api/user")){
                response.sendError(1,"用户未登录");
            }else{y
                logger.info("------:正在跳转到login页面...");
                response.sendRedirect(request.getContextPath()+"/index");
            }*/
            response.sendError(JsonResult.ERROR,BaseConsts.MSG.UN_ON_LINE);
            return false;
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {
    }

}
